class ShowRating {
  List<ShowRatingData>? data;
  String? result;
  String? apiStatus;

  ShowRating({this.data, this.result, this.apiStatus});

  ShowRating.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowRatingData>[];
      json['data'].forEach((v) {
        data!.add(new ShowRatingData.fromJson(v));
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

class ShowRatingData {
  String? id;
  String? userId;
  String? userType;
  String? givingId;
  String? givingType;
  String? rating;
  String? comment;
  String? images;
  String? strtotime;
  String? dateTime;
  String? name;
  String? userImg;
  String? path;

  ShowRatingData(
      {this.id,
        this.userId,
        this.userType,
        this.givingId,
        this.givingType,
        this.rating,
        this.comment,
        this.images,
        this.strtotime,
        this.dateTime,
        this.name,
        this.userImg,
        this.path});

  ShowRatingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    givingId = json['giving_id'];
    givingType = json['giving_type'];
    rating = json['rating'];
    comment = json['comment'];
    images = json['images'];
    strtotime = json['strtotime'];
    dateTime = json['date_time'];
    name = json['name'];
    userImg = json['user_img'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['giving_id'] = this.givingId;
    data['giving_type'] = this.givingType;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['images'] = this.images;
    data['strtotime'] = this.strtotime;
    data['date_time'] = this.dateTime;
    data['name'] = this.name;
    data['user_img'] = this.userImg;
    data['path'] = this.path;
    return data;
  }
}
