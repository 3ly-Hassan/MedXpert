import 'package:conditional_builder/conditional_builder.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/cubits/SignUpCubit/states.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:final_pro/pages/login_success/login_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/Form_error.dart';
import '../../../components/customSurfixButton.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../cubits/SignUpCubit/cubit.dart';
import '../../../helper.dart';
import '../../../size_config.dart';
import '../../complete_profile/complete_profile_screen.dart';
import '../../logging_page/loging.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SignUpRequestModel signUpRequestModel = SignUpRequestModel();
  String? password;
  String? conform_password;

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
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) => Form(
          key: _formKey,
          child: Column(
            children: [
              buildUserNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildConformPassFormField(),
              SizedBox(height: getProportionateScreenHeight(40)),
              ConditionalBuilder(
                condition: state is! MedSignUpLoadingState,
                builder: (context) => DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      print('gg');
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
        signUpRequestModel.gender = 'male';
        signUpRequestModel.birthDate = '1999-05-02';
        signUpRequestModel.role = 'patient';
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
