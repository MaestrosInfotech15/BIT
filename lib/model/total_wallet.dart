class TotalWallet {
  String? totalAmount;
  String? apiStatus;

  TotalWallet({this.totalAmount, this.apiStatus});

  TotalWallet.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this.totalAmount;
    data['api_status'] = this.apiStatus;
    return data;
  }
}
