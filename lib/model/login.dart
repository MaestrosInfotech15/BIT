class Login {
  String? id;
  String? name;
  String? nickName;
  String? email;
  String? contact;
  String? token;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? gender;
  String? img;
  String? corporateName;
  String? website;
  String? type;
  String? referCode;
  String? referCodeAmt;
  String? status;
  String? blockStatus;
  String? strotime;
  String? dob;
  String? doa;
  String? profileStatus;
  String? userType;
  String? result;
  String? apiStatus;
  String? path;

  Login(
      {this.id,
        this.name,
        this.nickName,
        this.email,
        this.contact,
        this.token,
        this.address,
        this.city,
        this.state,
        this.zip,
        this.gender,
        this.img,
        this.corporateName,
        this.website,
        this.type,
        this.referCode,
        this.referCodeAmt,
        this.status,
        this.blockStatus,
        this.strotime,
        this.dob,
        this.doa,
        this.profileStatus,
        this.userType,
        this.result,
        this.apiStatus,
        this.path});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickName = json['nick_name'];
    email = json['email'];
    contact = json['contact'];
    token = json['token'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    gender = json['gender'];
    img = json['img'];
    corporateName = json['corporate_name'];
    website = json['website'];
    type = json['type'];
    referCode = json['refer_code'];
    referCodeAmt = json['refer_code_amt'];
    status = json['status'];
    blockStatus = json['block_status'];
    strotime = json['strotime'];
    dob = json['dob'];
    doa = json['doa'];
    profileStatus = json['profile_status'];
    userType = json['user_type'];
    result = json['result'];
    apiStatus = json['api_status'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nick_name'] = this.nickName;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['token'] = this.token;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['gender'] = this.gender;
    data['img'] = this.img;
    data['corporate_name'] = this.corporateName;
    data['website'] = this.website;
    data['type'] = this.type;
    data['refer_code'] = this.referCode;
    data['refer_code_amt'] = this.referCodeAmt;
    data['status'] = this.status;
    data['block_status'] = this.blockStatus;
    data['strotime'] = this.strotime;
    data['dob'] = this.dob;
    data['doa'] = this.doa;
    data['profile_status'] = this.profileStatus;
    data['user_type'] = this.userType;
    data['result'] = this.result;
    data['api_status'] = this.apiStatus;
    data['path'] = this.path;
    return data;
  }
}
