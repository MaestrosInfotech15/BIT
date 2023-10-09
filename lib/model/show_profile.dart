class ShowProfile {
  ShowProfileData? data;
  String? result;
  String? apiStatus;
  String? path;

  ShowProfile({this.data, this.result, this.apiStatus, this.path});

  ShowProfile.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ShowProfileData.fromJson(json['data']) : null;
    result = json['result'];
    apiStatus = json['api_status'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['result'] = this.result;
    data['api_status'] = this.apiStatus;
    data['path'] = this.path;
    return data;
  }
}

class ShowProfileData {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? gender;
  String? images;
  String? dob;
  String? doa;
  String? nick_name;

  ShowProfileData(
      {this.id,
        this.name,
        this.email,
        this.contact,
        this.address,
        this.city,
        this.state,
        this.zip,
        this.gender,
        this.dob,
        this.doa,
        this.nick_name,
        this.images});

  ShowProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    gender = json['gender'];
    images = json['img'];
    dob = json['dob'];
    doa = json['doa'];
    nick_name = json['nick_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['gender'] = this.gender;
    data['img'] = this.images;
    data['dob'] = this.dob;
    data['doa'] = this.doa;
    data['nick_name'] = this.nick_name;
    return data;
  }
}
