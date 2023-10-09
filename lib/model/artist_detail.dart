class ArtistDetail {
  String? name;
  String? nick_name;
  bool? favourite;
  String? img;
  List<String>? carousalImg;
  String? about;
  String? facebook;
  String? instagram;
  String? youtube;
  String? linkedin;
  List<EventPhotos>? eventPhotos;
  List<EventPhotos>? eventVideos;
  List<ArtistDetailReview>? review;
  String? result;
  String? apiStatus;
  String? path;

  ArtistDetail(
      {this.name,
      this.nick_name,
      this.favourite,
      this.img,
      this.carousalImg,
      this.about,
      this.facebook,
      this.instagram,
      this.youtube,
      this.linkedin,
      this.eventPhotos,
      this.eventVideos,
      this.review,
      this.result,
      this.apiStatus,
      this.path});

  ArtistDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nick_name = json['nick_name'];
    favourite = json['favourite'];
    img = json['img'];
    carousalImg = json['carousal_img'].cast<String>();
    about = json['about'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    linkedin = json['linkedin'];
    if (json['event_photos'] != null) {
      eventPhotos = <EventPhotos>[];
      json['event_photos'].forEach((v) {
        eventPhotos!.add(EventPhotos.fromJson(v));
      });
    }
    if (json['event_videos'] != null) {
      eventVideos = <EventPhotos>[];
      json['event_videos'].forEach((v) {
        eventVideos!.add(EventPhotos.fromJson(v));
      });
    }
    if (json['review'] != null) {
      review = <ArtistDetailReview>[];
      json['review'].forEach((v) {
        review!.add(ArtistDetailReview.fromJson(v));
      });
    }
    result = json['result'];
    apiStatus = json['api_status'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['nick_name'] = nick_name;
    data['favourite'] = favourite;
    data['img'] = img;
    data['carousal_img'] = carousalImg;
    data['about'] = about;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    data['linkedin'] = linkedin;
    if (eventPhotos != null) {
      data['event_photos'] = eventPhotos!.map((v) => v.toJson()).toList();
    }
    if (eventVideos != null) {
      data['event_videos'] = eventVideos!.map((v) => v.toJson()).toList();
    }
    if (review != null) {
      data['review'] = review!.map((v) => v.toJson()).toList();
    }
    data['result'] = result;
    data['api_status'] = apiStatus;
    data['path'] = path;
    return data;
  }
}

class EventPhotos {
  String? imgVdo;
  String? id;

  EventPhotos({this.imgVdo,this.id});

  EventPhotos.fromJson(Map<String, dynamic> json) {
    imgVdo = json['img_vdo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img_vdo'] = imgVdo;
    data['id'] = id;
    return data;
  }
}

class ArtistDetailReview {
  String? id;
  String? userId;
  String? userType;
  String? givingId;
  String? givingType;
  String? giving_name;
  String? rating;
  String? comment;
  String? images;
  String? strtotime;
  String? user_name;
  String? img;
  String? date_time;

  ArtistDetailReview(
      {this.id,
      this.userId,
      this.userType,
      this.givingId,
      this.givingType,
      this.rating,
      this.comment,
      this.images,
      this.strtotime,
      this.user_name,
      this.giving_name,
      this.img});

  ArtistDetailReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    givingId = json['giving_id'];
    givingType = json['giving_type'];
    rating = json['rating'];
    comment = json['comment'];
    images = json['images'];
    strtotime = json['strtotime'];
    user_name = json['user_name'];
    giving_name = json['giving_name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['giving_id'] = givingId;
    data['giving_type'] = givingType;
    data['rating'] = rating;
    data['comment'] = comment;
    data['images'] = images;
    data['strtotime'] = strtotime;
    data['user_name'] = user_name;
    data['giving_name'] = giving_name;
    data['img'] = img;
    return data;
  }
}
