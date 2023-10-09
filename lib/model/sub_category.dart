class SubCategory {
  List<SubCategoryData>? data;
  String? result;
  String? apiStatus;

  SubCategory({this.data, this.result, this.apiStatus});

  SubCategory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new SubCategoryData.fromJson(v));
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

class SubCategoryData {
  String? id;
  String? catId;
  String? subName;
  String? image;
  String? strtotime;
  String? categoryName;
  String? path;

  SubCategoryData(
      {this.id,
        this.catId,
        this.subName,
        this.image,
        this.strtotime,
        this.categoryName,
        this.path});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    subName = json['sub_name'];
    image = json['image'];
    strtotime = json['strtotime'];
    categoryName = json['category_name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['sub_name'] = this.subName;
    data['image'] = this.image;
    data['strtotime'] = this.strtotime;
    data['category_name'] = this.categoryName;
    data['path'] = this.path;
    return data;
  }
}
