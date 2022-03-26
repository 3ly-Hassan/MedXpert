import 'package:final_pro/models/doctor.dart';
import 'dart:convert';

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

  Patient.fromJson(Map<String, dynamic> map) {
    followings = map['followings'];
    sId = map['_id'];
    email = map['email'];
    username = map['username'];
    password = map['password'];
    birthDate = map['birthDate'];
    weight = map['weight'];
    gender = map['gender'];
    type = map['type'];
    followers = map['followers'];
    clinicians = map['clinicians'];

  if (map['clinicians'] != null) {
      clinicians = <Clinicians>[];
      map['clinicians'].forEach((v) {
        clinicians!.add(new Clinicians.fromJson(v));
      });
   };

   if (map['chronics'] != null) {
      chronics = <Chronics>[];
      map['chronics'].forEach((v) {
        chronics!.add(new Chronics.fromJson(v));
      });
   };


    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
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
 

class Clinicians {
  String? doctorId;
  String? date;

  Clinicians({
    this.doctorId,
    this.date
  });

  Clinicians.fromJson(Map<String, dynamic> map) {
    doctorId = map["doctor"];
    date = map["date"];
  }
}

class Chronics {
  String? chronicName;
  String? since;
  String? state;

  Chronics({
    this.chronicName,
    this.since,
    this.state
  });

  Chronics.fromJson(Map<String, dynamic> json) {
    chronicName = json["chronic_name"];
    since = json["since"];
    state = json["state"];
  }
}