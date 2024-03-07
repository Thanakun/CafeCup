class CustomerRecommendation {
  int? iShopID;
  double? score;

  CustomerRecommendation({this.iShopID, this.score});

  CustomerRecommendation.fromJson(Map<String, dynamic> json) {
    iShopID = json['_shopID'];
    score = json['score']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_shopID'] = iShopID;
    data['score'] = score;
    return data;
  }
}
