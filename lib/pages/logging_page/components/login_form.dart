import 'package:conditional_builder/conditional_builder.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/components/default_button.dart';
import 'package:final_pro/cubits/LoginCubit/cubit.dart';
import 'package:final_pro/cubits/LoginCubit/states.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/models/login_model.dart';
import 'package:final_pro/pages/forget_pass/forget_password.dart';
import 'package:final_pro/pages/login_success/login_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../cache_helper.dart';
import '../../../constants.dart';
import '../../../enums.dart';
import '../../../helper.dart';
import '../../../size_config.dart';
import '../../../components/Form_error.dart';
import '../../../components/customSurfixButton.dart';
import '../../dash_bord/dash_bord.dart';

class SignForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final loginRequestModel = LoginRequestModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedLoginCubit, MedLoginStates>(
      listener: (context, state) {
        if (state is MedLoginSuccessState) {
          if (state.loginModel.token != "") {
            print(state.loginModel.msg);
            print(state.loginModel.token);
            CacheHelper.saveData(key: 'role', value: role).then((value) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.token,
              ).then((value) {
                APIService api = APIService();

                token = state.loginModel.token!;
                api.headers = {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $token',
                };
                print(token);
                if (role == 'patient') {
                  print('a7a3');
                  MeasurementCubit.get(context).getPatientProfile().then(
                      (value) => Navigator.pushReplacementNamed(
                          context, DashBord.routeName));
                } else if (role == 'doctor') {
                  print('A7a4');
                  MeasurementCubit.get(context).getdoctorProfile().then(
                      (value) => Navigator.pushReplacementNamed(
                          context, DashBord.routeName));
                }
              });
            });
          } else {
            print(state.loginModel.msg);

            showToast(
              text: state.loginModel.msg,
              state: ToastStates.ERROR,
            );
          }
        } else if (state is MedLoginErrorState) {
          showToast(
            text: 'something has been occurred',
            state: ToastStates.ERROR,
          );
          print(state.error);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              buildEmailFormField(),
              SizedBox(height: 30),
              buildPasswordFormField(),
              SizedBox(height: 30),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, ForgotPasswordScreen.routeName),
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              ConditionalBuilder(
                condition: state is! MedLoginLoadingState,
                builder: (context) => DefaultButton(
                    text: "Continue",
                    press: () {
                      if (role == null) {
                        MedLoginCubit.get(context).notRole(false);
                      } else if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        MedLoginCubit.get(context).userLogin(loginRequestModel);
                      }

                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                    }),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => loginRequestModel.password = newValue,
      onChanged: (value) {},
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
      onSaved: (newValue) {
        loginRequestModel.email = newValue;
        loginRequestModel.role = role;
      },
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

  // bool validateAndSave() {
  //   final form = _formKey.currentState;
  //   if (form!.validate()) {
  //     form.save();
  //     return true;
  //   }
  //   return false;
  // }
}
