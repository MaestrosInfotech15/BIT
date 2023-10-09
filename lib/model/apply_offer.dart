class ApplyOffer {
  int? grandTotal;
  String? result;
  String? apiStatus;

  ApplyOffer({this.grandTotal, this.result, this.apiStatus});

  ApplyOffer.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grand_total'] = grandTotal;
    data['result'] = result;
    data['api_status'] = apiStatus;
    return data;
  }
}
