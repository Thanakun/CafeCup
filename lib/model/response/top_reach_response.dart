class ShopTopReachModelResponse {
  int? status;
  List<ShopReachModel>? data;

  ShopTopReachModelResponse({this.status, this.data});

  ShopTopReachModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ShopReachModel>[];
      json['data'].forEach((v) {
        data!.add(ShopReachModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopReachModel {
  int? iId;
  int? count;
  String? username;
  String? password;
  String? name;
  String? description;
  Address? address;
  List<Menus>? menus;
  String? coverImage;
  List<String>? shopImages;
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

  ShopReachModel(
      {this.iId,
      this.count,
      this.username,
      this.password,
      this.name,
      this.description,
      this.address,
      this.menus,
      this.coverImage,
      this.shopImages,
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
      this.customerGroup});

  ShopReachModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['menus'] != null) {
      menus = <Menus>[];
      json['menus'].forEach((v) {
        menus!.add(Menus.fromJson(v));
      });
    }
    if (json['shopImages'] != null) {
      shopImages = <String>[];
      json['shopImages'].forEach((v) {
        shopImages!.add(v);
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
    name = json['name'];
    description = json['description'];
    coverImage = json['coverImage'];
    daysOpen = json['daysOpen'] == null ? [] : json['daysOpen'].cast<int>();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = iId;
    data['count'] = count;
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
    data['shopImages'] = shopImages;
    if (menuImages != null) {
      data['menuImages'] = menuImages!.map((v) => v).toList();
    }
    data['foodImages'] = foodImages;
    if (otherImages != null) {
      data['otherImages'] = otherImages!.map((v) => v).toList();
    }
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
}

class Address {
  String? country;
  String? province;
  String? district;
  String? subDistrict;
  String? road;
  int? postelCode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['_id'] = sId;
    return data;
  }
}
