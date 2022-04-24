class SignUpResponseModel {
  final String? msg;

  SignUpResponseModel({this.msg});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      msg: json["msg"] != null ? json["msg"] : "",
    );
  }
}

class ForgetPassResponseModel {
  final String? msg;
  int? statusCode;

  ForgetPassResponseModel({this.statusCode, this.msg});

  factory ForgetPassResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgetPassResponseModel(
      msg: json["msg"] != null ? json["msg"] : "",
    );
  }
}

class ForgetPassRequestModel {
  String? email;
  String? role;

  ForgetPassRequestModel({
    this.email,
    this.role,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'role': role?.trim(),
    };

    return map;
  }
}

class SignUpRequestModel {
  String? username;
  String? email;
  String? password;
  String? gender;
  String? birthDate;
  String? role;

  SignUpRequestModel(
      {this.email,
      this.password,
      this.role,
      this.birthDate,
      this.gender,
      this.username});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'password': password?.trim(),
      'role': role?.trim(),
      'username': username?.trim(),
      'gender': gender?.trim(),
      'birthDate': birthDate?.trim(),
    };

    return map;
  }
}
