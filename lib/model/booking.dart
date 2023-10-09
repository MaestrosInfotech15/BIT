class Booking {
  String? bookingId;
  String? result;
  String? apiStatus;

  Booking({this.bookingId, this.result, this.apiStatus});

  Booking.fromJson(Map<String, dynamic> json) {
    bookingId = json['Booking_id'];
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Booking_id'] = bookingId;
    data['result'] = result;
    data['api_status'] = apiStatus;
    return data;
  }
}
