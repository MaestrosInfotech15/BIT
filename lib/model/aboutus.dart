class AboutUs {
  String? data;
  String? result;
  String? apiStatus;

  AboutUs({this.data, this.result, this.apiStatus});

  AboutUs.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['result'] = this.result;
    data['api_status'] = this.apiStatus;
    return data;
  }
}
