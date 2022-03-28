import 'package:final_pro/components/default_button.dart';
import 'package:final_pro/components/some_shared_components.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/pages/profile/components/add_chronics.dart';
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
  List<String> cities = [
    'Alex',
    'Aswan',
    'Asyut',
    'Beheira',
    'Beni-Suef',
    'Cairo',
    'Dakahlia',
    'Damietta',
    'Faiyum',
    'Gharbia',
    'Giza',
    'Ismallia',
    'Kafr-ElSheikh',
    'Luxor',
    'Matruh',
    'Minya',
    'Monufia',
    'New-Valley',
    'North_Sinai',
    'Port-Said',
    'Qena',
    'Red-Sea',
    'Sharqia',
    'Sohag',
    'South-Sinai',
    'Suez'
  ];
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Residency :',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, top: 10),
                              child: DropdownButton<String>(
                                  hint: Text('choose your city'),
                                  value:
                                      MeasurementCubit.get(context).dropValue,
                                  items: cities
                                      .map(
                                        (e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) {
                                    print('Ali');
                                    MeasurementCubit.get(context)
                                        .chooseFromDropDown(v);
                                  }),
                            ),
                          ],
                        )
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
                  cubit.patient.chronics != null
                      ? Wrap(
                          children: cubit.patient.chronics!
                              .map(
                                  (e) => chronicsItem(e.chronicName!, e.since!))
                              .toList())
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DefaultButton(
                      text: 'Add to your chronics',
                      press: () {
                        Navigator.pushNamed(context, AddChronics.routeName);
                      },
                    ),
                  ),
                  SizedBox(height: 20)
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

  //
  Widget chronicsItem(String text, String since, {String? state}) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, top: 10, left: 5, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(50),
          ),
          height: 30,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8),
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis),
                ),
                Text('since $since')
              ],
            ),
          ),
        ),
        Positioned(
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.cancel,
                size: 20,
              )),
          top: -13,
          right: -8,
        )
      ],
    );
  }

  Widget addItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 10, top: 10, left: 5, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 30,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Text(
            'Add',
            style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
