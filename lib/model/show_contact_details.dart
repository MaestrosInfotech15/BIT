class ShowContactDetails {
  ShowContactDetailsData? data;
  String? result;
  String? apiStatus;

  ShowContactDetails({this.data, this.result, this.apiStatus});

  ShowContactDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ShowContactDetailsData.fromJson(json['data']) : null;
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

class ShowContactDetailsData {
  String? id;
  String? userId;
  String? userType;
  String? mobile;
  String? alternateMobile;
  String? email;
  String? alternateEmail;
  String? strtotime;
  String? artistName;
  String? contact;
  String? dates;

  ShowContactDetailsData(
      {this.id,
        this.userId,
        this.userType,
        this.mobile,
        this.alternateMobile,
        this.email,
        this.alternateEmail,
        this.strtotime,
        this.artistName,
        this.contact,
        this.dates});

  ShowContactDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    email = json['email'];
    alternateEmail = json['alternate_email'];
    strtotime = json['strtotime'];
    artistName = json['artist_name'];
    contact = json['contact'];
    dates = json['dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alternateMobile;
    data['email'] = this.email;
    data['alternate_email'] = this.alternateEmail;
    data['strtotime'] = this.strtotime;
    data['artist_name'] = this.artistName;
    data['contact'] = this.contact;
    data['dates'] = this.dates;
    return data;
  }
}
