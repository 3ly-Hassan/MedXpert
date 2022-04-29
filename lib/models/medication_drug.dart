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
    Map<String, dynamic> data = {};
    data['drug_id'] = this.drugId;
    data['drug_name'] = this.drugName;
    data['dose'] = this.dose;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
