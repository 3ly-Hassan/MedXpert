import 'package:final_pro/components/some_shared_components.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../cubits/SignUpCubit/cubit.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({
    Key? key,
    this.nameController,
    this.emailController,
    this.birthController,
    this.weightController,
  }) : super(key: key);
  final nameController;
  final emailController;
  final birthController;
  final weightController;
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
                        // defaultFormField(
                        //     readOnly: MeasurementCubit.get(context).readOnly,
                        //     controller: birthController,
                        //     type: TextInputType.text,
                        //     validate: (validate) {
                        //       return null;
                        //     },
                        //     label: 'Birth Date',
                        //     prefix: LineAwesomeIcons.birthday_cake),
                        defaultFormField(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.parse('1950-01-01'),
                                initialDate: DateTime.now(),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                birthController.text =
                                    DateFormat('yyyy-MM-dd').format(value!);
                              });
                            },
                            focusNode: AlwaysDisabledFocusNode(),
                            controller: birthController,
                            type: TextInputType.datetime,
                            validate: (value) {
                              return null;
                            },
                            label: 'Birth Date',
                            prefix: LineAwesomeIcons.birthday_cake),
                        SizedBox(height: 10),
                        defaultFormField(
                            readOnly: MeasurementCubit.get(context).readOnly,
                            controller: weightController,
                            type:
                                TextInputType.numberWithOptions(decimal: true),
                            validate: (validate) {
                              return null;
                            },
                            label: 'Weight',
                            prefix: LineAwesomeIcons.weight),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          minVerticalPadding: 0,
                          minLeadingWidth: 10,
                          contentPadding: EdgeInsetsDirectional.zero,
                          title: Text('male'),
                          leading: Radio<String>(
                            autofocus:
                                MeasurementCubit.get(context).genderVal ==
                                        'male'
                                    ? true
                                    : false,
                            value: 'male',
                            groupValue: MeasurementCubit.get(context).genderVal,
                            onChanged: (value) {
                              MeasurementCubit.get(context).genderRadio(value);
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsetsDirectional.zero,
                          title: Text('female'),
                          leading: Radio(
                            autofocus:
                                MeasurementCubit.get(context).genderVal ==
                                        'female'
                                    ? true
                                    : false,
                            value: 'female',
                            groupValue: MeasurementCubit.get(context).genderVal,
                            onChanged: (value) {
                              MeasurementCubit.get(context).genderRadio(value);
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
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
