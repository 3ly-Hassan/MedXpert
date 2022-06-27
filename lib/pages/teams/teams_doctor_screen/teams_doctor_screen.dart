import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/components/error_bloc.dart';
import 'package:final_pro/cubits/teams_cubit/teams_doctor_cubit/teams_doctor_cubit.dart';
import 'package:final_pro/pages/teams/teams_doctor_screen/reusableRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/doctor.dart';

class TeamsDoctorScreen extends StatelessWidget {
  const TeamsDoctorScreen({Key? key}) : super(key: key);
  static String routeName = '/teams_doctor_screen';

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.green,
        ),
        body: BlocBuilder<TeamsDoctorCubit, TeamsDoctorState>(
          builder: (context, state) {
            if (state is TeamsDoctorLoadingState) {
              return CenterProgressIndicator();
            } else if (state is GetDoctorInfoState) {
              final Doctor doctor = state.doctor;
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      CircleAvatar(
                        radius: 50,
                        child: Image.asset('assets/images/doctor.jpg'),
                      ),
                      SizedBox(height: 5),
                      Text(
                        doctor.username!,
                        style: TextStyle(color: Colors.black, fontSize: 26),
                      ),
                      Text(
                        doctor.email!,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                doctor.followings!.length.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontFamily: 'Muli',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'Followings',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Muli',
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ],
                      ),
                      ReusableRow(title: 'Gender : ', value: doctor.gender!),
                      doctor.residency != null
                          ? ReusableRow(
                              title: 'residency : ', value: doctor.residency!)
                          : Container(),
                      ReusableRow(
                          title: 'Birth date : ',
                          value: doctor.birthDate!.substring(0, 10)),
                      ReusableRow(
                          title: 'Created at : ',
                          value: doctor.createdAt!.substring(0, 10)),
                      doctor.specialization!.isNotEmpty
                          ? ReusableRow(
                              title: 'Specializations : ',
                              value: '',
                              isLowPadding: true,
                            )
                          : Container(),
                      if (doctor.specialization!.isNotEmpty)
                        for (int i = 0; i < doctor.specialization!.length; i++)
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                30,
                                4,
                                16,
                                (i == doctor.specialization!.length - 1)
                                    ? 12
                                    : 0),
                            // child: Container(
                            //   width: double.infinity,
                            //   child: Text(
                            //     '• ${doctor.specialization![i]}.',
                            //     style: TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 18,
                            //       fontFamily: 'Muli',
                            //     ),
                            //     textAlign: TextAlign.start,
                            //   ),
                            // ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Muli',
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      '${doctor.specialization![i]}.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Muli',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    ],
                  ),
                ),
              );
            } else if (state is TeamsDoctorErrorState) {
              return Center(
                child: Text(
                  'an error has been occurred',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline4!.fontSize,
                  ),
                ),
              );
            }
            return ErrorBloc();
          },
        ));
  }
}
