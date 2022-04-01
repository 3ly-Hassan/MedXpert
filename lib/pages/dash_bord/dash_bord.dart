import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/pages/measurements/measurements.dart';
import 'package:final_pro/pages/profile/profileScreen.dart';
import 'package:final_pro/pages/teams/teams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/dashBord_item.dart';
import '../../constants.dart';

class DashBord extends StatefulWidget {
  static String routeName = "/dash";
  const DashBord({Key? key}) : super(key: key);

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                padding: const EdgeInsets.all(16.0),
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
                            backgroundImage:
                            role == 'patient' ? 
                                AssetImage('assets/images/patient.jpg') : AssetImage('assets/images/doctor.jpg') ,
                          ),
                          SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                MeasurementCubit.get(context)
                                                .patient
                                                .username ==
                                            null &&
                                        MeasurementCubit.get(context)
                                                .doctor
                                                .username ==
                                            null
                                    ? "Loading..."
                                    : MeasurementCubit.get(context)
                                            .patient
                                            .username ??
                                        MeasurementCubit.get(context)
                                            .doctor
                                            .username!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              Text(
                                MeasurementCubit.get(context).patient.email ==
                                            null &&
                                        MeasurementCubit.get(context)
                                                .doctor
                                                .email ==
                                            null
                                    ? "Loading..."
                                    : MeasurementCubit.get(context)
                                            .patient
                                            .email ??
                                        MeasurementCubit.get(context)
                                            .doctor
                                            .email!,
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    color: Colors.white,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          Spacer(),
                          Center(
                              child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30,
                            ),
                          )),
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
                            onPress: () {},
                            image: 'assets/images/pharmacy.png',
                            title: 'Medication',
                          ),
                          DashBordItem(
                              onPress: () {
                                Navigator.pushNamed(context, Teams.routeName);
                              },
                              image: 'assets/images/team.png',
                              title: 'Teams'),
                          DashBordItem(
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
                                Navigator.pushNamed(
                                    context, ProfileScreen.routeName);
                              },
                              image: 'assets/images/profile.png',
                              title: 'Profile'),
                          DashBordItem(
                              onPress: () {},
                              image: 'assets/images/copywriting.png',
                              title: 'Articles'),
                          DashBordItem(
                              onPress: () {},
                              image: 'assets/images/graph.png',
                              title: 'Reports of Stats'),
                          DashBordItem(
                              onPress: () {},
                              image: 'assets/images/scan.png',
                              title: 'Scan'),
                          DashBordItem(
                              onPress: () {},
                              image: 'assets/images/gear.png',
                              title: 'Settings'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
