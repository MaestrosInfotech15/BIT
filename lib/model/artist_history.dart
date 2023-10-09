class ArtistHistory {
  List<ArtistHistoryData>? data;
  String? result;
  String? apiStatus;

  ArtistHistory({this.data, this.result, this.apiStatus});

  ArtistHistory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ArtistHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new ArtistHistoryData.fromJson(v));
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

class ArtistHistoryData {
  String? id;
  String? userId;
  String? userType;
  String? artistId;
  String? orderId;
  String? name;
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
  String? dateTime;
  String? userImg;
  String? planName;
  String? planDetails;
  String? path;

  ArtistHistoryData(
      {this.id,
        this.userId,
        this.userType,
        this.artistId,
        this.orderId,
        this.name,
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
        this.dateTime,
        this.userImg,
        this.planName,
        this.planDetails,
        this.path});

  ArtistHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    artistId = json['artist_id'];
    orderId = json['order_id'];
    name = json['name'];
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
    dateTime = json['date_time'];
    userImg = json['user_img'];
    planName = json['plan_name'];
    planDetails = json['plan_details'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['artist_id'] = this.artistId;
    data['order_id'] = this.orderId;
    data['name'] = this.name;
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
    data['date_time'] = this.dateTime;
    data['user_img'] = this.userImg;
    data['plan_name'] = this.planName;
    data['plan_details'] = this.planDetails;
    data['path'] = this.path;
    return data;
  }
}
