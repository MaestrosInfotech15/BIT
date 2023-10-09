class Verifyotp {
  bool? status;
  int? messageId;
  String? message;
  VerifyotpData? data;

  Verifyotp({this.status, this.messageId, this.message, this.data});

  Verifyotp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageId = json['messageId'];
    message = json['message'];
    data = json['data'] != null ? new VerifyotpData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messageId'] = this.messageId;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class VerifyotpData {
  User? user;

  VerifyotpData({this.user});

  VerifyotpData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? mobileNo;
  String? createdAt;
  String? updatedAt;

  User({this.mobileNo, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobile_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_no'] = this.mobileNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
