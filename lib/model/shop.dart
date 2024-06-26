class ShopModelResponse {
  int? status;
  Metadata? metadata;
  List<ShopModel>? data;

  ShopModelResponse({this.status, this.metadata, this.data});

  ShopModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = <ShopModel>[];
      json['data'].forEach((v) {
        data!.add(ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  int? totalCount;
  int? page;
  int? pageSize;

  Metadata({this.totalCount, this.page, this.pageSize});

  Metadata.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    page = json['page'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['totalCount'] = totalCount;
    data['page'] = page;
    data['pageSize'] = pageSize;
    return data;
  }
}

class ShopModel {
  int? iId;
  String? username;
  String? password;
  String? name;
  String? description;
  Address? address;
  List<Menus>? menus;
  String? coverImage;
  List<String>? shopImage;
  List<String>? menuImages;
  List<String>? foodImages;
  List<String>? otherImages;
  List<int>? daysOpen;
  String? timeOpen;
  String? timeClose;
  int? singleSeat;
  int? doubleSeat;
  int? largeSeat;
  bool? wifi;
  bool? powerPlugs;
  bool? conferenceRoom;
  bool? toilet;
  bool? smokingZone;
  String? photoSpots;
  String? noice;
  String? customerGroup;
  int? minuteOpen;
  int? minuteClose;
  int? reviewNum;
  double? reviewScoreMean;

  ShopModel(
      {this.iId,
      this.username,
      this.password,
      this.name,
      this.description,
      this.address,
      this.menus,
      this.coverImage,
      this.shopImage,
      this.menuImages,
      this.foodImages,
      this.otherImages,
      this.daysOpen,
      this.timeOpen,
      this.timeClose,
      this.singleSeat,
      this.doubleSeat,
      this.largeSeat,
      this.wifi,
      this.powerPlugs,
      this.conferenceRoom,
      this.toilet,
      this.smokingZone,
      this.photoSpots,
      this.noice,
      this.customerGroup,
      this.minuteOpen,
      this.minuteClose,
      this.reviewNum,
      this.reviewScoreMean});

  ShopModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    description = json['description'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['menus'] != null) {
      menus = <Menus>[];
      json['menus'].forEach((v) {
        menus!.add(Menus.fromJson(v));
      });
    }
    if (json['shopImages'] != null) {
      shopImage = <String>[];
      json['shopImages'].forEach((v) {
        shopImage!.add(v);
      });
    }
    if (json['menuImages'] != null) {
      menuImages = <String>[];
      json['menuImages'].forEach((v) {
        menuImages!.add(v);
      });
    }
    if (json['foodImages'] != null) {
      foodImages = <String>[];
      json['foodImages'].forEach((v) {
        foodImages!.add(v);
      });
    }
    if (json['otherImages'] != null) {
      otherImages = <String>[];
      json['otherImages'].forEach((v) {
        otherImages!.add(v);
      });
    }
    coverImage = json['coverImage'];
    daysOpen = json['daysOpen'].cast<int>();
    timeOpen = json['timeOpen'];
    timeClose = json['timeClose'];
    singleSeat = json['singleSeat'];
    doubleSeat = json['doubleSeat'];
    largeSeat = json['largeSeat'];
    wifi = json['wifi'];
    powerPlugs = json['powerPlugs'];
    conferenceRoom = json['conferenceRoom'];
    toilet = json['toilet'];
    smokingZone = json['smokingZone'];
    photoSpots = json['photoSpots'];
    noice = json['noice'];
    customerGroup = json['customerGroup'];
    minuteOpen = json['minuteOpen'];
    minuteClose = json['minuteClose'];
    reviewNum = (json['reviewNum'] as num?)?.toInt() ?? 0;
    reviewScoreMean = (json['reviewScoreMean'] as num?)?.toDouble() ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = iId;
    data['username'] = username;
    data['password'] = password;
    data['name'] = name;
    data['description'] = description;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    data['coverImage'] = coverImage;
    data['shopImage'] = shopImage;
    data['menuImages'] = menuImages;
    data['foodImages'] = foodImages;
    data['otherImages'] = otherImages;
    data['daysOpen'] = daysOpen;
    data['timeOpen'] = timeOpen;
    data['timeClose'] = timeClose;
    data['singleSeat'] = singleSeat;
    data['doubleSeat'] = doubleSeat;
    data['largeSeat'] = largeSeat;
    data['wifi'] = wifi;
    data['powerPlugs'] = powerPlugs;
    data['conferenceRoom'] = conferenceRoom;
    data['toilet'] = toilet;
    data['smokingZone'] = smokingZone;
    data['photoSpots'] = photoSpots;
    data['noice'] = noice;
    data['customerGroup'] = customerGroup;
    data['minuteOpen'] = minuteOpen;
    data['minuteClose'] = minuteClose;
    data['reviewNum'] = reviewNum;
    data['reviewScoreMean'] = reviewScoreMean;
    return data;
  }

  static ShopModel defaultWithIdNegativeOne() {
    return ShopModel(iId: -1);
  }
}

class Address {
  String? country;
  String? province;
  String? district;
  String? subDistrict;
  String? road;
  String? postelCode;
  String? addressText;
  String? sId;

  Address(
      {this.country,
      this.province,
      this.district,
      this.subDistrict,
      this.road,
      this.postelCode,
      this.addressText,
      this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    province = json['province'];
    district = json['district'];
    subDistrict = json['subDistrict'];
    road = json['road'];
    postelCode = json['postelCode'];
    addressText = json['addressText'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = country;
    data['province'] = province;
    data['district'] = district;
    data['subDistrict'] = subDistrict;
    data['road'] = road;
    data['postelCode'] = postelCode;
    data['addressText'] = addressText;
    data['_id'] = sId;
    return data;
  }
}

class Menus {
  String? name;
  String? category;
  String? description;
  int? price;
  String? image;
  String? sId;

  Menus(
      {this.name,
      this.category,
      this.description,
      this.price,
      this.image,
      this.sId});

  Menus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['_id'] = sId;
    return data;
  }
}
