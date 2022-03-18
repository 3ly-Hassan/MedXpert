import 'package:final_pro/enums.dart';
import 'package:final_pro/pages/choose_who.dart';
import 'package:final_pro/pages/logging_page/components/login_body.dart';
import 'package:flutter/material.dart';

class LoggingPage extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as LoginArguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("sign in"),
        ),
        body: Body());
  }
}
