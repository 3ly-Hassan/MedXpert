import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/date_helper.dart';
import 'package:final_pro/db_helper.dart';
import 'package:final_pro/notification_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../constants.dart';
import '../../../models/notification_models/local_notofocation_model.dart';
import '../../../models/notification_models/response_notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  APIService apiService = APIService();

  Future getLocalNotificationList(String drugUniqueId) async {
    emit(NotificationLoadingState());
    List notificationList =
        await DBHelper.getNotificationsByDrugUniqueId(drugUniqueId);
    //delete the notification if it is outdated
    notificationList.forEach((element) {
      final flag = DateHelper.isPastDateAndTime2(element.date, element.time);
      if (flag) {
        DBHelper.deleteNotificationById(
            DBHelper.notificationTableName, element.notificationId);
      }
    });
    notificationList =
        await DBHelper.getNotificationsByDrugUniqueId(drugUniqueId);
    emit(GetNotificationListState(notificationList));
  }

  Future createReceivedNotifications(
    BuildContext context,
  ) async {
    List<ResponseNotificationModel>? responseList = await apiService
        .getRecentNotifications() as List<ResponseNotificationModel>?;

    if (responseList != null) {
      //
      // delete local notifications of followers that no longer exist in the server (which means that it was deleted)
      final allRows = await DBHelper.getAllNotification();
      //TODO:PROBLEM BIG O OF n^2
      allRows.forEach(
        (element) async {
          if (element.drugName.isNotEmpty) {
            bool isMatch = false;
            for (int i = 0; i < responseList.length; i++) {
              if (element.drugUniqueId == responseList[i].drugUniqueId &&
                  element.drugName == responseList[i].drugName &&
                  element.date == responseList[i].date &&
                  element.time == responseList[i].time) {
                isMatch = true;
                break;
              }
            }
            if (!isMatch) {
              await NotificationHelper.cancelNotification(
                  element.notificationId);
              await DBHelper.deleteNotification2(element);
            }
          }
        },
      );

      for (int i = 0; i < responseList.length; i++) {
        {
          final bool isPast = DateHelper.isPastDateAndTime2(
              responseList[i].date!, responseList[i].time!);
          if (isPast == false) {
            {
              // check if notification is already created previously
              final bool isFound = await DBHelper.isCreatedPreviously(
                responseList[i].drugUniqueId!,
                responseList[i].date!,
                responseList[i].time!,
                responseList[i].drugName!,
              );
              //
              if (isFound == false) {
                final int notificationId =
                    await NotificationHelper.generateNotificationId(context);

                await NotificationHelper.createNotification(
                  notificationId: notificationId,
                  title:
                      '${responseList[i].drugName!}      ${responseList[i].time}',
                  body: '${responseList[i].username} needs to take the dose',
                  date: DateHelper.parseDate(
                      responseList[i].date!, kFormattedString),
                  time: DateHelper.parseTime(responseList[i].time!),
                  payLoad: 'payLoad',
                );

                //Add notification To the local dateBase
                final LocalNotificationModel notificationModel =
                    LocalNotificationModel(
                  notificationId: '$notificationId',
                  drugUniqueId: responseList[i].drugUniqueId!,
                  drugName: responseList[i].drugName!,
                  date: responseList[i].date,
                  time: responseList[i].time,
                );
                await DBHelper.insertValue(
                  DBHelper.notificationTableName,
                  notificationModel,
                );
              }
            }
          }
        }
      }
    }
  }

  Future deleteNotification(String notificationId, String drugUniqueId,
      String date, String time, String username, String drugName) async {
    emit(NotificationLoadingState());
    await NotificationHelper.cancelNotification(notificationId);
    await DBHelper.deleteNotificationById(
        DBHelper.notificationTableName, notificationId);
    final List notificationList =
        await DBHelper.getNotificationsByDrugUniqueId(drugUniqueId);
    //
    //delete remote notification
    await apiService.deleteRemoteNotification(ResponseNotificationModel(
      time: time,
      date: date,
      drugName: drugName,
      drugUniqueId: drugUniqueId,
      username: username,
    ));
    //
    emit(GetNotificationListState(notificationList));
  }

  //used when deleting the drug it self not its notification
  Future deleteNotificationsByDrugUniqueId(
    String drugUniqueId,
  ) async {
    //
    final List<LocalNotificationModel> notificationList =
        await DBHelper.getNotificationsByDrugUniqueId(drugUniqueId);
    //
    if (notificationList.length != 0) {
      notificationList.forEach((element) async {
        await NotificationHelper.cancelNotification(element.notificationId!);
      });
      await DBHelper.deleteNotificationById(
          DBHelper.notificationTableName, notificationList[0].notificationId!);
    }
    //
    //delete remote notification
    await apiService.deleteRemoteNotificationByDrugUniqueId(drugUniqueId);
  }
}
