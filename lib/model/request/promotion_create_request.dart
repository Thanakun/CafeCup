class PromotionCreateRequestBody {
  int? iShopId;
  String? codeDetail;
  int? expiredLength;
  int? amount;

  PromotionCreateRequestBody(
      {this.iShopId, this.codeDetail, this.expiredLength, this.amount});

  PromotionCreateRequestBody.fromJson(Map<String, dynamic> json) {
    iShopId = json['_shopId'];
    codeDetail = json['codeDetail'];
    expiredLength = json['expiredLength'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_shopId'] = iShopId;
    data['codeDetail'] = codeDetail;
    data['expiredLength'] = expiredLength;
    data['amount'] = amount;
    return data;
  }
}
