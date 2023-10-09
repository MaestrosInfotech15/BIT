class UploadCarousel {
  String? path;
  String? image;
  String? apiStatus;

  UploadCarousel({this.path, this.image, this.apiStatus});

  UploadCarousel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    image = json['image'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['image'] = image;
    data['api_status'] = apiStatus;
    return data;
  }
}
