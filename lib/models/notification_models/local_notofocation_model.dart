class LocalNotificationModel {
  String? notificationId;
  String? drugUniqueId;
  String? username;
  String? drugName;
  String? date;
  String? time;
  LocalNotificationModel({
    this.notificationId,
    this.drugUniqueId,
    this.username = '', // empty means that the notification is Local
    this.drugName,
    this.date,
    this.time,
  });

  factory LocalNotificationModel.fromJson(Map<String, dynamic> json) {
    return LocalNotificationModel(
      notificationId: json['notificationId'],
      drugUniqueId: json['drugUniqueId'],
      username: json['patientName'],
      drugName: json['drugName'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'drugUniqueId': drugUniqueId,
      'patientName': username,
      'drugName': drugName,
      'date': date,
      'time': time,
    };
  }
}
