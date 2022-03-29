import 'package:final_pro/models/doctor.dart';
import 'dart:convert';

class Patient {
  List<dynamic>? followings;
  String? sId;
  String? email;
  String? username;
  String? birthDate;
  num? weight;
  String? residency;
  String? gender;
  List<dynamic>? type;
  List<dynamic>? followers;
  List<dynamic>? clinicians;
  List<Chronics>? chronics;
  String? createdAt;
  String? updatedAt;

  Patient(
      {this.followings,
      this.sId,
      this.email,
      this.username,
      this.birthDate,
      this.gender,
      this.weight,
      this.type,
      this.followers,
      this.clinicians,
      this.chronics,
      this.createdAt,
      this.updatedAt,
      this.residency});

  Patient.fromJson(Map<String, dynamic> map) {
    sId = map['_id'];
    email = map['email'];
    username = map['username'];
    birthDate = map['birthDate'];
    weight = map['weight'];
    gender = map['gender'];
    type = map['type'];
    residency = map['residency'];

    if (map['followers'] != null) {
      followers = <Follower>[];
      map['followers'].forEach((v) {
        followers!.add(new Follower.fromJson(v));
      });
    }

    if (map['followings'] != null) {
      followings = <Follower>[];
      map['followings'].forEach((v) {
        followings!.add(new Follower.fromJson(v));
      });
    }

    if (map['clinicians'] != null) {
      clinicians = <Clinicians>[];
      map['clinicians'].forEach((v) {
        clinicians!.add(new Clinicians.fromJson(v));
      });
    }
    ;

    if (map['chronics'] != null) {
      chronics = <Chronics>[];
      map['chronics'].forEach((v) {
        chronics!.add(new Chronics.fromJson(v));
      });
    }
    ;

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
    data['residency'] = this.residency;
    // if (this.type != null) {
    //   data['type'] = this.type!.map((v) => v.toJson()).toList();
    // }

    // if (this.chronics != null) {
    //   data['chronics'] = this.chronics!.map((v) => v.toJson()).toList();
    // }

    return data;
  }
}

class Clinicians {
  Doctor? doctor;
  String? date;

  Clinicians({this.doctor, this.date});

  Clinicians.fromJson(Map<String, dynamic> map) {
    doctor = Doctor.fromJson(json.decode(map["doctor"]));
    date = map["date"];
  }
}

class Chronics {
  String? chronicName;
  String? since;
  String? state;

  Chronics({this.chronicName, this.since, this.state});

  Chronics.fromJson(Map<String, dynamic> json) {
    chronicName = json["chronic_name"];
    since = json["since"];
    state = json["state"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> chronics = new Map<String, dynamic>();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["chronic_name"] = this.chronicName;
    data["since"] = this.since;
    data["state"] = this.state;
    chronics["chronics"] = data;

    return chronics;
  }
}

class Follower {
  String? id;
  String? username;
  String? email;
  String? gender;

  Follower({this.id, this.username, this.email, this.gender});

  Follower.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    username = json["username"];
    email = json["email"];
    gender = json["gender"];
  }
}
