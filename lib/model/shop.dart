// import 'dart:ffi';
// import 'package:intl';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shop {
  int shopId; // auto increment
  String shopName;
  String shopImagePath;
  String shopLocationText;
  String shopLocationCoordination;
  String shopDescription;
  // String shopAvailibleTime;
  String shopFoodCategory;
  double shopScore;
  int shopMissionId;
  bool shopStatusMembership;
  List shopPromotionId;
  DateTime shopOpenTime;
  DateTime shopCloseTime;

  Shop({
    required this.shopId,
    required this.shopName,
    required this.shopImagePath,
    required this.shopLocationText,
    required this.shopLocationCoordination,
    required this.shopDescription,
    // required this.shopAvailibleTime,
    required this.shopFoodCategory,
    required this.shopScore,
    required this.shopMissionId,
    required this.shopStatusMembership,
    required this.shopOpenTime,
    required this.shopCloseTime,
    required this.shopPromotionId,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String,
      shopImagePath: json['shop_image'] as String,
      shopLocationText: json['shop_location_text'] as String,
      shopLocationCoordination: json['shop_loc_coordinates'] as String,
      shopDescription: json['shop_description'] as String,
      // shopAvailibleTime: json['shop_availible_time'] as String,
      shopFoodCategory: json['shop_food_category'] as String,
      shopScore: json['shop_score'] as double,
      shopMissionId: json['shop_mission_id'] as int,
      shopStatusMembership: json['shop_status_membership'] as bool,
      shopOpenTime: DateTime.parse(json['shop_open_time'] as String),
      shopCloseTime: DateTime.parse(json['shop_close_time'] as String),
      shopPromotionId: (json['pmt_id'] as List<dynamic>).toList(),
    );
  }
}
