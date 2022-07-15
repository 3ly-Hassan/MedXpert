import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/cache_helper.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/cubits/medication_cubits/notification_cubit/notification_cubit.dart';
import 'package:final_pro/pages/article/articles.dart';
import 'package:final_pro/pages/logging_page/loging.dart';
import 'package:final_pro/pages/measurements/measurements.dart';
import 'package:final_pro/pages/medication/medication_screen/medication_screen.dart';
import 'package:final_pro/pages/medication/medications_list_screen/medications_list_screen.dart';
import 'package:final_pro/pages/profile/profileScreen.dart';
import 'package:final_pro/pages/scan/scan.dart';
import 'package:final_pro/pages/teams/main/teams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/dashBord_item.dart';
import '../../constants.dart';
import '../../db_helper.dart';
import '../../notification_helper.dart';
import '../../size_config.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DashBord extends StatefulWidget {
  static String routeName = "/dash";
  const DashBord({Key? key}) : super(key: key);

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final size = MediaQuery.of(context).size;
    print('############');
    print(size.height);
    print(size.width);
    print('############');

    //
    if (role == 'patient') {
      //send notification actions to the server & delete them from local date base!
      sendActionsToTheServer();
      //get and create (remote) followers notifications
      BlocProvider.of<NotificationCubit>(context)
          .createReceivedNotifications(context);
    }
    //
    return BlocConsumer<MeasurementCubit, MeasurementState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Stack(
          children: [
            Container(
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage('assets/images/dash.png'))),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, top: 16, bottom: 6),
                child: Column(
                  children: [
                    Container(
                      height: 64,
                      margin: EdgeInsets.only(bottom: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: role == 'patient'
                                ? AssetImage('assets/images/patient.jpg')
                                : AssetImage('assets/images/doctor.jpg'),
                          ),
                          SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                buildTheNameText(context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              Text(
                                buildTheEmailText(context),
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    color: Colors.white,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          Spacer(),
                          // Center(
                          //     child: IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     Icons.search,
                          //     color: Colors.white,
                          //     size: 30,
                          //   ),
                          // )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        primary: false,
                        children: [
                          DashBordItem(
                            onPress: () {
                              if (role == 'doctor') {
                                Navigator.pushNamed(
                                    context, MedicationScreen.routeName);
                              } else {
                                Navigator.pushNamed(
                                    context, MedicationsListScreen.routeName);
                              }
                            },
                            image: 'assets/images/pharmacy.png',
                            title: 'Medication',
                          ),
                          DashBordItem(
                            onPress: () {
                              Navigator.pushNamed(context, Teams.routeName);
                            },
                            image: 'assets/images/team.png',
                            title: 'Teams',
                          ),
                          DashBordItem(
                              onPress: () {
                                Navigator.pushNamed(context, Scan.routeName);
                              },
                              image: 'assets/images/scan.png',
                              title: 'Scan'),
                          DashBordItem(
                              onPress: () {
                                Navigator.pushNamed(
                                    context, ProfileScreen.routeName);
                              },
                              image: 'assets/images/profile.png',
                              title: 'Profile'),
                          DashBordItem(
                              onPress: () {
                                Navigator.pushNamed(
                                    context, Articles.routeName);
                              },
                              image: 'assets/images/copywriting.png',
                              title: 'Articles'),
                          DashBordItem(
                              onPress: () {},
                              image: 'assets/images/graph.png',
                              title: 'Reports of Stats'),

                          // DashBordItem(
                          //     onPress: () {},
                          //     image: 'assets/images/gear.png',
                          //     title: 'Settings'),
                          role == 'doctor'
                              ? SizedBox()
                              : DashBordItem(
                                  onPress: () {
                                    Navigator.pushNamed(
                                        context, Measurements.routeName);
                                    MeasurementCubit.get(context)
                                        .get_measurements();
                                  },
                                  image: 'assets/images/pulse.png',
                                  title: 'Measurements'),
                          DashBordItem(
                              onPress: () {
                                CacheHelper.removeData(key: 'token').then(
                                    (value) => Navigator.pushReplacementNamed(
                                        context, LoggingPage.routeName));
                              },
                              image: 'assets/images/logout.png',
                              title: 'Log Out')
                        ],
                      ),
                    ),
                    // Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.red,
                    //         borderRadius: BorderRadius.circular(10)),
                    //     width: double.infinity,
                    //     child: TextButton.icon(
                    //       onPressed: () {
                    //         CacheHelper.removeData(key: 'token').then((value) =>
                    //             Navigator.pushReplacementNamed(
                    //                 context, LoggingPage.routeName));
                    //       },
                    //       icon: Icon(
                    //         Icons.logout,
                    //         color: Colors.white,
                    //       ),
                    //       label: Text('Log Out',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w700,
                    //           )),
                    //     ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String buildTheNameText(context) {
    if (MeasurementCubit.get(context).patient.username == null &&
        MeasurementCubit.get(context).doctor.username == null) {
      return 'loading...';
    } else if (role == 'patient') {
      return MeasurementCubit.get(context).patient.username!;
    } else {
      return MeasurementCubit.get(context).doctor.username!;
    }
  }

  String buildTheEmailText(context) {
    if (MeasurementCubit.get(context).patient.email == null &&
        MeasurementCubit.get(context).doctor.email == null) {
      return 'loading...';
    } else if (role == 'patient') {
      return MeasurementCubit.get(context).patient.email!;
    } else {
      return MeasurementCubit.get(context).doctor.email!;
    }
  }

  sendActionsToTheServer() async {
    List<Map> listOfMaps = await DBHelper.getNotificationActions();
    //
    for (int i = 0; i < listOfMaps.length; i++) {
      //
      bool isSent = await APIService().takeNotificationAction(
        listOfMaps[i]['medicationId'],
        listOfMaps[i]['drugUniqueId'],
        listOfMaps[i]['value'],
        listOfMaps[i]['dateTime'],
      );
      //
      if (isSent) {
        await DBHelper.deleteNotificationActionById(
            listOfMaps[i]['notificationId']);
      }
    }
  }
}
