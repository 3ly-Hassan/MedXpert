import 'package:flutter/material.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'db_helper.dart';

class NotificationHelper {
  // static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  static late BuildContext theContext;
  static Future<void> initializeNotification() async {
    //Initialise the time zone database
    tz.initializeTimeZones();
    // initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
      macOS: null,
    );
    //
    await FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  static Future<int> generateNotificationId(BuildContext context) async {
    final patientId = MeasurementCubit.get(context).patient.sId;
    final int notificationIdFromDB = await DBHelper.getNotificationId();
    final int notificationId = int.parse(
        patientId!.substring(0, 5) + '$notificationIdFromDB',
        radix: 16);
    return notificationId;
  }

  static Future selectNotification(String? payload) async {
    print('hi azab 1');
    await Future.delayed(Duration(seconds: 3));
    print('hi azab 2');

    print('**************** payload : $payload!!!');
  }

  static Future createNotification({
    required int notificationId,
    required String title,
    required String body,
    required DateTime date,
    required TimeOfDay time,
    required String? payLoad,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'Basic Notifications',
      'Notification channel',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    // print('**********************${tz.local}');
    await FlutterLocalNotificationsPlugin().zonedSchedule(
      notificationId,
      title,
      body,
      tz.TZDateTime.from(
          date.add(Duration(hours: time.hour, minutes: time.minute)), tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: payLoad,
    );

    print('******** Notification Created Successfully');
    /*await FlutterLocalNotificationsPlugin().show(
      notificationId,
      title,
      time,
      platformChannelSpecifics,
      payload: payLoad,
    );*/
    /*
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'basic_channel',
        title: title,
        body: time,
        icon: 'resource://drawable/foo',
        payload: payLoad,
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateHelper.combineDateAndTime(
          date: date,
          time: time,
          dateParseFormat: k_dateFormat,
          is24HourFormat: false,
          defaultHour: 10,
          defaultMinute: 30,
        ),
      ),
      actionButtons: [
        NotificationActionButton(
          enabled: true,
          key: 'EDIT',
          label: 'EDIT',
        ),
        NotificationActionButton(
          enabled: true,
          key: 'FINISH',
          label: 'Mark as finished',
          buttonType: ActionButtonType.KeepOnTop,
        ),
      ],
    );*/
  }

  static Future<void> cancelNotification(String notificationId) async {
    // print('notificationId : $notificationId');
    try {
      await FlutterLocalNotificationsPlugin().cancel(
        int.parse(notificationId),
      );
      print('******** Notification Canceled Successfully');
    } catch (error) {
      print('-------------------* Notification not found !! *-------------');
    }
  }
  //
}
