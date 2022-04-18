import 'dart:convert';

import 'package:final_pro/cubits/LoginCubit/states.dart';
import 'package:final_pro/models/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../api_service/api_service.dart';

class MedLoginCubit extends Cubit<MedLoginStates> {
  MedLoginCubit() : super(MedLoginInitialState());
  APIService api = new APIService();
  static MedLoginCubit get(context) => BlocProvider.of(context);

  LoginResponseModel loginModel = LoginResponseModel();
  String url = "http://10.0.2.2:8000/api/auth/login";
  // void userLogin(LoginRequestModel requestModel) {
  //   emit(MedLoginLoadingState());
  //   http.post(Uri.parse(url), body: requestModel.toJson()).then((value) {
  //     print(value.body);
  //     loginModel = LoginResponseModel.fromJson(json.decode(value.body));
  //     emit(MedLoginSuccessState(loginModel));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(MedLoginErrorState(error.toString()));
  //   });
  // }
  Future<LoginResponseModel?> _login(LoginRequestModel requestModel) async {
    LoginResponseModel? responseModel = await api.userLogin(requestModel);
    return responseModel;
  }

  void userLogin(LoginRequestModel requestModel) {
    emit(MedLoginLoadingState());
    _login(requestModel).then((value) {
      if (value == null) {
        print('ali..............');
        return;
      }
      loginModel = value;

      print('asdfghjkl');
      print(loginModel.token);
      emit(MedLoginSuccessState(loginModel));
    }).catchError((e) {
      emit(MedLoginErrorState(e));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(MedChangePasswordVisibilityState());
  }

  bool isRole = true;
  notRole(value) {
    isRole = value;
    emit(RoleState());
  }

  int? selectedItem;
  void selectRole(int i) {
    selectedItem = i;
    emit(SelectState());
  }
}
