import 'package:final_pro/constants.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:final_pro/models/invitation.dart';
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


  //authentication
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



  // measurements
  Future<Measurement?> createMeasurement ()async {
     String url = "$api/vitalSign/createvitalSign";
    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      if (response.statusCode == 201) {
        Measurement measurement = Measurement.fromJson(json.decode(response.body)["data"]);
        print(json.decode(response.body)["msg"]);
        return measurement;
      } else {
        print(json.decode(response.body)["msg"]);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<List<dynamic>> get_measurements() async {
    String url = "$api/vitalSign/getvitalSign";
    print("getting data");
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);
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

  Future<Measurement?> updateMeasurement(String id) async{
    String url = "$api/vitalSign/updatevitalSign?id=$id";
    print("getting data");
    try {
      final response = await http.patch(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        Measurement measurement = Measurement.fromJson(json.decode(response.body)["data"]);
        print(json.decode(response.body)["msg"]);
        return measurement;
      } else {
        print(json.decode(response.body)["msg"]);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void deleteMeasurement(String id) async{
      String url = "$api/vitalSign/deletevitalSign?id=$id";
    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print(json.decode(response.body)["msg"]);
        return;
      }

    } catch (e) {
      print(e.toString());
      return null;
    }
  }



  // profile

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



  //teams

  Future<Invitation?> createInvitation() async {
    String url = "$api/patient/createInvitation";
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        Invitation invitation =
            Invitation.fromJson(json.decode(response.body)["data"]);
        print('create invitation done');
        return invitation;
      } else {
        print('error create invitation');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<InvitationResponseModel> useInvitationPatient(String code) async {
    String url = "$api/patient/useInvitation?code=$code";
    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      InvitationResponseModel msg =
          InvitationResponseModel.fromJson(json.decode(response.body)["msg"]);
      return msg;
    } catch (e) {
      return InvitationResponseModel(msg: "server error");
    }
  }

  Future<InvitationResponseModel> useInvitationDoctor(String code) async {
    String url = "$api/doctor/useInvitation?code=$code";
    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      InvitationResponseModel msg =
          InvitationResponseModel.fromJson(json.decode(response.body)["msg"]);
      return msg;
    } catch (e) {
      return InvitationResponseModel(msg: "server error");
    }
  }




}
