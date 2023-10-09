class ArtistInfo {
  ArtistInfoData? data;
  String? result;
  String? apiStatus;

  ArtistInfo({this.data, this.result, this.apiStatus});

  ArtistInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ArtistInfoData.fromJson(json['data']) : null;
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['result'] = this.result;
    data['api_status'] = this.apiStatus;
    return data;
  }
}

class ArtistInfoData {
  List<ArtistCategory>? category;
  List<ArtistSubcat>? subcat;
  String? facebook;
  String? instagram;
  String? youtube;
  String? linkedin;
  String? name;
  String? fee;
  String? about;
  String? email;

  ArtistInfoData(
      {this.category,
        this.subcat,
        this.facebook,
        this.instagram,
        this.youtube,
        this.linkedin,
        this.name,
        this.fee,
        this.about,
        this.email});

  ArtistInfoData.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <ArtistCategory>[];
      json['category'].forEach((v) {
        category!.add(new ArtistCategory.fromJson(v));
      });
    }
    if (json['subcat'] != null) {
      subcat = <ArtistSubcat>[];
      json['subcat'].forEach((v) {
        subcat!.add(new ArtistSubcat.fromJson(v));
      });
    }
    facebook = json['facebook'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    linkedin = json['linkedin'];
    name = json['name'];
    fee = json['fee'];
    about = json['about'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.subcat != null) {
      data['subcat'] = this.subcat!.map((v) => v.toJson()).toList();
    }
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['linkedin'] = this.linkedin;
    data['name'] = this.name;
    data['fee'] = this.fee;
    data['about'] = this.about;
    data['email'] = this.email;
    return data;
  }
}

class ArtistCategory {
  String? id;
  String? name;

  ArtistCategory({this.id, this.name});

  ArtistCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ArtistSubcat {
  String? id;
  String? subName;

  ArtistSubcat({this.id, this.subName});

  ArtistSubcat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_name'] = this.subName;
    return data;
  }
}
