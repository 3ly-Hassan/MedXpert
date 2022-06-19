import 'package:bloc/bloc.dart';
import 'package:final_pro/date_helper.dart';
import 'package:final_pro/db_helper.dart';
import 'package:final_pro/notification_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future getNotificationList(String drugUniqueId) async {
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

  Future deleteNotification(String notificationId, String drugUniqueId) async {
    emit(NotificationLoadingState());
    await NotificationHelper.cancelNotification(notificationId);
    await DBHelper.deleteNotificationById(
        DBHelper.notificationTableName, notificationId);
    final List notificationList =
        await DBHelper.getNotificationsByDrugUniqueId(drugUniqueId);
    emit(GetNotificationListState(notificationList));
  }
}
