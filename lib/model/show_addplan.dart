class ShowAddPlan {
  List<ShowPlanData>? data;
  String? result;
  String? apiStatus;
  ShowAddPlan({this.data, this.result, this.apiStatus});
  ShowAddPlan.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowPlanData>[];
      json['data'].forEach((v) {
        data!.add(new ShowPlanData.fromJson(v));
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
class ShowPlanData {
  String? id;
  String? artistId;
  String? name;
  String? details;
  String? amount;
  String? strtotime;
  ShowPlanData(
      {this.id,
        this.artistId,
        this.name,
        this.details,
        this.amount,
        this.strtotime});
  ShowPlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artistId = json['artist_id'];
    name = json['name'];
    details = json['details'];
    amount = json['amount'];
    strtotime = json['strtotime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['artist_id'] = this.artistId;
    data['name'] = this.name;
    data['details'] = this.details;
    data['amount'] = this.amount;
    data['strtotime'] = this.strtotime;
    return data;
  }
}