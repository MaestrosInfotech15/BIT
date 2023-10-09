class Talent {
  List<TalentData>? data;
  String? result;
  String? apiStatus;

  Talent({this.data, this.result, this.apiStatus});

  Talent.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TalentData>[];
      json['data'].forEach((v) {
        data!.add(new TalentData.fromJson(v));
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

class TalentData {
  String? id;
  String? name;
  String? nickName;
  String? img;
  String? fee;
  String? catId;
  String? subcatId;
  String? email;
  String? profileType;
  String? averageRating;
  String? rating;
  bool? favourite;
  String? category;
  String? subcategory;
  String? path;

  TalentData(
      {this.id,
        this.name,
        this.nickName,
        this.img,
        this.fee,
        this.catId,
        this.subcatId,
        this.email,
        this.profileType,
        this.averageRating,
        this.rating,
        this.favourite,
        this.category,
        this.subcategory,
        this.path});

  TalentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickName = json['nick_name'];
    img = json['img'];
    fee = json['fee'];
    catId = json['cat_id'];
    subcatId = json['subcat_id'];
    email = json['email'];
    profileType = json['profile_type'];
    averageRating = json['average_rating'];
    rating = json['rating'];
    favourite = json['favourite'];
    category = json['category'];
    subcategory = json['subcategory'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nick_name'] = this.nickName;
    data['img'] = this.img;
    data['fee'] = this.fee;
    data['cat_id'] = this.catId;
    data['subcat_id'] = this.subcatId;
    data['email'] = this.email;
    data['profile_type'] = this.profileType;
    data['average_rating'] = this.averageRating;
    data['rating'] = this.rating;
    data['favourite'] = this.favourite;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['path'] = this.path;
    return data;
  }
}
