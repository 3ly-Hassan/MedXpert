class MedicationDrug {
  String? drugId;
  String? drugName;
  int? dose;
  bool? currentlyTaken;
  String? startDate;
  String? endDate;
  //used in flutter only!
  bool? isLoading;

  MedicationDrug({
    this.drugId,
    this.drugName,
    this.dose,
    this.startDate,
    this.endDate,
    this.currentlyTaken = true,
    this.isLoading = false,
  });

  factory MedicationDrug.fromJson(Map<String, dynamic> json) {
    return MedicationDrug(
      drugId: json['drug_id'],
      drugName: json['drug_name'],
      dose: json['dose'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      currentlyTaken: json['currentlyTaken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drug_id': drugId,
      'drug_name': drugName,
      'dose': dose,
      'currentlyTaken': currentlyTaken,
      'start_date': startDate,
      'end_date': endDate
    };
  }
}
