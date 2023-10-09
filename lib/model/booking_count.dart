class BookingCount {
  int? bookingCount;
  bool? status;

  BookingCount({this.bookingCount, this.status});

  BookingCount.fromJson(Map<String, dynamic> json) {
    bookingCount = json['booking_count'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_count'] = this.bookingCount;
    data['status'] = this.status;
    return data;
  }
}
