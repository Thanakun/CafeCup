import 'dart:math';

import 'package:flutter_application_1/model/shop.dart';
import 'package:flutter_application_1/service/search_service/search_shop_interface.dart';

class SearchShopMockService implements SearchShopServiceInterface {
  Random random = Random();
  final List<String> types = [
    'เมนูเส้น',
    'เมนูตามสั่ง',
    'เมนูของทอด',
    'เมนูของหวาน'
  ];

  String _getRandomType() {
    return types[random.nextInt(types.length)];
  }

  @override
  Future<List<Shop>> fetchItemByKeyword() async {
    int count = 10;
    List<Shop> items = [];
    DateTime currentDate = DateTime.now();
    int currentMonth = currentDate.month;
    int currentYear = currentDate.year;
    for (int index = 0; index < count; index++) {
      int month = (currentMonth - index) % 12;
      int yearOffset = ((currentMonth - index) / 12).floor();
      int year = currentYear - yearOffset;
      DateTime monthStartDate = DateTime(year, month);
      items.add(
        Shop(
          shopId: index+1,
          shopLocation: "Mock Shop Location",
          shopMenuId: "Mock Shop Menu ID",
          shopName: "Product $index",
          shopImage: "Mock Shop Image URL",
          shopDescription: "Mock Shop Description",
          shopFoodType: _getRandomType(),
          shopScore: 4.5,
          shopPromotionId: ["Mock Promotion ID 1", "Mock Promotion ID 2"],
          shopMissionId: ["Mock Mission ID 1", "Mock Mission ID 2"],
          shopStatusMembership: true));
    }
    // items.sort((a, b) => b['unitSale'].compareTo(a['unitSale']));
    return items;
  }
}
