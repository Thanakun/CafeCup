import 'dart:math';
import 'package:flutter_application_1/model/review_record.dart';
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

  int _getRandomStarRating() {
    final random = Random();
    return random.nextInt(5) + 1;
  }

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
  Future<List<Shop>> fetchAllShopList() async {
    int count = 10;
    List<Shop> items = [];
    DateTime currentDate = DateTime.now();
    int currentMonth = currentDate.month;

    int totalFoodScore = 0;
    int totalServiceScore = 0;
    int totalPlaceScore = 0;

    int currentYear = currentDate.year;
    for (int index = 0; index < count; index++) {
      int month = (currentMonth - index) % 12;
      int yearOffset = ((currentMonth - index) / 12).floor();
      int year = currentYear - yearOffset;
      DateTime monthStartDate = DateTime(year, month);
      DateTime openTime = _getRandomOpenTime();
      DateTime closeTime = _getRandomCloseTime(openTime);

      double foodScore = _getRandomStarRating().toDouble();
      double serviceScore = _getRandomStarRating().toDouble();
      double placeScore = _getRandomStarRating().toDouble();

      totalFoodScore += foodScore.toInt();
      totalServiceScore += serviceScore.toInt();
      totalPlaceScore += placeScore.toInt();

      items.add(Shop(
        shopId: index + 1,
        shopName: "Product ${index + 1}",
        shopDescription: "Mock Shop Description",
        shopAverageAllScore: (foodScore + serviceScore + placeScore) / 3,
        shopPromotionId: ["Mock Promotion ID 1", "Mock Promotion ID 2"],
        shopMissionId: 1,
        shopStatusMembership: true,
        shopCloseTime: closeTime,
        shopOpenTime: openTime,
        shopFoodCategory: _getRandomType(),
        shopImagePath: "Mock Shop Image URL",
        shopLocationCoordination: '',
        shopLocationText: '',
        shopAverageScorePoint: foodScore,
        shopAverageScoreService: serviceScore,
        shopAverageScorePlace: placeScore,
      ));
    }

    double averageFoodScore = totalFoodScore / count;
    double averageServiceScore = totalServiceScore / count;
    double averagePlaceScore = totalPlaceScore / count;

    for (int index = 0; index < count; index++) {
      items[index].shopAverageScorePoint = averageFoodScore;
      items[index].shopAverageScoreService = averageServiceScore;
      items[index].shopAverageScorePlace = averagePlaceScore;
    }
    // items.sort((a, b) => b['unitSale'].compareTo(a['unitSale']));
    return items;
  }

  @override
  Future<List<ReviewRecord>> fetchReviewRecordAllShop() async {
    List<ReviewRecord> itemReviewRecord = [];
    List<int> userIds = List.generate(500, (index) => index + 1);
    List<int> shopIds = List.generate(10, (index) => index + 1);
    List<double> starPoints = [1.0, 2.0, 3.0, 4.0, 5.0];

    // Generate 100 reviews for 10 shops from different user IDs
    for (int i = 0; i < 500; i++) {
      if (userIds.isEmpty) {
        break; // Break the loop if the user IDs are exhausted
      }

      int randomUserIdIndex = random.nextInt(userIds.length);
      int randomShopIdIndex = random.nextInt(shopIds.length);
      int userId = userIds[randomUserIdIndex];
      int shopId = shopIds[randomShopIdIndex];
      double randomStarPointPoint =
          starPoints[random.nextInt(starPoints.length)];
      double randomStarPointService =
          starPoints[random.nextInt(starPoints.length)];
      double randomStarPointPlace =
          starPoints[random.nextInt(starPoints.length)];

      itemReviewRecord.add(
        ReviewRecord(
          reviewId: i + 1,
          userId: userId,
          shopId: shopId,
          shopImagePath: "Mock Shop Image URL",
          starPointPoint: randomStarPointPoint,
          starPointService: randomStarPointService,
          starPointPlace: randomStarPointPlace,
          comment: "Mock Comment $i",
          foodImagePath: "Mock Food Image URL",
          checkInTime: DateTime.now(),
        ),
      );

      // Remove the used user ID to ensure uniqueness
      userIds.removeAt(randomUserIdIndex);
    }
    print(itemReviewRecord.length);

    return itemReviewRecord;
  }
}
