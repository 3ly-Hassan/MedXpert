import 'package:final_pro/models/medication_drug.dart';

class Medication {
  String? id;
  String? name;
  String? patientId;
  String? doctorId;
  String? doctorName;
  List<dynamic>? drugs;
  String? createdAt;
  String? updatedAt;

  Medication({
    this.id,
    this.name,
    this.patientId,
    this.drugs,
    this.doctorId,
    this.doctorName,
    this.createdAt,
    this.updatedAt,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    List? drugsList = json['drugs'];
    if (json['drugs'] != null) {
      drugsList = json['drugs'].map((element) {
        return MedicationDrug.fromJson(element);
      }).toList();
    }

    return Medication(
      id: json['_id'],
      name: json['name'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'] == null ? null : json['doctor_id']['_id'],
      doctorName:
          json['doctor_id'] == null ? null : json['doctor_id']['username'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      drugs: drugsList,
    );
  }
}
