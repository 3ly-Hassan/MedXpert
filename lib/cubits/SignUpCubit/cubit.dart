import 'dart:convert';
import 'package:final_pro/cubits/SignUpCubit/states.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../api_service/api_service.dart';

class MedSignUpCubit extends Cubit<MedSignUpStates> {
  MedSignUpCubit() : super(MedSignUpInitialState());

  static MedSignUpCubit get(context) => BlocProvider.of(context);

  late SignUpResponseModel responseModel;
  String url = "http://10.0.2.2:8000/api/auth/register";
  void userRegister(SignUpRequestModel requestModel) {
    emit(MedSignUpLoadingState());
    http.post(Uri.parse(url), body: requestModel.toJson()).then((value) {
      print(value.body);
      responseModel = SignUpResponseModel.fromJson(json.decode(value.body));
      emit(MedSignUpSuccessState(responseModel));
    }).catchError((error) {
      print(error.toString());
      emit(MedSignUpErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  String genderVal = '0';
  genderRadio(value) {
    genderVal = value;
    emit(ChooseGender());
  }

  String typeVal = '1';
  typeRadio(value) {
    typeVal = value;
    emit(ChooseType());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(MedChangePasswordVisibilityState());
  }
}
