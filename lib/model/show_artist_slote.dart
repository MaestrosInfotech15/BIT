class ShowartistSlote {
  List<ShowartistSloteData>? data;
  String? result;
  String? apiStatus;

  ShowartistSlote({this.data, this.result, this.apiStatus});

  ShowartistSlote.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowartistSloteData>[];
      json['data'].forEach((v) {
        data!.add(new ShowartistSloteData.fromJson(v));
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

class ShowartistSloteData {
  String? id;
  String? artistId;
  String? date;

  ShowartistSloteData({this.id, this.artistId, this.date});

  ShowartistSloteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artistId = json['artist_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['artist_id'] = this.artistId;
    data['date'] = this.date;
    return data;
  }
}
