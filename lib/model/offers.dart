class Offers {
  List<OffersData>? data;
  String? result;
  String? apiStatus;

  Offers({this.data, this.result, this.apiStatus});

  Offers.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OffersData>[];
      json['data'].forEach((v) {
        data!.add(OffersData.fromJson(v));
      });
    }
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['result'] = result;
    data['api_status'] = apiStatus;
    return data;
  }
}

class OffersData {
  String? id;
  String? offerName;
  String? offerCode;
  String? description;
  String? discount;
  String? uptoAmount;
  String? expireDate;
  String? image;
  String? strtotime;
  String? path;

  OffersData(
      {this.id,
      this.offerName,
      this.offerCode,
      this.description,
      this.discount,
      this.uptoAmount,
      this.expireDate,
      this.image,
      this.strtotime,
      this.path});

  OffersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerName = json['offer_name'];
    offerCode = json['offer_code'];
    description = json['description'];
    discount = json['discount'];
    uptoAmount = json['upto_amount'];
    expireDate = json['expire_date'];
    image = json['image'];
    strtotime = json['strtotime'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offer_name'] = offerName;
    data['offer_code'] = offerCode;
    data['description'] = description;
    data['discount'] = discount;
    data['upto_amount'] = uptoAmount;
    data['expire_date'] = expireDate;
    data['image'] = image;
    data['strtotime'] = strtotime;
    data['path'] = path;
    return data;
  }
}
