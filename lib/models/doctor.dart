import 'package:final_pro/models/patient.dart';

class Doctor {
  String? id;
  String? email;
  String? username;
  String? password;
  String? bio;
  String? gender;
  String? createdAt;
  String? updatedAt;
  String? residency;
  String? birthDate;
  List<dynamic>? specialization;
  List<dynamic>? followings;

  Doctor({
    this.id,
    this.email,
    this.username,
    this.password,
    this.bio,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.residency,
    this.specialization,
    this.followings,
  });

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    bio = json['bio'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    residency = json['residency'];
    specialization = json['specialization'].cast<String>();
    if (json['followings'] != null) {
      followings = <Follower>[];
      json['followings'].forEach((v) {
        followings!.add(new Follower.fromJsonPatient(v['patient_id']));
      });
    }
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;
    data['username'] = this.username;
    data['bio'] = this.bio;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    // if (this.specialization != null) {
    //   data['specialization'] =
    //       this.specialization!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
