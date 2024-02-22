// import 'dart:ffi';
// import 'package:intl';
// import 'package:flutter/foundation.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Shop {
//   int shopId; // auto increment
//   String shopName;
//   String shopImagePath;
//   String shopLocationText;
//   String shopLocationCoordination;
//   String shopDescription;
//   // String shopAvailibleTime;
//   String shopFoodCategory;
//   double shopAverageAllScore;
//   double shopAverageScorePoint;
//   double shopAverageScorePlace;
//   double shopAverageScoreService;
//   int shopMissionId;
//   bool shopStatusMembership;
//   List shopPromotionId;
//   DateTime shopOpenTime;
//   DateTime shopCloseTime;

//   Shop({
//     required this.shopId,
//     required this.shopName,
//     required this.shopImagePath,
//     required this.shopLocationText,
//     required this.shopLocationCoordination,
//     required this.shopDescription,
//     // required this.shopAvailibleTime,
//     required this.shopFoodCategory,
//     required this.shopAverageAllScore,
//     required this.shopAverageScorePoint,
//     required this.shopAverageScorePlace,
//     required this.shopAverageScoreService,
//     required this.shopMissionId,
//     required this.shopStatusMembership,
//     required this.shopOpenTime,
//     required this.shopCloseTime,
//     required this.shopPromotionId,
//   });

//   factory Shop.fromJson(Map<String, dynamic> json) {
//     return Shop(
//       shopId: json['shop_id'] as int,
//       shopName: json['shop_name'] as String,
//       shopImagePath: json['shop_image'] as String,
//       shopLocationText: json['shop_location_text'] as String,
//       shopLocationCoordination: json['shop_loc_coordinates'] as String,
//       shopDescription: json['shop_description'] as String,
//       // shopAvailibleTime: json['shop_availible_time'] as String,
//       shopFoodCategory: json['shop_food_category'] as String,
//       shopMissionId: json['shop_mission_id'] as int,
//       shopStatusMembership: json['shop_status_membership'] as bool,
//       shopOpenTime: DateTime.parse(json['shop_open_time'] as String),
//       shopCloseTime: DateTime.parse(json['shop_close_time'] as String),
//       shopPromotionId: (json['pmt_id'] as List<dynamic>).toList(),
//       shopAverageAllScore: json['shop_score'] as double,
//       shopAverageScorePlace: json['shop_place'] as double,
//       shopAverageScoreService: json['shop_service'] as double,
//       shopAverageScorePoint: json['shop_point'] as double,
//     );
//   }

//   void updateAverageScoreById(int shopId, double newScorePoint,
//       double newScorePlace, double newScoreService) {
//     if (this.shopId == shopId) {
//       // Update the average scores based on the new values
//       shopAverageScorePoint = newScorePoint;
//       shopAverageScorePlace = newScorePlace;
//       shopAverageScoreService = newScoreService;

//       // Recalculate the overall average score
//       shopAverageAllScore = (shopAverageScorePoint +
//               shopAverageScorePlace +
//               shopAverageScoreService) /
//           3.0;
//     }
//   }

// String getShopNameById(int shopId){
//   try {
//     if(this.shopId == shopId){
//       return shopName;
//     }
//     return;
//   } catch (e) {

//   }

// }
// }
import 'dart:io';

class ShopModel {
  int? iId;
  String? username;
  String? password;
  String? name;
  Address? address;
  List<Menus>? menus;
  List<File>? shopImages;
  List<File>? menuImages;
  List<File>? foodImages;
  List<File>? otherImages;
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
  String? noice;

  ShopModel(
      {this.iId,
      this.username,
      this.password,
      this.name,
      this.address,
      this.menus,
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
      this.noice});

  ShopModel.defaultWithIdNegativeOne()
      : iId = -1,
        username = null,
        password = null,
        name = null,
        address = null,
        menus = null,
        shopImages = null,
        menuImages = null,
        foodImages = null,
        otherImages = null,
        daysOpen = null,
        timeOpen = null,
        timeClose = null,
        singleSeat = null,
        doubleSeat = null,
        largeSeat = null,
        wifi = null,
        powerPlugs = null,
        conferenceRoom = null,
        toilet = null,
        smokingZone = null,
        noice = null;

  ShopModel.fromJson(Map<String, dynamic> json) {
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
      shopImages = <File>[];
      json['shopImages'].forEach((v) {
        shopImages!.add(File(v.toString()));
      });
    }
    if (json['menuImages'] != null) {
      menuImages = <File>[];
      json['menuImages'].forEach((v) {
        menuImages!.add(File(v.toString()));
      });
    }
    if (json['foodImages'] != null) {
      foodImages = <File>[];
      json['foodImages'].forEach((v) {
        foodImages!.add(File(v.toString()));
      });
    }
    if (json['otherImages'] != null) {
      otherImages = <File>[];
      json['otherImages'].forEach((v) {
        otherImages!.add(File(v.toString()));
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = iId;
    data['username'] = username;
    data['password'] = password;
    data['name'] = name;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    if (shopImages != null) {
      data['shopImages'] = shopImages!.map((v) => v.path).toList();
    }
    if (menuImages != null) {
      data['menuImages'] = menuImages!.map((v) => v.path).toList();
    }
    if (foodImages != null) {
      data['foodImages'] = foodImages!.map((v) => v.path).toList();
    }
    if (otherImages != null) {
      data['otherImages'] = otherImages!.map((v) => v.path).toList();
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
    data['noice'] = noice;
    return data;
  }
}

class Address {
  String? subDistrict;
  String? sId;

  Address({this.subDistrict, this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    subDistrict = json['subDistrict'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subDistrict'] = subDistrict;
    data['_id'] = sId;
    return data;
  }
}

class Menus {
  int? price;
  String? sId;

  Menus({this.price, this.sId});

  Menus.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['_id'] = sId;
    return data;
  }
}
