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

class Shop {
  int shopID;
  String? username;
  String? password;
  String? name;
  String description;
  Address address;
  List<Menu> menus;
  String coverImage;
  List<String> shopImages;
  List<String> menuImages;
  List<String> foodImages;
  List<String> otherImages;
  List<int> daysOpen;
  DateTime timeOpen;
  DateTime timeClose;
  int singleSeat;
  int doubleSeat;
  int largeSeat;
  bool wifi;
  bool powerPlugs;
  bool conferenceRoom;
  String photoSpots;
  String noise;
  bool toilet;
  bool smokingZone;
  String consumerGroup;

  Shop({
    required this.shopID,
    required this.username,
    required this.password,
    required this.name,
    required this.description,
    required this.address,
    required this.menus,
    required this.coverImage,
    required this.shopImages,
    required this.menuImages,
    required this.foodImages,
    required this.otherImages,
    required this.daysOpen,
    required this.timeOpen,
    required this.timeClose,
    required this.singleSeat,
    required this.doubleSeat,
    required this.largeSeat,
    required this.wifi,
    required this.powerPlugs,
    required this.conferenceRoom,
    required this.photoSpots,
    required this.noise,
    required this.toilet,
    required this.smokingZone,
    required this.consumerGroup,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopID: json['shopID'],
      username: json['username'],
      password: json['password'],
      name: json['name'],
      description: json['description'],
      address: Address.fromJson(json['address']),
      menus: List<Menu>.from(json['menus'].map((menu) => Menu.fromJson(menu))),
      coverImage: json['coverImage'],
      shopImages: List<String>.from(json['shopImages']),
      menuImages: List<String>.from(json['menuImages']),
      foodImages: List<String>.from(json['foodImages']),
      otherImages: List<String>.from(json['otherImages']),
      daysOpen: List<int>.from(json['daysOpen']),
      timeOpen: DateTime.parse(json['timeOpen']),
      timeClose: DateTime.parse(json['timeClose']),
      singleSeat: json['singleSeat'],
      doubleSeat: json['doubleSeat'],
      largeSeat: json['largeSeat'],
      wifi: json['wifi'],
      powerPlugs: json['powerPlugs'],
      conferenceRoom: json['conferenceRoom'],
      photoSpots: json['photoSpots'],
      noise: json['noise'],
      toilet: json['toilet'],
      smokingZone: json['smokingZone'],
      consumerGroup: json['consumerGroup'],
    );
  }
}

class Address {
  String country;
  String province;
  String district;
  String subDistrict;
  String road;
  String postalCode;
  String addressText;

  Address({
    required this.country,
    required this.province,
    required this.district,
    required this.subDistrict,
    required this.road,
    required this.postalCode,
    required this.addressText,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'],
      province: json['province'],
      district: json['district'],
      subDistrict: json['subDistrict'],
      road: json['road'],
      postalCode: json['postalCode'],
      addressText: json['addressText'],
    );
  }
}

class Menu {
  int menuID;
  String name;
  String category;
  String description;
  int price;
  String image;

  Menu({
    required this.menuID,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuID: json['menuID'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}
