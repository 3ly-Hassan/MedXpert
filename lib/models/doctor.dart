class Doctor {
  String? email;
  String? username;
  String? password;
  String? bio;
  String? gender;
  String? createdAt;
  String? updatedAt;
  String? residency;
  List<dynamic>? specialization;
  List<dynamic>? followings;

  Doctor({
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

  Doctor.fromJson(Map<String,dynamic> json){
    email = json['emai'];
    username = json['usernam'];
    password = json['passwor'];
    bio = json['bi'];
    gender = json['gende'];
    createdAt = json['createdA'];
    updatedAt = json['updatedA'];
    residency = json['residenc'];
    specialization = json['specializatio'];
    followings = json['following'];
  }
}
