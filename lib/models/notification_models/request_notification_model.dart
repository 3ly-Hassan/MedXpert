class RequestNotificationModel {
  String? drugUniqueId;
  String? drugName;
  String? date;
  String? time;
  RequestNotificationModel({
    this.drugUniqueId,
    this.drugName,
    this.date,
    this.time,
  });

  factory RequestNotificationModel.fromJson(Map<String, dynamic> json) {
    return RequestNotificationModel(
      drugUniqueId: json['drugUniqueId'],
      drugName: json['drugName'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drugUniqueId': drugUniqueId,
      'drugName': drugName,
      'date': date,
      'time': time,
    };
  }
}
