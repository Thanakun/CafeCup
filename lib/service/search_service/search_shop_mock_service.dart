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

  DateTime _getRandomOpenTime() {
    int hour = random.nextInt(2) + 8; // Random hour between 8 and 9
    int minute = random.nextInt(60); // Random minute
    return DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);
  }

  DateTime _getRandomCloseTime(DateTime openTime) {
    int hour = random.nextInt(2) + 18; // Random hour between 18 and 19
    int minute = random.nextInt(60); // Random minute
    return DateTime(openTime.year, openTime.month, openTime.day, hour, minute);
  }

  String _getRandomType() {
    return types[random.nextInt(types.length)];
  }

  // String formatTime(DateTime dateTime) {
  //   return DateFormat('HH:mm a').format(dateTime);
  // }

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
      DateTime openTime = _getRandomOpenTime();
      DateTime closeTime = _getRandomCloseTime(openTime);
      items.add(Shop(
        shopId: index + 1,
        shopName: "Product $index ",
        shopDescription: "Mock Shop Description",
        shopScore: 4.5,
        shopPromotionId: ["Mock Promotion ID 1", "Mock Promotion ID 2"],
        shopMissionId: 1,
        shopStatusMembership: true,
        shopCloseTime: closeTime,
        shopOpenTime: openTime,
        shopFoodCategory: _getRandomType(),
        shopImagePath:"Mock Shop Image URL",
        shopLocationCoordination: '',
        shopLocationText: '',
      ));
    }
    // items.sort((a, b) => b['unitSale'].compareTo(a['unitSale']));
    return items;
  }
}
