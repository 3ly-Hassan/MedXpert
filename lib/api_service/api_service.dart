import 'package:final_pro/models/signup_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/login_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://10.0.2.2:8000/api/auth/login";

    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());
    return LoginResponseModel.fromJson(
      json.decode(response.body),
    );
  }

  Future<SignUpResponseModel> signUp(SignUpRequestModel requestModel) async {
    String url = "http://10.0.2.2:8000/api/auth/register";

    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());

    return SignUpResponseModel.fromJson(
      json.decode(response.body),
    );
  }
}
