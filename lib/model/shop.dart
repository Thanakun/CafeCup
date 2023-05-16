import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shop {
  int shopId; // auto increment
  String shopLocation;
  String shopMenuId;
  String shopName;
  String shopImage;
  double shopScore;
  String shopDescription;
  String shopFoodType;
  String shopPromotionId;
  int shopMissionId;
  bool shopStatusMembership;

  Shop(
      {required this.shopId,
      required this.shopLocation,
      required this.shopName,
      required this.shopImage,
      required this.shopDescription,
      required this.shopFoodType,
      required this.shopPromotionId,
      required this.shopMissionId,
      required this.shopStatusMembership,
      required this.shopMenuId,
      required this.shopScore});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'] as int,
      shopLocation: json['shopLocation'] as String,
      shopName: json['shopName'] as String,
      shopImage: json['shopImage'] as String,
      shopDescription: json['shopDescription'] as String,
      shopFoodType: json['shopFoodType'] as String,
      shopPromotionId: json['shopPromotionId'] as String,
      shopMissionId: json['shopMissionId'] as int,
      shopStatusMembership: json['shopStatusMembership'] as bool,
      shopMenuId: json['shopMenuId'] as String,
      shopScore: json['shopScore'] as double,
    );
  }
}
