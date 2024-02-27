class PromotionClaimResponse {
  ClaimedCode? claimedCode;

  PromotionClaimResponse({this.claimedCode});

  PromotionClaimResponse.fromJson(Map<String, dynamic> json) {
    claimedCode = json['claimedCode'] != null
        ? ClaimedCode.fromJson(json['claimedCode'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (claimedCode != null) {
      data['claimedCode'] = claimedCode!.toJson();
    }
    return data;
  }
}

class ClaimedCode {
  int? iId;
  int? iShopId;
  String? codeString;
  String? dateCreate;
  String? dateExpired;
  String? codeDetail;
  String? status;
  int? iCustomerId;

  ClaimedCode(
      {this.iId,
      this.iShopId,
      this.codeString,
      this.dateCreate,
      this.dateExpired,
      this.codeDetail,
      this.status,
      this.iCustomerId});

  ClaimedCode.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    iShopId = json['_shopId'];
    codeString = json['codeString'];
    dateCreate = json['dateCreate'];
    dateExpired = json['dateExpired'];
    codeDetail = json['codeDetail'];
    status = json['status'];
    iCustomerId = json['_customerId'];
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
    return data;
  }
}
