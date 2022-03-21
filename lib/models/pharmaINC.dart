class PharmaINC {
  String? id;
  String? email;
  String? username;
  String? password;
  String? location;
  String? createdAt;
  String? updatedAt;

  PharmaINC({
    this.id,
    this.email,
    this.username,
    this.password,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  PharmaINC.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    email =json['email'];
    username =json['username'];
    password =json['password'];
    location =json['Location'];
    createdAt =json['createdAt'];
    updatedAt =json['updatedAt'];
  }
}
