import 'package:final_pro/cache_helper.dart';
import 'package:final_pro/pages/logging_page/loging.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.saveData(key: 'onBoarding', value: true).then(
                    (value) => Navigator.pushReplacementNamed(
                        context, LoggingPage.routeName));
              },
              child: Text('Skip'))
        ],
      ),
      body: Body(),
    );
  }
}
