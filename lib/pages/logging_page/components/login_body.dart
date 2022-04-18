import 'package:final_pro/components/social_card.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/LoginCubit/cubit.dart';
import 'package:final_pro/cubits/LoginCubit/states.dart';
import 'package:final_pro/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../size_config.dart';
import '../../../components/noAccountText.dart';
import 'login_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = MedLoginCubit.get(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .04),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                BlocConsumer<MedLoginCubit, MedLoginStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    color: cubit.selectedItem == 0
                                        ? Colors.green
                                        : Colors.black,
                                    iconSize: 70,
                                    onPressed: () {
                                      role = 'patient';
                                      cubit.notRole(true);
                                      cubit.selectRole(0);
                                    },
                                    icon: Icon(LineAwesomeIcons.user),
                                    tooltip: 'Patient',
                                  ),
                                  Text(
                                    'Patient',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      color: cubit.selectedItem == 1
                                          ? Colors.green
                                          : Colors.black,
                                      iconSize: 70,
                                      onPressed: () {
                                        role = 'doctor';
                                        MedLoginCubit.get(context)
                                            .notRole(true);
                                        cubit.selectRole(1);
                                      },
                                      icon: Icon(LineAwesomeIcons.doctor)),
                                  Text(
                                    'Doctor',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      color: cubit.selectedItem == 2
                                          ? Colors.green
                                          : Colors.black,
                                      iconSize: 70,
                                      onPressed: () {
                                        role = 'pharma_inc';
                                        MedLoginCubit.get(context)
                                            .notRole(true);
                                        cubit.selectRole(2);
                                      },
                                      icon: Icon(LineAwesomeIcons.hospital)),
                                  Text(
                                    'Pharma_Inc',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          !cubit.isRole
                              ? Text(
                                  'require to be selected',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                )
                              : Container()
                        ],
                      );
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                SignForm(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SocialCard(
                //       icon: "assets/icons/google-icon.svg",
                //       press: () {},
                //     ),
                //     SocialCard(
                //       icon: "assets/icons/facebook-2.svg",
                //       press: () {},
                //     ),
                //     SocialCard(
                //       icon: "assets/icons/twitter.svg",
                //       press: () {},
                //     ),
                //   ],
                // ),

                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
