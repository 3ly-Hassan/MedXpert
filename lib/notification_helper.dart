import 'package:awesome_notifications/awesome_notifications.dart';
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

  static Future<int> generateNotificationId(BuildContext context) async {
    final patientId = MeasurementCubit.get(context).patient.sId;
    final int notificationIdFromDB = await DBHelper.getNotificationId();
    final int notificationId = int.parse(
        patientId!.substring(0, 5) + '$notificationIdFromDB',
        radix: 16);
    return notificationId;
  }

  static Future createNotification({
    required int notificationId,
    required String title,
    required String body,
    required DateTime date,
    required TimeOfDay time,
    required String? payLoad,
    bool isForMe = false,
  }) async {
    //

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar.fromDate(
          date: date.add(Duration(hours: time.hour, minutes: time.minute))),
      actionButtons: isForMe
          ? <NotificationActionButton>[
              NotificationActionButton(
                label: 'Confirm',
                key: 'Confirm',
              ),
              NotificationActionButton(
                label: 'Reject',
                key: 'Reject',
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
