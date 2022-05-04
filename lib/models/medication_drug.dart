class MedicationDrug {
  String? drugId;
  String? drugName;
  int? dose;
  String? startDate;
  String? endDate;

  MedicationDrug(
    this.drugId,
    this.drugName,
    this.dose,
    this.startDate,
    this.endDate,
  );

  MedicationDrug.fromJson(Map<String, dynamic> json) {
    drugId = json['drug_id'];
    drugName = json['drug_name'];
    dose = json['dose'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    return {
      'drug_id': drugId,
      'drug_name': drugName,
      'dose': dose,
      'start_date': startDate,
      'end_date': endDate
    };
  }
}
