class CustomerReviewRequestBody {
  int? iCustomerId;
  int? iShopId;
  String? menuName;
  int? flavour;
  int? place;
  int? service;
  int? parking;
  int? worthiness;
  String? comment;

  CustomerReviewRequestBody(
      {this.iCustomerId,
      this.iShopId,
      this.menuName,
      this.flavour,
      this.place,
      this.service,
      this.parking,
      this.worthiness,
      this.comment});

  CustomerReviewRequestBody.fromJson(Map<String, dynamic> json) {
    iCustomerId = json['_customerId'];
    iShopId = json['_shopId'];
    menuName = json['menuName'];
    flavour = json['flavour'];
    place = json['place'];
    service = json['service'];
    parking = json['parking'];
    worthiness = json['worthiness'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_customerId'] = iCustomerId;
    data['_shopId'] = iShopId;
    data['menuName'] = menuName;
    data['flavour'] = flavour;
    data['place'] = place;
    data['service'] = service;
    data['parking'] = parking;
    data['worthiness'] = worthiness;
    data['comment'] = comment;
    return data;
  }
}
