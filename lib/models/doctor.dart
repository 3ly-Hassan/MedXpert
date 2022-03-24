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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    residency = json['residency'];
    specialization = json['specialization'];
    followings = json['followings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;
    data['username'] = this.username;
    data['bio'] = this.bio;
    data['gender'] = this.gender;
    if (this.specialization != null) {
      data['specialization'] =
          this.specialization!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
