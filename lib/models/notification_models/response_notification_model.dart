class ResponseNotificationModel {
  String? username;
  String? drugUniqueId;
  String? drugName;
  String? date;
  String? time;

  ResponseNotificationModel({
    this.username,
    this.drugUniqueId,
    this.drugName,
    this.date,
    this.time,
  });

  factory ResponseNotificationModel.fromJson(Map<String, dynamic> json) {
    return ResponseNotificationModel(
      username: json['patientId']['username'],
      drugUniqueId: json['drugUniqueId'],
      drugName: json['drugName'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'drugUniqueId': drugUniqueId,
      'drugName': drugName,
      'date': date,
      'time': time,
    };
  }
}
