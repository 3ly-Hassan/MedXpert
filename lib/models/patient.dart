class Patient {
  List<dynamic>? followings;
  String? sId;
  String? email;
  String? username;
  String? password;
  String? birthDate;
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
    gender = json['gender'];
    type = json['type'];
    followers = json['followers'];
    clinicians = json['clinicians'];
    chronics = json['chronics'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   if (this.followings != null) {
//     data['followings'] = this.followings!.map((v) => v.toJson()).toList();
//   }
//   data['_id'] = this.sId;
//   data['email'] = this.email;
//   data['username'] = this.username;
//   data['password'] = this.password;
//   data['birthDate'] = this.birthDate;
//   data['gender'] = this.gender;
//   if (this.type != null) {
//     data['type'] = this.type!.map((v) => v.toJson()).toList();
//   }
//   if (this.followers != null) {
//     data['followers'] = this.followers!.map((v) => v.toJson()).toList();
//   }
//   if (this.clinicians != null) {
//     data['clinicians'] = this.clinicians!.map((v) => v.toJson()).toList();
//   }
//   if (this.chronics != null) {
//     data['chronics'] = this.chronics!.map((v) => v.toJson()).toList();
//   }
//   data['createdAt'] = this.createdAt;
//   data['updatedAt'] = this.updatedAt;
//   data['__v'] = this.iV;
//   return data;
// }
}
