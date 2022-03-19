class Measurement {
  late String id;
  late String patientId;
  late String condition;
  late double temp;
  late int pulse;
  late int respration;
  late int pressure;
  late double weight;

  Measurement.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    patientId = json["patient_id"];
    condition = json["condition"];
    temp = json["temp"];
    pulse = json["pulse"];
    respration = json["respration"];
    pressure = json["pressure"];
    weight = json["weight"];
  }
}