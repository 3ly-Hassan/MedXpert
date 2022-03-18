import 'dart:convert';

import 'package:final_pro/cubits/LoginCubit/states.dart';
import 'package:final_pro/models/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late LoginResponseModel loginModel;
  String url = "http://10.0.2.2:8000/api/auth/login";
  void userLogin(LoginRequestModel requestModel) {
    emit(ShopLoginLoadingState());
    http.post(Uri.parse(url), body: requestModel.toJson()).then((value) {
      print(value.body);
      loginModel = LoginResponseModel.fromJson(json.decode(value.body));
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}
