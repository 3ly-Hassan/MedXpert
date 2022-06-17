import 'package:conditional_builder/conditional_builder.dart';
import 'package:intl/intl.dart';
import 'package:final_pro/components/some_shared_components.dart';
import 'package:final_pro/cubits/SignUpCubit/states.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/customSurfixButton.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../cubits/SignUpCubit/cubit.dart';
import '../../../helper.dart';
import '../../../size_config.dart';
import '../../logging_page/loging.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SignUpRequestModel signUpRequestModel = SignUpRequestModel();
  String? password;
  String? conform_password;
  var _dateController = TextEditingController();

  // @override
  // void initState() {
  //   signUpRequestModel.birthDate = "1999-05-02";
  //   signUpRequestModel.gender = 'male';
  //   signUpRequestModel.role = 'patient';
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedSignUpCubit(),
      child: BlocConsumer<MedSignUpCubit, MedSignUpStates>(
        listener: (context, state) {
          if (state is MedSignUpSuccessState) {
            if (state.signUpResponseModel.msg == 'success') {
              showToast(
                  text: 'you are registered Successfully',
                  state: ToastStates.SUCCESS);
              Navigator.pushNamed(context, LoggingPage.routeName);
            } else {
              showToast(
                  text: state.signUpResponseModel.msg,
                  state: ToastStates.WARNING);
            }
          } else if (state is MedSignUpErrorState) {
            showToast(text: 'error has occurred', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) => Form(
          key: _formKey,
          child: Column(
            children: [
              buildUserNameFormField(),
              SizedBox(height: (30)),
              buildEmailFormField(),
              SizedBox(height: (30)),
              buildPasswordFormField(),
              SizedBox(height: (30)),
              buildConformPassFormField(),
              SizedBox(height: (40)),
              defaultFormField(
                  onSaved: (value) {
                    signUpRequestModel.birthDate = _dateController.text;
                  },
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.parse('1950-01-01'),
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(value!);
                    });
                  },
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: _dateController,
                  type: TextInputType.datetime,
                  validate: (value) {
                    return null;
                  },
                  label: 'Birth Date',
                  prefix: Icons.date_range),
              SizedBox(
                height: 10,
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
                        value: 'male',
                        groupValue: MedSignUpCubit.get(context).genderVal,
                        onChanged: (value) {
                          MedSignUpCubit.get(context).genderRadio(value);
                          signUpRequestModel.gender = value;
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsetsDirectional.zero,
                      title: Text('female'),
                      leading: Radio(
                          value: 'female',
                          groupValue: MedSignUpCubit.get(context).genderVal,
                          onChanged: (value) {
                            MedSignUpCubit.get(context).genderRadio(value);
                            signUpRequestModel.gender = value.toString();
                            print(signUpRequestModel.gender);
                          }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 5,
                color: Colors.green,
              ),
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsetsDirectional.zero,
                    title: Text('Patient'),
                    leading: Radio<String>(
                      value: 'patient',
                      groupValue: MedSignUpCubit.get(context).typeVal,
                      onChanged: (value) {
                        MedSignUpCubit.get(context).typeRadio(value);
                        signUpRequestModel.role = value;
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                  ListTile(
                    title: Text('Doctor'),
                    contentPadding: EdgeInsetsDirectional.zero,
                    leading: Radio(
                        value: 'doctor',
                        groupValue: MedSignUpCubit.get(context).typeVal,
                        onChanged: (value) {
                          MedSignUpCubit.get(context).typeRadio(value);
                          signUpRequestModel.role = value.toString();
                          print(signUpRequestModel.gender);
                        }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsetsDirectional.zero,
                    title: Text('Company'),
                    leading: Radio(
                        value: 'pharma_inc',
                        groupValue: MedSignUpCubit.get(context).typeVal,
                        onChanged: (value) {
                          MedSignUpCubit.get(context).typeRadio(value);
                          signUpRequestModel.role = value.toString();
                          print(signUpRequestModel.gender);
                        }),
                  ),
                ],
              ),
              ConditionalBuilder(
                condition: state is! MedSignUpLoadingState,
                builder: (context) => DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      print('gg');
                      print(signUpRequestModel.role);
                      print(signUpRequestModel.gender);
                      _formKey.currentState!.save();
                      MedSignUpCubit.get(context)
                          .userRegister(signUpRequestModel);
                    }
                    KeyboardUtil.hideKeyboard(context);
                  },
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) {
        conform_password = newValue;
      },
      onChanged: (value) {
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if ((password != value)) {
          return kMatchPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) {
        signUpRequestModel.password = newValue;
        // signUpRequestModel.role = 'patient';
      },
      onChanged: (value) {
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => signUpRequestModel.email = newValue,
      onChanged: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => signUpRequestModel.username = newValue,
      onChanged: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "UserName",
        hintText: "Enter your UserName",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
