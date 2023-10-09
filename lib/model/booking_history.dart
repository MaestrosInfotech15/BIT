class BookingHistory {
  List<BookingHistoryData>? data;
  String? apiStatus;

  BookingHistory({this.data, this.apiStatus});

  BookingHistory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookingHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new BookingHistoryData.fromJson(v));
      });
    }
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['api_status'] = this.apiStatus;
    return data;
  }
}

class BookingHistoryData {
  String? id;
  String? userId;
  String? userType;
  String? artistId;
  String? orderId;
  String? name;
  String? nick_name;
  String? contact;
  String? address;
  String? purpose;
  String? aboutProduct;
  String? kindService;
  String? dateIgPost;
  String? startDate;
  String? endDate;
  String? timeSlot;
  String? planId;
  String? offerId;
  String? totalAmt;
  String? bookingStatus;
  String? upcomingNotify;
  String? completeNotify;
  String? ongoingNotify;
  String? cancelNotify;
  String? paymentStatus;
  String? transactionId;
  String? strtotime;
  String? rating;
  String? planname;
  String? details;
  String? artistImg;
  String? path;
  ArtistDetailHistory? artistDetail;

  BookingHistoryData(
      {this.id,
        this.userId,
        this.userType,
        this.artistId,
        this.orderId,
        this.name,
        this.nick_name,
        this.contact,
        this.address,
        this.purpose,
        this.aboutProduct,
        this.kindService,
        this.dateIgPost,
        this.startDate,
        this.endDate,
        this.timeSlot,
        this.planId,
        this.offerId,
        this.totalAmt,
        this.bookingStatus,
        this.upcomingNotify,
        this.completeNotify,
        this.ongoingNotify,
        this.cancelNotify,
        this.paymentStatus,
        this.transactionId,
        this.strtotime,
        this.rating,
        this.planname,
        this.details,
        this.artistImg,
        this.path,
        this.artistDetail});

  BookingHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    artistId = json['artist_id'];
    orderId = json['order_id'];
    name = json['name'];
    nick_name = json['nick_name'];
    contact = json['contact'];
    address = json['address'];
    purpose = json['purpose'];
    aboutProduct = json['about_product'];
    kindService = json['kind_service'];
    dateIgPost = json['date_ig_post'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    timeSlot = json['time_slot'];
    planId = json['plan_id'];
    offerId = json['offer_id'];
    totalAmt = json['total_amt'];
    bookingStatus = json['booking_status'];
    upcomingNotify = json['upcoming_notify'];
    completeNotify = json['complete_notify'];
    ongoingNotify = json['ongoing_notify'];
    cancelNotify = json['cancel_notify'];
    paymentStatus = json['payment_status'];
    transactionId = json['transaction_id'];
    strtotime = json['strtotime'];
    rating = json['rating'];
    planname = json['planname'];
    details = json['details'];
    artistImg = json['artist_img'];
    path = json['path'];
    artistDetail = json['artist_detail'] != null
        ? new ArtistDetailHistory.fromJson(json['artist_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['artist_id'] = this.artistId;
    data['order_id'] = this.orderId;
    data['name'] = this.name;
    data['nick_name'] = this.nick_name;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['purpose'] = this.purpose;
    data['about_product'] = this.aboutProduct;
    data['kind_service'] = this.kindService;
    data['date_ig_post'] = this.dateIgPost;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['time_slot'] = this.timeSlot;
    data['plan_id'] = this.planId;
    data['offer_id'] = this.offerId;
    data['total_amt'] = this.totalAmt;
    data['booking_status'] = this.bookingStatus;
    data['upcoming_notify'] = this.upcomingNotify;
    data['complete_notify'] = this.completeNotify;
    data['ongoing_notify'] = this.ongoingNotify;
    data['cancel_notify'] = this.cancelNotify;
    data['payment_status'] = this.paymentStatus;
    data['transaction_id'] = this.transactionId;
    data['strtotime'] = this.strtotime;
    data['rating'] = this.rating;
    data['planname'] = this.planname;
    data['details'] = this.details;
    data['artist_img'] = this.artistImg;
    data['path'] = this.path;
    if (this.artistDetail != null) {
      data['artist_detail'] = this.artistDetail!.toJson();
    }
    return data;
  }
}

class ArtistDetailHistory {
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
  String? catId;
  String? subcatId;
  String? fee;
  String? about;
  String? images;
  String? referCode;
  Null? referCodeAmt;
  String? blockStatus;
  String? profileType;
  String? strotime;
  String? dob;
  String? doa;

  ArtistDetailHistory(
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
        this.catId,
        this.subcatId,
        this.fee,
        this.about,
        this.images,
        this.referCode,
        this.referCodeAmt,
        this.blockStatus,
        this.profileType,
        this.strotime,
        this.dob,
        this.doa});

  ArtistDetailHistory.fromJson(Map<String, dynamic> json) {
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
    catId = json['cat_id'];
    subcatId = json['subcat_id'];
    fee = json['fee'];
    about = json['about'];
    images = json['images'];
    referCode = json['refer_code'];
    referCodeAmt = json['refer_code_amt'];
    blockStatus = json['block_status'];
    profileType = json['profile_type'];
    strotime = json['strotime'];
    dob = json['dob'];
    doa = json['doa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['cat_id'] = this.catId;
    data['subcat_id'] = this.subcatId;
    data['fee'] = this.fee;
    data['about'] = this.about;
    data['images'] = this.images;
    data['refer_code'] = this.referCode;
    data['refer_code_amt'] = this.referCodeAmt;
    data['block_status'] = this.blockStatus;
    data['profile_type'] = this.profileType;
    data['strotime'] = this.strotime;
    data['dob'] = this.dob;
    data['doa'] = this.doa;
    return data;
  }
}
