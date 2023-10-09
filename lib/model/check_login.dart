class CheckLogin {
  CheckLoginData? data;
  String? result;
  String? apiStatus;

  CheckLogin({this.data, this.result, this.apiStatus});

  CheckLogin.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CheckLoginData.fromJson(json['data']) : null;
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['result'] = result;
    data['api_status'] = apiStatus;
    return data;
  }

}

class CheckLoginData {
  String? id;
  String? blockStatus;

  CheckLoginData({this.id, this.blockStatus});

  CheckLoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blockStatus = json['block_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['block_status'] = blockStatus;
    return data;
  }
}
