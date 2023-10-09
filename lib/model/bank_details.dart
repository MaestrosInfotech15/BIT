class BankDetails {
  List<BankDetailsData>? data;
  String? result;
  String? apiStatus;

  BankDetails({this.data, this.result, this.apiStatus});

  BankDetails.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BankDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new BankDetailsData.fromJson(v));
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

class BankDetailsData {
  String? id;
  String? artistId;
  String? accountholder;
  String? bankName;
  String? acNo;
  String? ifscCode;
  String? branchaddress;
  String? strtotime;

  BankDetailsData(
      {this.id,
        this.artistId,
        this.accountholder,
        this.bankName,
        this.acNo,
        this.ifscCode,
        this.branchaddress,
        this.strtotime});

  BankDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artistId = json['artist_id'];
    accountholder = json['accountholder'];
    bankName = json['bank_name'];
    acNo = json['ac_no'];
    ifscCode = json['ifsc_code'];
    branchaddress = json['branchaddress'];
    strtotime = json['strtotime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['artist_id'] = this.artistId;
    data['accountholder'] = this.accountholder;
    data['bank_name'] = this.bankName;
    data['ac_no'] = this.acNo;
    data['ifsc_code'] = this.ifscCode;
    data['branchaddress'] = this.branchaddress;
    data['strtotime'] = this.strtotime;
    return data;
  }
}
