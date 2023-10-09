class ArtistRegister {
  bool? status;
  int? statusCode;
  String? message;
  ArtistRegisterData? data;

  ArtistRegister({this.status, this.statusCode, this.message, this.data});

  ArtistRegister.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status code'];
    message = json['message'];
    data = json['data'] != null ? new ArtistRegisterData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ArtistRegisterData {
  String? personName;
  String? contactNumber;
  String? email;
  String? category;
  String? subCategories;
  String? updatedAt;
  String? createdAt;
  int? id;

  ArtistRegisterData(
      {this.personName,
        this.contactNumber,
        this.email,
        this.category,
        this.subCategories,
        this.updatedAt,
        this.createdAt,
        this.id});

  ArtistRegisterData.fromJson(Map<String, dynamic> json) {
    personName = json['person_name'];
    contactNumber = json['contact_number'];
    email = json['email'];
    category = json['category'];
    subCategories = json['sub_categories'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_name'] = this.personName;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['category'] = this.category;
    data['sub_categories'] = this.subCategories;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
