class Wallet {
  String? wallet;
  String? result;
  String? apiStatus;
  List<WalletData>? data;

  Wallet({this.wallet, this.result, this.apiStatus, this.data});

  Wallet.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    result = json['result'];
    apiStatus = json['api_status'];
    if (json['data'] != null) {
      data = <WalletData>[];
      json['data'].forEach((v) {
        data!.add(new WalletData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet'] = this.wallet;
    data['result'] = this.result;
    data['api_status'] = this.apiStatus;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletData {
  String? id;
  String? strtotime;
  String? amt;
  String? date;

  WalletData({this.id, this.strtotime, this.amt, this.date});

  WalletData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    strtotime = json['strtotime'];
    amt = json['amt'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['strtotime'] = this.strtotime;
    data['amt'] = this.amt;
    data['date'] = this.date;
    return data;
  }
}
