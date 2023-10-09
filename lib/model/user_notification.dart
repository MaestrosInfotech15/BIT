class UserNotification {
  List<UserNotificationData>? data;
  String? result;
  String? apiStatus;

  UserNotification({this.data, this.result, this.apiStatus});

  UserNotification.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserNotificationData>[];
      json['data'].forEach((v) {
        data!.add(new UserNotificationData.fromJson(v));
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

class UserNotificationData {
  String? id;
  String? title;
  String? body;
  String? strtotime;
  String? dateTime;
  String? path;

  UserNotificationData(
      {this.id,
        this.title,
        this.body,
        this.strtotime,
        this.dateTime,
        this.path});

  UserNotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    strtotime = json['strtotime'];
    dateTime = json['date_time'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['strtotime'] = this.strtotime;
    data['date_time'] = this.dateTime;
    data['path'] = this.path;
    return data;
  }
}
