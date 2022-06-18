import 'package:final_pro/date_helper.dart';

class MedicationDrug {
  String? drugUniqueId;
  String? drugId;
  String? drugName;
  int? dose;
  bool? currentlyTaken;
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
      currentlyTaken: json['currentlyTaken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drugUniqueId': drugUniqueId,
      'drug_id': drugId,
      'drug_name': drugName,
      'dose': dose,
      'currentlyTaken': currentlyTaken,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}

class LocalNotificationModel {
  String notificationId;
  String drugUniqueId;
  String drugName;
  String date;
  String time;
  LocalNotificationModel({
    required this.notificationId,
    required this.drugUniqueId,
    required this.drugName,
    required this.date,
    required this.time,
  });

  factory LocalNotificationModel.fromJson(Map<String, dynamic> json) {
    return LocalNotificationModel(
      notificationId: json['notificationId'],
      drugUniqueId: json['drugUniqueId'],
      drugName: json['drugName'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'drugUniqueId': drugUniqueId,
      'drugName': drugName,
      'date': date,
      'time': time,
    };
  }
}
