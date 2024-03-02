class PromotionShop {
  List<Available>? available;
  List<Activated>? activated;

  PromotionShop({this.available, this.activated});

  PromotionShop.fromJson(Map<String, dynamic> json) {
    if (json['available'] != null) {
      available = <Available>[];
      json['available'].forEach((v) {
        available!.add(Available.fromJson(v));
      });
    }
    if (json['activated'] != null) {
      activated = <Activated>[];
      json['activated'].forEach((v) {
        activated!.add(Activated.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (available != null) {
      data['available'] = available!.map((v) => v.toJson()).toList();
    }
    if (activated != null) {
      data['activated'] = activated!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Available {
  int? iId;
  int? iShopId;
  String? codeString;
  String? dateCreate;
  String? dateExpired;
  String? codeDetail;
  String? status;

  Available(
      {this.iId,
      this.iShopId,
      this.codeString,
      this.dateCreate,
      this.dateExpired,
      this.codeDetail,
      this.status});

  Available.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    iShopId = json['_shopId'];
    codeString = json['codeString'];
    dateCreate = json['dateCreate'];
    dateExpired = json['dateExpired'];
    codeDetail = json['codeDetail'];
    status = json['status'];
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
    return data;
  }
}

class Activated {
  int? iId;
  int? iShopId;
  String? codeString;
  String? dateCreate;
  String? dateExpired;
  String? codeDetail;
  String? status;
  int? iCustomerId;
  String? usedTimestamp;

  Activated(
      {this.iId,
      this.iShopId,
      this.codeString,
      this.dateCreate,
      this.dateExpired,
      this.codeDetail,
      this.status,
      this.iCustomerId,
      this.usedTimestamp});

  Activated.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    iShopId = json['_shopId'];
    codeString = json['codeString'];
    dateCreate = json['dateCreate'];
    dateExpired = json['dateExpired'];
    codeDetail = json['codeDetail'];
    status = json['status'];
    iCustomerId = json['_customerId'];
    usedTimestamp = json['usedTimestamp'];
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
    data['usedTimestamp'] = usedTimestamp;
    return data;
  }
}
