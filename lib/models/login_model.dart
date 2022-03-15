class LoginResponseModel {
  final String? token;
  final String? msg;

  LoginResponseModel({this.token, this.msg});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      msg: json["msg"] != null ? json["msg"] : "",
    );
  }
}

class LoginRequestModel {
  String? email;
  String? password;
  String? role;

  LoginRequestModel({this.email, this.password, this.role});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'password': password?.trim(),
      'role': role?.trim(),
    };

    return map;
  }
}
