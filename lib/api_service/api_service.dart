import 'package:final_pro/cache_helper.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/login_model.dart';

class APIService {
  final token = CacheHelper.getData(key: "token");


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


  Future<List<dynamic>> get_measurements() async {
    String url = "http://10.0.2.2:8000/api/vitalSign/getvitalSign";
    print("getting data");
try {
   final response =
        await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });  
  if(response.statusCode == 200){
    final List<dynamic> measurement = json.decode(response.body)["data"];
    return measurement;
  }

  else{
    return [];
  }
} catch (e) {
  return [];
}
   
  }

}
