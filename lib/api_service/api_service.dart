import 'package:final_pro/constants.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/login_model.dart';
import '../models/patient.dart';

class APIService {
  String api = "http://10.0.2.2:8000/api";

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "$api/auth/login";

    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());
    return LoginResponseModel.fromJson(
      json.decode(response.body),
    );
  }

  Future<SignUpResponseModel> signUp(SignUpRequestModel requestModel) async {
    String url = "$api/auth/register";

    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());

    return SignUpResponseModel.fromJson(
      json.decode(response.body),
    );
  }

  Future<List<dynamic>> get_measurements() async {
    String url = "$api/vitalSign/getvitalSign";
    print("getting data");
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> measurement = json.decode(response.body)["data"];
        return measurement;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Patient?> getProfile() async {
    String url = "$api/patient/getPatient";
    print("getting data");
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        Patient patient = Patient.fromJson(json.decode(response.body)["data"]);
        print('good');
        return patient;
      } else {
        print('not good');

        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
