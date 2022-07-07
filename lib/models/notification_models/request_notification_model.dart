class RequestNotificationModel {
  String? medicationId;
  String? drugUniqueId;
  String? drugName;
  String? date;
  String? time;
  String? dateTime;
  String? expireAt;
  RequestNotificationModel({
    required this.medicationId,
    this.drugUniqueId,
    this.drugName,
    this.date,
    this.time,
    required this.dateTime,
    required this.expireAt,
  });

  factory RequestNotificationModel.fromJson(Map<String, dynamic> json) {
    return RequestNotificationModel(
      medicationId: json['medicationId'],
      drugUniqueId: json['drugUniqueId'],
      drugName: json['drugName'],
      date: json['date'],
      time: json['time'],
      dateTime: json['dateTime'],
      expireAt: json['expireAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicationId': medicationId,
      'drugUniqueId': drugUniqueId,
      'drugName': drugName,
      'date': date,
      'time': time,
      'dateTime': dateTime,
      'expireAt': expireAt,
    };
  }
}
