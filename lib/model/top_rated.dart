class TopRated {
  List<TopRatedData>? data;
  String? result;
  String? apiStatus;

  TopRated({this.data, this.result, this.apiStatus});

  TopRated.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TopRatedData>[];
      json['data'].forEach((v) {
        data!.add(TopRatedData.fromJson(v));
      });
    }
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['result'] = result;
    data['api_status'] = apiStatus;
    return data;
  }
}

class TopRatedData {
  String? id;
  String? name;
  String? img;
  String? fee;
  String? catId;
  String? category;
  String? rating;
  String? path;

  TopRatedData(
      {this.id,
        this.name,
        this.img,
        this.fee,
        this.catId,
        this.category,
        this.rating,
        this.path});

  TopRatedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    fee = json['fee'];
    catId = json['cat_id'];
    category = json['category'];
    rating = json['rating'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['fee'] = fee;
    data['cat_id'] = catId;
    data['category'] = category;
    data['rating'] = rating;
    data['path'] = path;
    return data;
  }
}
