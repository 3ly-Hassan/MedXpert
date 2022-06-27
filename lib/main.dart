import 'package:bloc/bloc.dart';
import 'package:final_pro/bloc_observer.dart';
import 'package:final_pro/cubits/Article_cubit/article_cubit.dart';
import 'package:final_pro/cubits/dialog_cubit/dialog_cubit.dart';
import 'package:final_pro/cubits/medication_cubits/medications_list_cubit/medications_list_cubit.dart';
import 'package:final_pro/cubits/medication_cubits/notification_cubit/notification_cubit.dart';
import 'package:final_pro/cubits/teams_cubit/teams_cubit.dart';
import 'package:final_pro/cubits/teams_cubit/teams_doctor_cubit/teams_doctor_cubit.dart';
import 'package:final_pro/notification_helper.dart';
import 'package:final_pro/pages/dash_bord/dash_bord.dart';
import 'package:final_pro/pages/logging_page/loging.dart';
import 'package:final_pro/pages/splash/splash_screen.dart';
import 'package:final_pro/routes.dart';
import 'package:final_pro/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cache_helper.dart';
import 'constants.dart';
import 'cubits/MeasuremetCubit/measurement_cubit.dart';
import 'cubits/medication_cubits/create_medication_cubit/create_medication_cubit.dart';
import 'cubits/medication_cubits/drugs_list_cubit/drugs_list_cubit.dart';
import 'cubits/medication_cubits/medication_cubit/medication_cubit.dart';
import 'cubits/teams_cubit/teams_patient_cubit/teams_patient_cubit.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
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
}
