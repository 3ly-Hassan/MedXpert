import 'dart:ffi';

class Measurement {
  String? id;
  String? patientId;
  String? condition;
  num? temp;
  int? pulse;
  int? respration;
  String? pressure;
  num? weight;
  String? createdAt;
  List<dynamic>? problems;
  Measurement(
      {this.condition,
      this.temp,
      this.pulse,
      this.respration,
      this.pressure,
      this.weight});
  Measurement.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    patientId = json["patient_id"];
    condition = json["condition"];
    temp = json["temp"];
    pulse = json["pulse"];
    respration = json["respration"];
    pressure = json["pressure"];
    weight = json["weight"];
    createdAt = json["createdAt"];
    problems = json["problems"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'patient_id': patientId?.trim(),
      'condition': condition?.trim(),
      'temp': temp,
      'pulse': pulse,
      'respration': respration,
      'pressure': pressure,
      'weight': weight,
    };
    return map;
  }
}
