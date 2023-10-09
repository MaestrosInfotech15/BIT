class AddPlan {
  String? result;
  String? apiStatus;

  AddPlan({this.result, this.apiStatus});

  AddPlan.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['api_status'] = this.apiStatus;
    return data;
  }
}