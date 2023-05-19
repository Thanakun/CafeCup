import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shop {
  int shopId; // auto increment
  String shopLocation;
  String shopMenuId;
  String shopName;
  String shopImage;
  String shopDescription;
  String shopFoodType;
  double shopScore;
  List shopPromotionId;
  List shopMissionId;
  bool shopStatusMembership;

  Shop(
      {
      required this.shopId,
      required this.shopLocation,
      required this.shopMenuId,
      required this.shopName,
      required this.shopImage,
      required this.shopDescription,
      required this.shopFoodType,
      required this.shopScore,
      required this.shopPromotionId,
      required this.shopMissionId,
      required this.shopStatusMembership,
      });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'] as int,
      shopLocation: json['shopLocation'] as String,
      shopName: json['shopName'] as String,
      shopImage: json['shopImage'] as String,
      shopDescription: json['shopDescription'] as String,
      shopFoodType: json['shopFoodType'] as String,
      shopPromotionId: json['shopPromotionId'] as List,
      shopMissionId: json['shopMissionId'] as List,
      shopStatusMembership: json['shopStatusMembership'] as bool,
      shopMenuId: json['shopMenuId'] as String,
      shopScore: json['shopScore'] as double,
    );
  }
}
