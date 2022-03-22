class Medication {
  String? id;
  String? patientId;
  String? doctorId;
  bool? currentlyTaken;
  List<dynamic>? drugs;
  String? createdAt;
  String? updatedAt;

  Medication({
    this.id,
    this.patientId,
    this.drugs,
    this.doctorId,
    this.currentlyTaken,
    this.createdAt,
    this.updatedAt,
  });

  Medication.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    drugs = json["drugs"];
    currentlyTaken = json['currentlyTaken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }


}
