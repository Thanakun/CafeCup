class ShopModelResponse {
  int? status;
  Metadata? metadata;
  List<ShopModel>? data;

  ShopModelResponse({this.status, this.metadata, this.data});

  ShopModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = <ShopModel>[];
      json['data'].forEach((v) {
        data!.add(new ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
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
      this.minuteClose});

  ShopModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['menus'] != null) {
      menus = <Menus>[];
      json['menus'].forEach((v) {
        menus!.add(new Menus.fromJson(v));
      });
    }
    if (json['shopImages'] != null) {
      shopImage = <String>[];
      json['shopImages'].forEach((v) {
        shopImage!.add(v.fromJson(v));
      });
    }
    if (json['menuImages'] != null) {
      menuImages = <String>[];
      json['menuImages'].forEach((v) {
        menuImages!.add(v.fromJson(v));
      });
    }
    if (json['foodImages'] != null) {
      foodImages = <String>[];
      json['foodImages'].forEach((v) {
        foodImages!.add(v.fromJson(v));
      });
    }
    if (json['otherImages'] != null) {
      otherImages = <String>[];
      json['otherImages'].forEach((v) {
        otherImages!.add(v.fromJson(v));
      });
    }
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
    noice = json['noice'];
    minuteOpen = json['minuteOpen'];
    minuteClose = json['minuteClose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

  Address(
      {this.country,
      this.province,
      this.district,
      this.subDistrict,
      this.road,
      this.postelCode,
      this.addressText});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    province = json['province'];
    district = json['district'];
    subDistrict = json['subDistrict'];
    road = json['road'];
    postelCode = json['postelCode'];
    addressText = json['addressText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['province'] = province;
    data['district'] = district;
    data['subDistrict'] = subDistrict;
    data['road'] = road;
    data['postelCode'] = postelCode;
    data['addressText'] = addressText;
    return data;
  }
}

class Menus {
  String? name;
  String? category;
  int? price;
  String? description;
  String? image;

  Menus({this.name, this.category, this.price, this.description, this.image});

  Menus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['price'] = price;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
