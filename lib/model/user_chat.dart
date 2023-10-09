class UserChat {
  String? uid;
  String? fullName;
  String? email;
  String? profilePic;
  String? token;
  String? userType;

  UserChat(
      {this.uid,
      this.fullName,
      this.profilePic,
      this.email,
      this.token,
      this.userType});

  UserChat.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    fullName = map['full_name'];
    email = map['email'];
    profilePic = map['profile_pic'];
    token = map['token'];
    userType = map['user_type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'full_name': fullName,
      'email': email,
      'profile_pic': profilePic,
      'token': token,
      'user_type': userType
    };
  }
}
