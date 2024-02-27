class ReviewModel {
  int? iId;
  int? iCustomerId;
  int? iShopId;
  int? iMenuId;
  int? flavour;
  int? place;
  int? service;
  int? parking;
  int? worthiness;
  String? comment;
  String? timestamp;

  ReviewModel(
      {this.iId,
      this.iCustomerId,
      this.iShopId,
      this.iMenuId,
      this.flavour,
      this.place,
      this.service,
      this.parking,
      this.worthiness,
      this.comment,
      this.timestamp});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    iCustomerId = json['_customerId'];
    iShopId = json['_shopId'];
    iMenuId = json['_menuId'];
    flavour = json['flavour'];
    place = json['place'];
    service = json['service'];
    parking = json['parking'];
    worthiness = json['worthiness'];
    comment = json['comment'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['_customerId'] = this.iCustomerId;
    data['_shopId'] = this.iShopId;
    data['_menuId'] = this.iMenuId;
    data['flavour'] = this.flavour;
    data['place'] = this.place;
    data['service'] = this.service;
    data['parking'] = this.parking;
    data['worthiness'] = this.worthiness;
    data['comment'] = this.comment;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
