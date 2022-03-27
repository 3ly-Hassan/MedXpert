import 'dart:ffi';

class Measurement {
  String? id;
  String? patientId;
  String? condition;
  num? temp;
  int? pulse;
  int? respration;
  num? weight;
  String? createdAt;
  String? fakeDate;
  num? sugar;
  num? oxegen;
  num? systolicPressure;
  num? diastolicPressure;
  // List<dynamic>? problems;

  Measurement(
      {this.fakeDate,
      this.condition,
      this.temp,
      this.pulse,
      this.respration,
      this.diastolicPressure,
      this.systolicPressure,
      this.weight,
      this.sugar,
      this.oxegen});
  Measurement.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    patientId = json["patient_id"];
    condition = json["condition"];
    temp = json["temp"];
    pulse = json["pulse"];
    respration = json["respration"];
    diastolicPressure = json["diastolicPressure"];
    systolicPressure = json["systolicPressure"];
    weight = json["weight"];
    sugar = json["sugar"];
    oxegen = json["oxegen"];
    createdAt = json["createdAt"];
    // problems = json["problems"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'patient_id': patientId?.trim(),
      'condition': condition?.trim(),
      'temp': temp,
      'pulse': pulse,
      'respration': respration,
      'systolicPressure': systolicPressure,
      'diastolicPressure': diastolicPressure,
      'weight': weight,
      'sugar': sugar,
      'oxegen': oxegen,
    };
    return map;
  }
}
//
// class AddMeasurement {
//   Measurement? measurement;
//   String? msg;
//
//   AddMeasurement({this.measurement, this.msg});
// }
