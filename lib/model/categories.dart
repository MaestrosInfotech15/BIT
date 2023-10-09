class Category {
  List<CategoryData>? data;
  String? result;
  String? apiStatus;

  Category({this.data, this.result, this.apiStatus});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryData.fromJson(v));
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

class CategoryData {
  String? id;
  String? name;
  String? image;
  String? strtotime;
  String? path;

  CategoryData({this.id, this.name, this.image, this.strtotime, this.path});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    strtotime = json['strtotime'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['strtotime'] = this.strtotime;
    data['path'] = this.path;
    return data;
  }
}
