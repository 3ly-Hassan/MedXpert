import 'package:final_pro/models/doctor.dart';

class Patient {
  List<dynamic>? followings;
  String? sId;
  String? email;
  String? username;
  String? password;
  String? birthDate;
  num? weight;
  String? gender;
  List<dynamic>? type;
  List<dynamic>? followers;
  List<dynamic>? clinicians;
  List<dynamic>? chronics;
  String? createdAt;
  String? updatedAt;

  Patient({
    this.followings,
    this.sId,
    this.email,
    this.username,
    this.password,
    this.birthDate,
    this.gender,
    this.weight,
    this.type,
    this.followers,
    this.clinicians,
    this.chronics,
    this.createdAt,
    this.updatedAt,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    followings = json['followings'];
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    birthDate = json['birthDate'];
    weight = json['weight'];
    gender = json['gender'];
    type = json['type'];
    followers = json['followers'];
    clinicians = json['clinicians'];
    chronics = json['chronics'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();

  data['email'] = this.email;
  data['username'] = this.username;
  data['birthDate'] = this.birthDate;
  data['gender'] = this.gender;
  data['weight'] = this.weight;
  if (this.type != null) {
    data['type'] = this.type!.map((v) => v.toJson()).toList();
  }

  // if (this.chronics != null) {
  //   data['chronics'] = this.chronics!.map((v) => v.toJson()).toList();
  // }

  return data;
}
}
 

class clinicians {
  Doctor? doctor;
  String? date;

  clinicians({
    this.doctor,
    this.date
  });

  clinicians.fromJson(Map<String, dynamic> json) {
    doctor = json["doctor_id"];
    date = json["date"];
  }
}

class chronics {
  String? chronicName;
  String? since;
  String? state;

  chronics({
    this.chronicName,
    this.since,
    this.state
  });

  chronics.fromJson(Map<String, dynamic> json) {
    chronicName = json["chronic_name"];
    since = json["since"];
    state = json["state"];
  }
}