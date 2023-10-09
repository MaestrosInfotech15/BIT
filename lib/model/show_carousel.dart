class ShowCarousel {
  List<String>? data;
  String? path;
  String? result;
  String? apiStatus;

  ShowCarousel({this.data, this.path, this.result, this.apiStatus});

  ShowCarousel.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
    path = json['path'];
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['path'] = path;
    data['result'] = result;
    data['api_status'] = apiStatus;
    return data;
  }
}
