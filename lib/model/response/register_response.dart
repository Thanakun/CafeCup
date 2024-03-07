class RegisterResponse {
  int? iId;
  String? username;
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

  RegisterResponse(
      {this.iId,
      this.username,
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

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    username = json['username'];
    name = json['name'];
    description = json['description'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['menus'] != null) {
      menus = <Menus>[];
      json['menus'].forEach((v) {
        menus!.add(new Menus.fromJson(v));
      });
    }
    coverImage = json['coverImage'];
    if (json['shopImages'] != null) {
      shopImages = <String>[];
      json['shopImages'].forEach((v) {
        shopImages!.add(v);
      });
    }
    menuImages = json['menuImages'].cast<String>();
    foodImages = json['foodImages'].cast<String>();
    otherImages = json['otherImages'].cast<String>();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['username'] = this.username;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.menus != null) {
      data['menus'] = this.menus!.map((v) => v.toJson()).toList();
    }
    data['coverImage'] = this.coverImage;
    if (this.shopImages != null) {
      data['shopImages'] = this.shopImages;
    }
    data['menuImages'] = this.menuImages;
    data['foodImages'] = this.foodImages;
    data['otherImages'] = this.otherImages;
    data['daysOpen'] = this.daysOpen;
    data['timeOpen'] = this.timeOpen;
    data['timeClose'] = this.timeClose;
    data['singleSeat'] = this.singleSeat;
    data['doubleSeat'] = this.doubleSeat;
    data['largeSeat'] = this.largeSeat;
    data['wifi'] = this.wifi;
    data['powerPlugs'] = this.powerPlugs;
    data['conferenceRoom'] = this.conferenceRoom;
    data['toilet'] = this.toilet;
    data['smokingZone'] = this.smokingZone;
    data['photoSpots'] = this.photoSpots;
    data['noice'] = this.noice;
    data['customerGroup'] = this.customerGroup;
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['province'] = this.province;
    data['district'] = this.district;
    data['subDistrict'] = this.subDistrict;
    data['road'] = this.road;
    data['postelCode'] = this.postelCode;
    data['addressText'] = this.addressText;
    data['_id'] = this.sId;
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
    data['name'] = this.name;
    data['category'] = this.category;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['_id'] = this.sId;
    return data;
  }
}
