class ArtistNotification {
  List<ArtistNotificationData>? data;
  String? result;
  String? apiStatus;

  ArtistNotification({this.data, this.result, this.apiStatus});

  ArtistNotification.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ArtistNotificationData>[];
      json['data'].forEach((v) {
        data!.add(new ArtistNotificationData.fromJson(v));
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

class ArtistNotificationData {
  String? id;
  String? title1;
  String? body1;
  String? artistId;
  String? strtotime;
  String? dateTime;
  String? path;

  ArtistNotificationData(
      {this.id,
        this.title1,
        this.body1,
        this.artistId,
        this.strtotime,
        this.dateTime,
        this.path});

  ArtistNotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title1 = json['title1'];
    body1 = json['body1'];
    artistId = json['artist_id'];
    strtotime = json['strtotime'];
    dateTime = json['date_time'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title1'] = this.title1;
    data['body1'] = this.body1;
    data['artist_id'] = this.artistId;
    data['strtotime'] = this.strtotime;
    data['date_time'] = this.dateTime;
    data['path'] = this.path;
    return data;
  }
}
