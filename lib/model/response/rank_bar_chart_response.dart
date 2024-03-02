class ReviewRankBarChartResponse {
  int? status;
  Data? data;
  int? thisShopReviewCount;
  int? allShopreviewCount;

  ReviewRankBarChartResponse(
      {this.status,
      this.data,
      this.thisShopReviewCount,
      this.allShopreviewCount});

  ReviewRankBarChartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    thisShopReviewCount = json['thisShopReviewCount'];
    allShopreviewCount = json['allShopreviewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['thisShopReviewCount'] = thisShopReviewCount;
    data['allShopreviewCount'] = allShopreviewCount;
    return data;
  }
}

class Data {
  Score? flavour;
  Score? place;
  Score? service;
  Score? parking;
  Score? worthiness;
  Score? totalScore;

  Data(
      {this.flavour,
      this.place,
      this.service,
      this.parking,
      this.worthiness,
      this.totalScore});

  Data.fromJson(Map<String, dynamic> json) {
    flavour = json['flavour'] != null ? Score.fromJson(json['flavour']) : null;
    place = json['place'] != null ? Score.fromJson(json['place']) : null;
    service = json['service'] != null ? Score.fromJson(json['service']) : null;
    parking = json['parking'] != null ? Score.fromJson(json['parking']) : null;
    worthiness =
        json['worthiness'] != null ? Score.fromJson(json['worthiness']) : null;
    totalScore =
        json['totalScore'] != null ? Score.fromJson(json['totalScore']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (flavour != null) {
      data['flavour'] = flavour!.toJson();
    }
    if (place != null) {
      data['place'] = place!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (parking != null) {
      data['parking'] = parking!.toJson();
    }
    if (worthiness != null) {
      data['worthiness'] = worthiness!.toJson();
    }
    if (totalScore != null) {
      data['totalScore'] = totalScore!.toJson();
    }
    return data;
  }
}

class Score {
  double? avg;
  double? min;
  double? max;
  double? shopAvg;

  Score({this.avg, this.min, this.max, this.shopAvg});

  Score.fromJson(Map<String, dynamic> json) {
    avg = json['avg']?.toDouble();
    min = json['min']?.toDouble();
    max = json['max']?.toDouble();
    shopAvg = json['shopAvg']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Check for null values and convert to double before adding to the map
    if (avg != null) data['avg'] = avg;
    if (min != null) data['min'] = min;
    if (max != null) data['max'] = max;
    if (shopAvg != null) data['shopAvg'] = shopAvg;

    return data;
  }
}
