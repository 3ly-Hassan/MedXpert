import 'package:final_pro/constants.dart';
import 'package:final_pro/models/article.dart';
import 'package:final_pro/models/doctor.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:final_pro/models/invitation.dart';
import 'package:final_pro/models/min_drug_model.dart';
import 'package:final_pro/models/notification_models/request_notification_model.dart';
import 'package:final_pro/models/notification_models/response_notification_model.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/login_model.dart';
import '../models/medication.dart';
import '../models/medication_drug.dart';
import '../models/patient.dart';

class APIService {
  //192.168.1.14
  String api = "http://10.0.2.2:8000/api";
  static final APIService _instance = APIService._internal();
  factory APIService() {
    return _instance;
  }

  APIService._internal();
  Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  Map<String, String> _scanHeaders = {
    'Authorization': 'Bearer $token',
  };

  set headers(Map<String, String> value) {
    _headers = value;
  }
  //authentication

  Future<LoginResponseModel?> userLogin(LoginRequestModel requestModel) async {
    String url = "$api/auth/login";
    try {
      final response =
          await http.post(Uri.parse(url), body: requestModel.toJson());
      LoginResponseModel responseModel =
          LoginResponseModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        print(responseModel.token);
        return responseModel;
      } else {
        //print('a7a');
        responseModel.token = 'ERROR';
        print(json.decode(response.body)["msg"]);
        return responseModel;
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
          headers: _headers, body: jsonEncode(reqMeasurement.toJson()));
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
      final response = await http.get(Uri.parse(url), headers: _headers);
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
      final response = await http.get(Uri.parse(url), headers: _headers);
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
      final response = await http.delete(Uri.parse(url), headers: _headers);
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
    print(_headers['Authorization']);
    try {
      final response = await http.get(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        Patient patient = Patient.fromJson(json.decode(response.body)["data"]);
        print('good');
        print(patient.email);
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
          headers: _headers, body: jsonEncode(patient.toJson()));
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
      final response = await http.delete(Uri.parse(url), headers: _headers);
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

  Future<void> addToList(Chronics chronics) async {
    String url = "$api/patient/addToList";
    try {
      final response = await http.patch(Uri.parse(url),
          headers: _headers, body: jsonEncode(chronics.toJson()));
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

  Future<void> deleteFromList(Chronics chronics) async {
    String url = "$api/patient/deleteFromList";
    try {
      final response = await http.patch(Uri.parse(url),
          headers: _headers, body: jsonEncode(chronics.toJson()));
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
    print(_headers['Authorization']);
    try {
      final response = await http.get(Uri.parse(url), headers: _headers);
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
          headers: _headers, body: jsonEncode(doctor.toJson()));
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
      final response = await http.delete(Uri.parse(url), headers: _headers);
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

  Future<List<dynamic>> getAllDoctor() async {
    String url = "$api/doctor/getAllDoctors";
    print("getting data");
    try {
      final response = await http.get(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        List<dynamic> doctors = json.decode(response.body)["data"];
        print('good');
        return doctors;
      } else {
        print('not good');
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<void> addSpecialization(List<String> specialization) async {
    String url = "$api/doctor/addSpecialization";
    return _specialization(specialization, url);
  }

  Future<void> deleteSpecialization(String specialization) async {
    String url = "$api/doctor/deleteSpecialization";
    return _specialization(specialization, url);
  }

  Future<void> _specialization(dynamic specialization, String url) async {
    try {
      final Map<String, dynamic> _specialization = new Map<String, dynamic>();
      _specialization["specialization"] = specialization;
      final response = await http.patch(Uri.parse(url),
          headers: _headers, body: jsonEncode(_specialization));
      if (response.statusCode == 200) {
        // Doctor doctor = Doctor.fromJson(json.decode(response.body)["data"]);
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

  // forget pass
  Future<ForgetPassResponseModel> forgetPass(
      ForgetPassRequestModel requestModel) async {
    String url = "$api/auth/passwordReset";
    try {
      print(requestModel.toJson());
      final response =
          await http.post(Uri.parse(url), body: requestModel.toJson());
      print(response.body);
      if (response.statusCode == 200) {
        ForgetPassResponseModel r =
            ForgetPassResponseModel.fromJson(json.decode(response.body));
        r.statusCode = response.statusCode;
        return r;
      } else {
        ForgetPassResponseModel r =
            ForgetPassResponseModel.fromJson(json.decode(response.body));
        print('kkk');
        r.statusCode = response.statusCode;
        return r;
      }
    } catch (e) {
      print('ي ابن الصرمة');
      print(e.toString());
      return ForgetPassResponseModel();
    }
  }

//get articles
  Future<Article> getAllArticles(key) async {
    String url = "$api/patient/articles?keyword=$key";
    print("getting data");
    try {
      final response = await http.get(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        Article article = Article.fromJson(json.decode(response.body), 200);
        print('good');
        return article;
      } else {
        print('not good');
        return Article(statusCode: response.statusCode);
      }
    } catch (e) {
      print(e.toString());
      return Article();
    }
  }

  //teams

  Future<Invitation?> createInvitation() async {
    String url = "$api/patient/createInvitation";
    try {
      final response = await http.get(Uri.parse(url), headers: _headers);
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
      final response = await http.post(Uri.parse(url), headers: _headers);
      InvitationResponseModel msg =
          InvitationResponseModel.fromJson(json.decode(response.body));
      print("message ====> ${msg.msg.toString()}");
      return msg;
    } catch (e) {
      return InvitationResponseModel(msg: e.toString());
    }
  }

  Future<InvitationResponseModel> useInvitationDoctor(String code) async {
    String url = "$api/doctor/useInvitation?code=$code";
    try {
      final response = await http.post(Uri.parse(url), headers: _headers);
      InvitationResponseModel msg =
          InvitationResponseModel.fromJson(json.decode(response.body));
      return msg;
    } catch (e) {
      return InvitationResponseModel(msg: "server error");
    }
  }

  Future<bool> deleteFollowerFromPatient(String id) async {
    String url = "$api/patient/deleteFollowerFromPatient?id=$id";
    try {
      final response = await http.patch(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        print('Delete Follower From Patient done');
        return true;
      } else {
        print('Problem In Delete Follower From Patient');
        return false;
      }
    } catch (e) {
      print('Exception In Delete Follower From Patient: ${e.toString()}');
      return false;
    }
  }

  Future<bool> deleteFollowingFromPatient(String id) async {
    String url = "$api/patient/deleteFollowingFromPatient?id=$id";
    try {
      final response = await http.patch(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        print('Delete Following From Patient done');
        return true;
      } else {
        print('Problem In Delete Following From Patient');
        return false;
      }
    } catch (e) {
      print('Exception In Delete Following From Patient: ${e.toString()}');
      return false;
    }
  }

  Future<bool> deleteDoctorFromPatient(String id) async {
    String url = "$api/patient/deleteDoctorFromPatient?id=$id";
    try {
      final response = await http.patch(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        print('Delete Doctor From Patient done');
        return true;
      } else {
        print('Problem In Delete Doctor From Patient');
        return false;
      }
    } catch (e) {
      print('Exception In Delete Doctor From Patient: ${e.toString()}');
      return false;
    }
  }

  Future<bool> deletePatientFromDoctor(String id) async {
    String url = "$api/doctor/deletePatientFromDoctor?id=$id";
    try {
      final response = await http.patch(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        print('Delete Patient From Doctor done');
        return true;
      } else {
        print('Problem In Delete Patient From Doctor');
        return false;
      }
    } catch (e) {
      print('Exception In Delete Patient From Doctor: ${e.toString()}');
      return false;
    }
  }

  //medication

  Future<bool> createMedication(
      String? patientId, String medicationName, List drugMedicationList) async {
    late String url;
    if (role == 'patient') {
      url = "$api/medication/createMedication";
    } else {
      url = "$api/medication/createMedication?id=$patientId";
    }
    print(drugMedicationList[0]);
    try {
      final response = await http.post(Uri.parse(url),
          headers: _headers,
          body: jsonEncode(
            {
              'drugs': drugMedicationList,
              'name': medicationName,
            },
          ));
      if (response.statusCode == 201) {
        print('create medication done');
        return true;
      } else {
        print('Problem In create medication: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception In create medication: ${e.toString()}');
      return false;
    }
  }

  Future<List?> searchForDrug(String searchKey) async {
    String url = "$api/drug/autoComplete?key=$searchKey";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        print('Search medication done');
        final List data = json.decode(response.body)['data'];
        final List drugModelList =
            data.map((e) => MinDrugModel.fromJson(e)).toList();
        return drugModelList;
      } else {
        print('Problem In Search medication');
        return null;
      }
    } catch (e) {
      print('Exception In Search medication: ${e.toString()}');
      return null;
    }
  }

  Future<List?> getMedicationsList([String? followerId]) async {
    //for patient account remove '?id=$followerId' and make followerId optional !
    late String url;
    if (role == 'patient') {
      url = "$api/medication/getMedicationsByPatientId";
    } else {
      url = "$api/medication/getMedicationsByPatientId?id=$followerId";
    }
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        print('Get Medications By Patient Id done');
        final List data = json.decode(response.body)['data'];
        final List medicationsList =
            data.map((e) => Medication.fromJson(e)).toList();
        return medicationsList;
      } else {
        print('Problem In Get Medications By Patient Id');
        return null;
      }
    } catch (e) {
      print('Exception In Get Medications By Patient Id: ${e.toString()}');
      return null;
    }
  }

  Future<bool> deleteMedication(String medicationId) async {
    String url = "$api/medication/deleteMedication?id=$medicationId";
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: _headers,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('delete medication done');
        return true;
      } else {
        print('Problem In delete medication');
        return false;
      }
    } catch (e) {
      print('Exception In delete medication: ${e.toString()}');
      return false;
    }
  }

  Future<bool> deleteDrug(String medicationId, String drugId) async {
    String url = "$api/medication/deleteMedicationDrug?id=$medicationId";
    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: _headers,
        body: jsonEncode({'drug_id': drugId}),
      );
      if (response.statusCode == 200) {
        print('delete drug done');
        return true;
      } else {
        print('Problem In delete drug');
        return false;
      }
    } catch (e) {
      print('Exception In delete drug: ${e.toString()}');
      return false;
    }
  }

  Future<Medication?> addDrugToMedication(
      String medicationId, MedicationDrug drug) async {
    String url = "$api/medication/addMedicationDrug?id=$medicationId";

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: _headers,
        body: jsonEncode(drug.toJson()),
      );
      if (response.statusCode == 200) {
        return Medication.fromJson(jsonDecode(response.body)['data']);
      } else {
        print('Problem In adding drug');
        return null;
      }
    } catch (e) {
      print('Exception In adding drug: ${e.toString()}');
      return null;
    }
  }

  Future<Medication?> updateCurrentlyTaken(
      bool value, String medicationId, String drugId) async {
    String url = "$api/medication/updateMedication?id=$medicationId";

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: _headers,
        body: jsonEncode(
          {
            "currentlyTaken": value,
            "drug_id": drugId,
          },
        ),
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['data']);
        return Medication.fromJson(jsonDecode(response.body)['data']);
      } else {
        print('Problem In updating drug');
        return null;
      }
    } catch (e) {
      print('Exception In updating drug: ${e.toString()}');
      return null;
    }
  }

  //notification in [medication]
  //
  Future<List?> getRecentNotifications() async {
    String url = "$api/notification/getNotifications";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        print('Get Recent Notifications done');
        final List data = json.decode(response.body)['data'];
        final List notificationsList =
            data.map((e) => ResponseNotificationModel.fromJson(e)).toList();
        return notificationsList;
      } else {
        print(response.statusCode);
        print('Problem In Get notifications List');
        return null;
      }
    } catch (e) {
      print('Exception In Get notifications List: ${e.toString()}');
      return null;
    }
  }

  Future sendLocalNotification(
      RequestNotificationModel requestNotificationModel) async {
    String url = "$api/notification/createNotification";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _headers,
        body: jsonEncode(requestNotificationModel.toJson()),
      );
      print('msg: ${json.decode(response.body)['msg']}');

      if (response.statusCode == 201) {
        print('Send notification done');
      } else {
        print('Status Code: ${response.statusCode}');
        print('Problem In Send notification');
      }
    } catch (e) {
      print('Exception In Send notification: ${e.toString()}');
    }
  }

  Future<String?> sendImage(path, name) async {
    print('1');
    var request = http.MultipartRequest('POST', Uri.parse('$api/drug/scan'));
    print('2');
    request.files
        .add(await http.MultipartFile.fromPath('image', path, filename: name));
    print('3');
    http.StreamedResponse response;
    request.headers.addAll(_scanHeaders);
    try {
      response = await request.send();
    } catch (e) {
      print('^^^^^^^^^^^');
      print(e.toString());
      print('^^^^^^^^^^^');

      return null;
    }

    print('4');
    if (response.statusCode == 200) {
      print('5');
      var body = await response.stream.bytesToString();
      print(body);
      return body;
    } else {
      print('6');
      print(response.reasonPhrase);
      return null;
    }
  }

  Future<void> deleteRemoteNotification(
      ResponseNotificationModel responseNotificationModel) async {
    String url = "$api/notification/deleteNotification";
    try {
      final response = await http.delete(Uri.parse(url),
          headers: _headers,
          body: jsonEncode(
            responseNotificationModel.toJson(),
          ));
      if (response.statusCode == 200) {
        return;
      } else {
        print('deleting failed !!! : ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> deleteRemoteNotificationByDrugUniqueId(
      String drugUniqueId) async {
    String url =
        "$api/notification/deleteNotificationByDrugUniqueId?id=$drugUniqueId";
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        return;
      } else {
        print('deleting by drugUniqueId failed !!! : ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Patient?> getPatientProfileById(String id) async {
    String url = "$api/patient/getPatient?id=$id";
    print("getting data");
    print(_headers['Authorization']);
    try {
      final response = await http.get(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        Patient patient = Patient.fromJson(json.decode(response.body)["data"]);
        print('good');
        print(patient.email);
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

  Future<Doctor?> getDoctorProfileById(String id) async {
    String url = "$api/doctor/getDoctor?id=$id";
    print("getting data");
    print(_headers['Authorization']);
    try {
      final response = await http.get(Uri.parse(url), headers: _headers);
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

  Future<List<Measurement>?> getPatientMeasurementsById(
      String patientId) async {
    String url = "$api/vitalSign/getVitalSignDoctor?id=$patientId";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        List<Measurement> measurementList = [];
        final List listOfMaps = json.decode(response.body)["data"];
        listOfMaps.forEach((element) {
          measurementList.add(Measurement.fromJson(element));
        });
        return measurementList;
      } else {
        print('not good');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> sendRightWord(imgName, vertices, rightWord) async {
    // var headers = {
    //   'Content-Type': 'application/json'
    // };
    var request = http.Request('POST', Uri.parse('$api/drug/saveToDataset'));
    request.body = json.encode({
      "imgName": imgName,
      "vertices": vertices,
      "label": rightWord,
    });
    request.headers.addAll(_headers);
    http.StreamedResponse response;

    try {
      response = await request.send();
    } catch (e) {
      print('^^^^^^^^^^^');
      print(e.toString());
      print('^^^^^^^^^^^');

      return null;
    }
    if (response.statusCode == 200) {
      print('5');
      var body = await response.stream.bytesToString();
      print(body);
      return body;
    } else {
      print('6');
      print(response.reasonPhrase);
      return null;
    }
  }
}
