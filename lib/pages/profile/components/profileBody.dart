import 'package:final_pro/components/some_shared_components.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody(
      {Key? key,
      this.nameController,
      this.emailController,
      this.birthController})
      : super(key: key);
  final nameController;
  final emailController;
  final birthController;
  @override
  Widget build(BuildContext context) {
    var cubit = MeasurementCubit.get(context);

    return cubit.patient.username != null
        ? SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  CircleAvatar(
                    radius: 50,
                    child: Image.asset('assets/images/profile.png'),
                  ),
                  SizedBox(height: 5),
                  Text(
                    cubit.patient.username!,
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  ),
                  Text(
                    cubit.patient.email!,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '55',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '120',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '5',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Medicines',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        defaultFormField(
                            readOnly: MeasurementCubit.get(context).readOnly,
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (validate) {
                              return null;
                            },
                            label: 'User Name',
                            prefix: LineAwesomeIcons.alternate_user),
                        SizedBox(height: 10),
                        defaultFormField(
                            readOnly: MeasurementCubit.get(context).readOnly,
                            controller: emailController,
                            type: TextInputType.text,
                            validate: (validate) {
                              return null;
                            },
                            label: 'Email',
                            prefix: LineAwesomeIcons.mail_bulk),
                        SizedBox(height: 10),
                        defaultFormField(
                            readOnly: MeasurementCubit.get(context).readOnly,
                            controller: birthController,
                            type: TextInputType.text,
                            validate: (validate) {
                              return null;
                            },
                            label: 'Birth Date',
                            prefix: LineAwesomeIcons.birthday_cake),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(fontSize: 26),
            ),
          );
  }
}
