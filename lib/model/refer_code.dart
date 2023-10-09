class ReferCode {
  ReferCodeData? data;
  String? result;
  String? apiStatus;

  ReferCode({this.data, this.result, this.apiStatus});

  ReferCode.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ReferCodeData.fromJson(json['data']) : null;
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['result'] = this.result;
    data['api_status'] = this.apiStatus;
    return data;
  }
}

class ReferCodeData {
  String? id;
  String? referCode;

  ReferCodeData({this.id, this.referCode});

  ReferCodeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referCode = json['refer_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['refer_code'] = this.referCode;
    return data;
  }
}
