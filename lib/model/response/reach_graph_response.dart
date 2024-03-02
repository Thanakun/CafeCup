class ReachGraphResponse {
  int? status;
  List<Reach>? data;
  int? totalCount;

  ReachGraphResponse({this.status, this.data, this.totalCount});

  ReachGraphResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Reach>[];
      json['data'].forEach((v) {
        data!.add(Reach.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }
}

class Reach {
  int? iId;
  int? count;

  Reach({this.iId, this.count});

  Reach.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = iId;
    data['count'] = count;
    return data;
  }
}
