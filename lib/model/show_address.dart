class ShowAddress {
  List<ShowAddressData>? data;
  String? result;
  String? apiStatus;

  ShowAddress({this.data, this.result, this.apiStatus});

  ShowAddress.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowAddressData>[];
      json['data'].forEach((v) {
        data!.add(new ShowAddressData.fromJson(v));
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

class ShowAddressData {
  String? id;
  String? userId;
  String? userType;
  String? pincode;
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? adreessType;
  String? strtotime;
  String? name;

  ShowAddressData(
      {this.id,
        this.userId,
        this.userType,
        this.pincode,
        this.address,
        this.landmark,
        this.city,
        this.state,
        this.adreessType,
        this.strtotime,
        this.name});

  ShowAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    pincode = json['pincode'];
    address = json['address'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    adreessType = json['adreess_type'];
    strtotime = json['strtotime'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['pincode'] = this.pincode;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['adreess_type'] = this.adreessType;
    data['strtotime'] = this.strtotime;
    data['name'] = this.name;
    return data;
  }
}
