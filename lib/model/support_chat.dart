class SupportChat {
  List<SupportChatData>? data;
  String? result;
  String? apiStatus;

  SupportChat({this.data, this.result, this.apiStatus});

  SupportChat.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SupportChatData>[];
      json['data'].forEach((v) {
        data!.add(new SupportChatData.fromJson(v));
      });
    }
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['result'] = this.result;
    data['api_status'] = this.apiStatus;
    return data;
  }
}

class SupportChatData {
  String? type;
  String? msg;
  String? dateTime;

  SupportChatData({this.type, this.msg, this.dateTime});

  SupportChatData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    msg = json['msg'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['msg'] = this.msg;
    data['date_time'] = this.dateTime;
    return data;
  }
}
