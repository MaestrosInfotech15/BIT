class ShowFavourite {
  List<ShowFavouriteData>? data;
  String? result;
  String? apiStatus;

  ShowFavourite({this.data, this.result, this.apiStatus});

  ShowFavourite.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowFavouriteData>[];
      json['data'].forEach((v) {
        data!.add(new ShowFavouriteData.fromJson(v));
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

class ShowFavouriteData {
  String? artistId;
  String? name;
  String? fee;
  String? img;
  String? catId;
  String? email;
  String? subcatId;
  String? rating;
  String? id;
  String? category;
  String? subCategory;
  String? path;

  ShowFavouriteData(
      {this.artistId,
        this.name,
        this.fee,
        this.img,
        this.catId,
        this.email,
        this.subcatId,
        this.rating,
        this.id,
        this.category,
        this.subCategory,
        this.path});

  ShowFavouriteData.fromJson(Map<String, dynamic> json) {
    artistId = json['artist_id '];
    name = json['name'];
    fee = json['fee'];
    img = json['img'];
    catId = json['cat_id'];
    email = json['email'];
    subcatId = json['subcat_id'];
    rating = json['rating'];
    id = json['id'];
    category = json['category'];
    subCategory = json['sub_category'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artist_id '] = this.artistId;
    data['name'] = this.name;
    data['fee'] = this.fee;
    data['img'] = this.img;
    data['cat_id'] = this.catId;
    data['email'] = this.email;
    data['subcat_id'] = this.subcatId;
    data['rating'] = this.rating;
    data['id'] = this.id;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['path'] = this.path;
    return data;
  }
}
