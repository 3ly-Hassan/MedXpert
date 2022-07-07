import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/date_helper.dart';
import 'package:final_pro/models/notification_models/local_notofocation_model.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import 'db_helper.dart';

class NotificationHelper {
  // static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/notification_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.green,
          ledColor: Colors.white,
          channelShowBadge: true,
          importance: NotificationImportance.Max,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static Future<int> generateGlobalNotificationId(BuildContext context) async {
    final patientId = MeasurementCubit.get(context).patient.sId;
    final int notificationIdFromDB = await DBHelper.getNotificationId();
    final int notificationId = int.parse(
        patientId!.substring(0, 5) + '$notificationIdFromDB',
        radix: 16);
    return notificationId;
  }

  static Future<int> generateLocalNotificationId() async {
    final int notificationIdFromDB = await DBHelper.getNotificationId();
    return notificationIdFromDB;
  }

  // int value, String dateTime
  static Future createNotification({
    required int notificationId,
    required String title,
    required String body,
    required DateTime date,
    required TimeOfDay time,
    bool isForMe = false,
    String? originalDate,
    String? originalTime,
    //
    String? medicationId,
    String? drugUniqueId,
    //
  }) async {
    //
    final String stringDate = DateHelper.getFormattedString(
        date: date, formattedString: kFormattedString);

    final String stringTime = time.toString().substring(10, 15);

    if (originalTime == null && originalDate == null) {
      originalDate = stringDate;
      originalTime = stringTime;
    }

    final dateTime = DateHelper.combineDateAndTime(
      date: '$originalDate',
      time: '$originalTime',
      dateParseFormat: kFormattedString,
    ).toIso8601String();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        payload: {
          'date': originalDate!,
          'time': originalTime!,
          'dateTime': dateTime,
          'medicationId':
              medicationId == null ? 'null medicationId' : medicationId,
          'drugUniqueId':
              drugUniqueId == null ? 'null drugUniqueId' : drugUniqueId,
        },
      ),
      schedule: NotificationCalendar.fromDate(
          date: date.add(Duration(hours: time.hour, minutes: time.minute))),
      actionButtons: isForMe
          ? <NotificationActionButton>[
              NotificationActionButton(
                label: kYes,
                key: kYes,
              ),
              NotificationActionButton(
                label: kNo,
                key: kNo,
              ),
              NotificationActionButton(
                label: kSnooze,
                key: kSnooze,
              ),
            ]
          : [],
    );
    //
    print('******** Notification Created Successfully');
  }

  static Future<void> cancelNotification(String notificationId) async {
    // print('notificationId : $notificationId');
    try {
      //
      await AwesomeNotifications().cancel(int.parse(notificationId));
      //
      print('******** Notification Canceled Successfully');
    } catch (error) {
      print('-------------------* Notification not found !! *-------------');
    }
  }
  //
}
