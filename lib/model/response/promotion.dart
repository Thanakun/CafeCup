class Promotion {
  int? iId;
  int? iShopId;
  String? codeString;
  String? dateCreate;
  String? dateExpired;
  String? codeDetail;
  String? status;
  int? iCustomerId;
  String? name;

  Promotion(
      {this.iId,
      this.iShopId,
      this.codeString,
      this.dateCreate,
      this.dateExpired,
      this.codeDetail,
      this.status,
      this.iCustomerId,
      this.name});

  Promotion.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    iShopId = json['_shopId'];
    codeString = json['codeString'];
    dateCreate = json['dateCreate'];
    dateExpired = json['dateExpired'];
    codeDetail = json['codeDetail'];
    status = json['status'];
    iCustomerId = json['_customerId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = iId;
    data['_shopId'] = iShopId;
    data['codeString'] = codeString;
    data['dateCreate'] = dateCreate;
    data['dateExpired'] = dateExpired;
    data['codeDetail'] = codeDetail;
    data['status'] = status;
    data['_customerId'] = iCustomerId;
    data['name'] = name;
    return data;
  }
}
