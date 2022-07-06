import 'package:final_pro/date_helper.dart';

class MedicationDrug {
  String? drugUniqueId;
  String? drugId;
  String? drugName;
  int? dose;
  bool? currentlyTaken;
  bool? isHelpful;
  String? startDate;
  String? endDate;
  //used locally in flutter only!
  bool? isLoading;

  MedicationDrug({
    this.drugUniqueId,
    this.drugId,
    this.drugName,
    this.dose,
    this.startDate,
    this.endDate,
    this.currentlyTaken = true,
    this.isHelpful,
    this.isLoading = false,
  });

  factory MedicationDrug.fromJson(Map<String, dynamic> json) {
    return MedicationDrug(
      drugUniqueId: json['_id'],
      drugId: json['drug_id'],
      drugName: json['drug_name'],
      dose: json['dose'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      isHelpful: json['isHelpful'],
      currentlyTaken: json['currentlyTaken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drugUniqueId': drugUniqueId,
      'drug_id': drugId,
      'drug_name': drugName,
      'dose': dose,
      'isHelpful': isHelpful,
      'currentlyTaken': currentlyTaken,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
