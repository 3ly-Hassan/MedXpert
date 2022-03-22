class Measurement {
  late String? id;
  late String? patientId;
  late String? condition;
  late double? temp;
  late int? pulse;
  late int? respration;
  late int? pressure;
  late double? weight;
  late String? createdAt;
  late List<dynamic>? problems;

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
      '_id': id?.trim(),
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
