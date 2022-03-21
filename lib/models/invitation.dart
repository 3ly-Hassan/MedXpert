class Invitation {
  String? invitaionNumber;
  String? patientId;
  String? createdAt;
  String? updatedAt;

  Invitation({
    this.invitaionNumber,
    this.patientId,
    this.createdAt,
    this.updatedAt,
  });
  Invitation.fromJson(Map<String, dynamic> json) {
    invitaionNumber = json['invitaionNumber'];
    patientId = json['patient_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class InvitationResponseModel {
  final String? msg;

  InvitationResponseModel({this.msg});

  factory InvitationResponseModel.fromJson(Map<String, dynamic> json) {
    return InvitationResponseModel(
      msg: json["msg"] != null ? json["msg"] : "",
    );
  }
}
