class SpiderChartResponseModel {
  int? status;
  List<Data>? data;

  SpiderChartResponseModel({this.status, this.data});

  SpiderChartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Null? nId;
  double? totalFlavour;
  double? totalPlace;
  double? totalService;
  double? totalparking;
  double? totalWorthiness;
  int? totalCount;

  Data(
      {this.nId,
      this.totalFlavour,
      this.totalPlace,
      this.totalService,
      this.totalparking,
      this.totalWorthiness,
      this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    totalFlavour = json['totalFlavour']?.toDouble();
    totalPlace = json['totalPlace']?.toDouble();
    totalService = json['totalService']?.toDouble();
    totalparking = json['totalparking']?.toDouble();
    totalWorthiness = json['totalWorthiness']?.toDouble();

    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = nId;
    data['totalFlavour'] = totalFlavour;
    data['totalPlace'] = totalPlace;
    data['totalService'] = totalService;
    data['totalparking'] = totalparking;
    data['totalWorthiness'] = totalWorthiness;
    data['totalCount'] = totalCount;
    return data;
  }
}
