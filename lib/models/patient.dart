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
