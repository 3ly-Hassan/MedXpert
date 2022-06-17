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

class DoseNotification {
  String notificationId;
  String drugName;
  String date;
  String time;
  DoseNotification({
    required this.notificationId,
    required this.drugName,
    required this.date,
    required this.time,
  });

  factory DoseNotification.fromJson(Map<String, dynamic> json) {
    return DoseNotification(
      notificationId: json['notificationId'],
      drugName: json['drugName'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'drugName': drugName,
      'date': date,
      'time': time,
    };
  }
}
