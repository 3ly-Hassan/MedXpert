import 'package:final_pro/pages/add_measurement/addMeasurements.dart';
import 'package:final_pro/pages/article/articles.dart';
import 'package:final_pro/pages/choose_who.dart';
import 'package:final_pro/pages/dash_bord/dash_bord.dart';
import 'package:final_pro/pages/forget_pass/forget_password.dart';
import 'package:final_pro/pages/login_success/login_success.dart';
import 'package:final_pro/pages/logging_page/loging.dart';
import 'package:final_pro/pages/measurements/measurements.dart';
import 'package:final_pro/pages/profile/components/add_chronics.dart';
import 'package:final_pro/pages/profile/profileScreen.dart';
import 'package:final_pro/pages/splash/splash_screen.dart';
import 'package:final_pro/pages/teams/teams.dart';
import 'package:flutter/cupertino.dart';

import 'pages/register/sign_up.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoggingPage.routeName: (context) => LoggingPage(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  DashBord.routeName: (context) => DashBord(),
  ChooseWho.routeName: (context) => ChooseWho(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AddMeasurements.routeName: (context) => AddMeasurements(),
  Measurements.routeName: (context) => Measurements(),
  Teams.routeName: (context) => Teams(),
  AddChronics.routeName: (context) => AddChronics(),
  Articles.routeName: (context) => Articles(),
};
