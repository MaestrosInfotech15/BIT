class ArtistWallet {
  List<ArtistWalletData>? data;
  String? result;
  String? apiStatus;

  ArtistWallet({this.data, this.result, this.apiStatus});

  ArtistWallet.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ArtistWalletData>[];
      json['data'].forEach((v) {
        data!.add(new ArtistWalletData.fromJson(v));
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

class ArtistWalletData {
  String? id;
  String? artistId;
  String? amount;
  String? strtotime;
  String? artistName;
  String? email;
  String? contact;
  String? dates;

  ArtistWalletData(
      {this.id,
        this.artistId,
        this.amount,
        this.strtotime,
        this.artistName,
        this.email,
        this.contact,
        this.dates});

  ArtistWalletData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artistId = json['artist_id'];
    amount = json['amount'];
    strtotime = json['strtotime'];
    artistName = json['artist_name'];
    email = json['email'];
    contact = json['contact'];
    dates = json['dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['artist_id'] = this.artistId;
    data['amount'] = this.amount;
    data['strtotime'] = this.strtotime;
    data['artist_name'] = this.artistName;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['dates'] = this.dates;
    return data;
  }
}
