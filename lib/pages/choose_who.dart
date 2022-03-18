import 'package:final_pro/components/dashBord_item.dart';
import 'package:final_pro/enums.dart';
import 'package:final_pro/pages/logging_page/loging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChooseWho extends StatelessWidget {
  static String routeName = "/choose";

  @override
  Widget build(BuildContext context) {
    var choose = Who.guest;
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Who are You ... ?',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 60),
            child: Row(
              children: [
                DashBordItem(
                  image: 'assets/images/patient.jpg',
                  title: 'Patient',
                  onPress: () {
                    choose = Who.patient;
                    Navigator.pushReplacementNamed(
                        context, LoggingPage.routeName,
                        arguments: LoginArguments(
                          status: choose,
                        ));
                  },
                  color: Colors.black,
                ),
                Spacer(),
                DashBordItem(
                  image: 'assets/images/doctor.jpg',
                  title: 'Doctor',
                  onPress: () {
                    choose = Who.doctor;
                    Navigator.pushReplacementNamed(
                        context, LoggingPage.routeName,
                        arguments: LoginArguments(
                          status: choose,
                        ));
                  },
                  color: Colors.black,
                ),
              ],
            ),
          ),
          DashBordItem(
            image: 'assets/images/com.jpg',
            title: 'Company',
            onPress: () {
              choose = Who.company;
              Navigator.pushReplacementNamed(context, LoggingPage.routeName,
                  arguments: LoginArguments(
                    status: choose,
                  ));
            },
            color: Colors.black,
          ),
          SizedBox(
            height: 40,
          ),
          TextButton(
              style: TextButton.styleFrom(
                primary: Colors.teal,
                side: BorderSide(color: Colors.white, width: 5),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoggingPage.routeName,
                    arguments: LoginArguments(
                      status: choose,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'continue as a guest..',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ))
        ],
      ),
    );
  }
}

class LoginArguments {
  final Who? status;

  LoginArguments({this.status});
}
