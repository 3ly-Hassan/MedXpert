import 'package:final_pro/constants.dart';
import 'package:final_pro/models/doctor.dart';
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
  Future<LoginResponseModel?> userLogin(LoginRequestModel requestModel) async {
    String url = "$api/auth/login";
    try {
      final response =
          await http.post(Uri.parse(url), body: requestModel.toJson());
      if (response.statusCode == 200) {
        LoginResponseModel responseModel =
            LoginResponseModel.fromJson(json.decode(response.body));
        return responseModel;
      } else {
        print('a7a');
        print(json.decode(response.body)["msg"]);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future<SignUpResponseModel> signUp(SignUpRequestModel requestModel) async {
  //   String url = "$api/auth/register";
  //
  //   final response =
  //       await http.post(Uri.parse(url), body: requestModel.toJson());
  //
  //   return SignUpResponseModel.fromJson(
  //     json.decode(response.body),
  //   );
  // }

  // measurements
  Future<Measurement?> createMeasurement(Measurement reqMeasurement) async {
    String url = "$api/vitalSign/createvitalSign";
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(reqMeasurement.toJson()));
      if (response.statusCode == 201) {
        Measurement measurement =
            Measurement.fromJson(json.decode(response.body)["data"]);
        print(json.decode(response.body)["msg"]);
        return measurement;
      } else {
        print(json.decode(response.body)["msg"]);
        print('A7a');
        return null;
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  Future<List<dynamic>> get_measurements() async {
    String url = "$api/vitalSign/getvitalSignPatient";
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

  Future<List<dynamic>> getDoctorMeasurement(String patientName) async {
    String url = "$api/vitalSign/getVitalSignDoctor?name=$patientName";
    print("getting data");
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final List<Measurement> measurement =
            json.decode(response.body)["data"];
        return measurement;
      } else {
        print(json.decode(response.body)["msg"]);
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Future<Measurement?> updateMeasurement(String id) async {
  //   String url = "$api/vitalSign/updatevitalSign?id=$id";
  //   print("getting data");
  //   try {
  //     final response = await http.patch(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       Measurement measurement =
  //           Measurement.fromJson(json.decode(response.body)["data"]);
  //       print(json.decode(response.body)["msg"]);
  //       return measurement;
  //     } else {
  //       print(json.decode(response.body)["msg"]);
  //       return null;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future<void> deleteMeasurement(String id) async {
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

  // patient profile
  Future<Patient?> getPatientProfile() async {
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

  Future<Patient?> updatePatient(Patient patient) async {
    String url = "$api/patient/updatePatient";
    try {
      final response = await http.patch(Uri.parse(url),
          headers: headers, body: jsonEncode(patient.toJson()));
      if (response.statusCode == 200) {
        Patient updatedpatient =
            Patient.fromJson(json.decode(response.body)["data"]);
        print(json.decode(response.body)["msg"]);
        return updatedpatient;
      } else {
        print(json.decode(response.body)["msg"]);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> deletePatient() async {
    String url = "$api/patient/deletePatient";
    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print(json.decode(response.body)["msg"]);
        return;
      } else {
        print(json.decode(response.body)["msg"]);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // doctor profile
  Future<Doctor?> getDoctorProfile() async {
    String url = "$api/doctor/getDoctor";
    print("getting data");
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        Doctor doctor = Doctor.fromJson(json.decode(response.body)["data"]);
        print('good');
        return doctor;
      } else {
        print('not good');

        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Doctor?> updateDoctor(Doctor doctor) async {
    String url = "$api/doctor/updateDoc";
    try {
      final response = await http.patch(Uri.parse(url),
          headers: headers, body: jsonEncode(doctor.toJson()));
      if (response.statusCode == 200) {
        Doctor returendDoctor =
            Doctor.fromJson(json.decode(response.body)["data"]);
        print(json.decode(response.body)["msg"]);
        return returendDoctor;
      } else {
        print(json.decode(response.body)["msg"]);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> deleteDoctor() async {
    String url = "$api/doctor/deleteDoctor";
    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print(json.decode(response.body)["msg"]);
        return;
      } else {
        print(json.decode(response.body)["msg"]);
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
