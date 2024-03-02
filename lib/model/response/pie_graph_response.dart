class PieChartGraphResponse {
  int? status;
  List<Data>? data;
  int? totalCount;

  PieChartGraphResponse({this.status, this.data, this.totalCount});

  PieChartGraphResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Data {
  String? sId;
  int? count;

  Data({this.sId, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['count'] = this.count;
    return data;
  }
}
