class MostPopular {
  List<MostPopularData>? data;
  String? result;
  String? apiStatus;

  MostPopular({this.data, this.result, this.apiStatus});

  MostPopular.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MostPopularData>[];
      json['data'].forEach((v) {
        data!.add(new MostPopularData.fromJson(v));
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

class MostPopularData {
  String? id;
  String? name;
  String? img;
  String? path;

  MostPopularData({this.id, this.name, this.img, this.path});

  MostPopularData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['path'] = this.path;
    return data;
  }
}
