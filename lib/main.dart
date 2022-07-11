import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:final_pro/bloc_observer.dart';
import 'package:final_pro/cubits/Article_cubit/article_cubit.dart';
import 'package:final_pro/cubits/dialog_cubit/dialog_cubit.dart';
import 'package:final_pro/cubits/medication_cubits/medications_list_cubit/medications_list_cubit.dart';
import 'package:final_pro/cubits/medication_cubits/notification_cubit/notification_cubit.dart';
import 'package:final_pro/cubits/teams_cubit/teams_cubit.dart';
import 'package:final_pro/cubits/teams_cubit/teams_doctor_cubit/teams_doctor_cubit.dart';
import 'package:final_pro/date_helper.dart';
import 'package:final_pro/db_helper.dart';
import 'package:final_pro/notification_helper.dart';
import 'package:final_pro/pages/dash_bord/dash_bord.dart';
import 'package:final_pro/pages/logging_page/loging.dart';
import 'package:final_pro/pages/profile/profileScreen.dart';
import 'package:final_pro/pages/splash/splash_screen.dart';
import 'package:final_pro/routes.dart';
import 'package:final_pro/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'api_service/api_service.dart';
import 'cache_helper.dart';
import 'constants.dart';
import 'cubits/MeasuremetCubit/measurement_cubit.dart';
import 'cubits/medication_cubits/create_medication_cubit/create_medication_cubit.dart';
import 'cubits/medication_cubits/drugs_list_cubit/drugs_list_cubit.dart';
import 'cubits/medication_cubits/medication_cubit/medication_cubit.dart';
import 'cubits/teams_cubit/teams_patient_cubit/teams_patient_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await NotificationHelper.initializeNotification();
  bool isDark = CacheHelper.getData(key: 'isDark');

  String widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  role = CacheHelper.getData(key: 'role');

  if (onBoarding != null) {
    if (token != null)
      widget = DashBord.routeName;
    else {
      print('asd');
      widget = LoggingPage.routeName;
      splash = false;
    }
  } else {
    widget = SplashScreen.routeName;
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final String? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  // This widget is the root of your application updated.
  @override
  Widget build(BuildContext context) {
    //
    listenToNotificationActions(context);
    //

    //
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          if (role == 'patient') {
            print('ALi75');
            return MeasurementCubit()..getPatientProfile();
          } else if (role == 'doctor')
            return MeasurementCubit()..getdoctorProfile();
          else
            return MeasurementCubit();
        }),
        BlocProvider(
          create: (context) => TeamsCubit(),
        ),
        BlocProvider(
          create: (context) => DialogCubit(),
        ),
        BlocProvider(
          create: (context) => ArticleCubit(),
        ),
        BlocProvider(
          create: (context) => MedicationCubit(),
        ),
        BlocProvider(
          create: (context) => CreateMedicationCubit(),
        ),
        BlocProvider(
          create: (context) => MedicationsListCubit(),
        ),
        BlocProvider(
          create: (context) => DrugsListCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
        BlocProvider(
          create: (context) => TeamsDoctorCubit(),
        ),
        BlocProvider(
          create: (context) => TeamsPatientCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.light,
        // home: SplashScreen(),
        // We use routeName so that we don't need to remember the name
        initialRoute: startWidget,
        routes: routes,
      ),
    );
  }

  listenToNotificationActions(BuildContext context) {
    //
    AwesomeNotifications().actionStream.listen((receivedNotification) async {
      //
      if (receivedNotification.buttonKeyPressed == kYes) {
        await takeNotificationAction(receivedNotification, value: 1);

        print('Yes pressed');
      } else if (receivedNotification.buttonKeyPressed == kNo) {
        await takeNotificationAction(receivedNotification, value: 0);

        print('No pressed');
      } else if (receivedNotification.buttonKeyPressed == kSnooze) {
        print('Snooze pressed');
        await snoozeFunction(receivedNotification, context);
      }
    });
  }

  snoozeFunction(receivedNotification, context) async {
    final String originalDate = receivedNotification.payload!['date']!;
    final String originalTime = receivedNotification.payload!['time']!;
    final addFiveMinutesFromNow = DateTime.now().add(Duration(minutes: 5));
    //
    final int notificationId =
        await NotificationHelper.generateLocalNotificationId();
    //
    await NotificationHelper.createNotification(
      notificationId: notificationId,
      title: receivedNotification.title!,
      body: receivedNotification.body!,
      isForMe: true,
      date: DateTime(
        addFiveMinutesFromNow.year,
        addFiveMinutesFromNow.month,
        addFiveMinutesFromNow.day,
      ),
      time: TimeOfDay(
          hour: addFiveMinutesFromNow.hour,
          minute: addFiveMinutesFromNow.minute),
      originalDate: originalDate,
      originalTime: originalTime,
      medicationId: receivedNotification.payload!['medicationId'],
      drugUniqueId: receivedNotification.payload!['drugUniqueId'],
    );
  }

  takeNotificationAction(receivedNotification, {required int value}) async {
    //
    final bool hasConnection = await InternetConnectionChecker().hasConnection;
    final String medicationId = receivedNotification.payload!['medicationId'];
    final String drugUniqueId = receivedNotification.payload!['drugUniqueId'];
    final String dateTime = receivedNotification.payload!['dateTime'];
    final int notificationId = receivedNotification.id;
    //
    if (hasConnection) {
      final bool isSent = await APIService().takeNotificationAction(
        medicationId,
        drugUniqueId,
        value,
        dateTime,
      );
      if (!isSent) {
        await DBHelper.saveNotificationActionInDB(
          medicationId,
          drugUniqueId,
          value,
          dateTime,
          notificationId,
        );
      }
    } else {
      await DBHelper.saveNotificationActionInDB(
        medicationId,
        drugUniqueId,
        value,
        dateTime,
        notificationId,
      );
    }
  }
}
