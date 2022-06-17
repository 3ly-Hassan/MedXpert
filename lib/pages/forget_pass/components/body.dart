import 'package:final_pro/components/Form_error.dart';
import 'package:final_pro/components/customSurfixButton.dart';
import 'package:final_pro/components/default_button.dart';
import 'package:final_pro/components/noAccountText.dart';
import 'package:final_pro/cubits/forget_cubit/cubit.dart';
import 'package:final_pro/cubits/forget_cubit/states.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:final_pro/pages/logging_page/loging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  ForgetPassRequestModel requestModel = ForgetPassRequestModel();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ForgetCubit(),
        child: BlocConsumer<ForgetCubit, ForgetStates>(
            listener: (context, state) {
              if (state is ForgetPassSuccess) {
                if (state.model.msg != null) {
                  if (state.model.statusCode == 200) {
                    showToast(
                        text: state.model.msg, state: ToastStates.SUCCESS);
                    Navigator.pushNamed(context, LoggingPage.routeName);
                  } else {
                    showToast(text: state.model.msg, state: ToastStates.ERROR);
                  }
                }
              }
            },
            builder: (context, state) => Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (newValue) => requestModel.email = newValue,
                        onChanged: (value) {
                          if (value.isNotEmpty &&
                              errors.contains(kEmailNullError)) {
                            setState(() {
                              errors.remove(kEmailNullError);
                            });
                          } else if (emailValidatorRegExp.hasMatch(value) &&
                              errors.contains(kInvalidEmailError)) {
                            setState(() {
                              errors.remove(kInvalidEmailError);
                            });
                          }
                          return null;
                        },
                        validator: (value) {
                          if (value!.isEmpty &&
                              !errors.contains(kEmailNullError)) {
                            setState(() {
                              errors.add(kEmailNullError);
                            });
                          } else if (!emailValidatorRegExp.hasMatch(value) &&
                              !errors.contains(kInvalidEmailError)) {
                            setState(() {
                              errors.add(kInvalidEmailError);
                            });
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          // If  you are using latest version of flutter then label text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: CustomSuffixIcon(
                              svgIcon: "assets/icons/Mail.svg"),
                        ),
                      ),
                      SizedBox(height: (30)),
                      FormError(errors: errors),
                      SizedBox(height: 10 * 0.1),
                      Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsetsDirectional.zero,
                            title: Text('Patient'),
                            leading: Radio<String>(
                              value: 'patient',
                              groupValue:
                                  ForgetCubit.get(context).typeValForPass,
                              onChanged: (value) {
                                ForgetCubit.get(context).typeRadioPass(value);
                                requestModel.role = value;
                              },
                              activeColor: Colors.green,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListTile(
                            title: Text('Doctor'),
                            contentPadding: EdgeInsetsDirectional.zero,
                            leading: Radio(
                                value: 'doctor',
                                groupValue:
                                    ForgetCubit.get(context).typeValForPass,
                                onChanged: (value) {
                                  ForgetCubit.get(context).typeRadioPass(value);
                                  requestModel.role = value.toString();
                                }),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListTile(
                            contentPadding: EdgeInsetsDirectional.zero,
                            title: Text('Company'),
                            leading: Radio(
                                value: 'pharma_inc',
                                groupValue:
                                    ForgetCubit.get(context).typeValForPass,
                                onChanged: (value) {
                                  ForgetCubit.get(context).typeRadioPass(value);
                                  requestModel.role = value.toString();
                                }),
                          ),
                        ],
                      ),
                      SizedBox(height: 10 * 0.1),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print(requestModel.email);
                            print(requestModel.role);
                            ForgetCubit.get(context).forgetPass(requestModel);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      NoAccountText(),
                    ],
                  ),
                )));
  }
}
