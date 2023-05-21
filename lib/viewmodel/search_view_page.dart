import 'package:flutter_application_1/model/shop.dart';
import 'package:flutter_application_1/service/search_service/search_shop_interface.dart';
import 'package:flutter_application_1/service/search_service/search_shop_mock_service.dart';
import 'package:flutter_application_1/model/review_record.dart';

class SearchViewModel {
  final List<String> itemsFilterOrder = [
    "คะแนนรวม",
    "คะแนนอาหาร",
    "คะแนนบริการ",
    "คะแนนสถานที่",
    "ระยะทาง"
  ];

  String searchFilterOrder = "คะแนนรวม";
  bool isCheckedTheFilterTime = false;
  DateTime isOpenCurrentTime = DateTime.now();
  Future<List<Shop>>? listAllShopFuture;
  Future<List<ReviewRecord>>? listAllShopReviewFuture;

  List<Shop>? listAllFilterShop;
  List<ReviewRecord>? listShopReviewRecord;

  SearchShopServiceInterface service = SearchShopMockService();

  Future<void> fetchAllReviewRecordItem() async {
    listAllShopReviewFuture = service.fetchReviewRecordAllShop();
    List<ReviewRecord>? result = await listAllShopReviewFuture;
    listShopReviewRecord = result;

    // Calculate shop averages
    if (listShopReviewRecord != null) {
      List<ShopReview> shopAverages =
          ShopStatistics.calculateShopAverages(listShopReviewRecord!);

      // Print shop ID and average star points
      for (ShopReview shopReview in shopAverages) {
        print('Shop ID: ${shopReview.shopId}');
        print('Average Point: ${shopReview.averageFood}');
        print('Average Service: ${shopReview.averageService}');
        print('Average Place: ${shopReview.averagePlace}');
        print('----------------------------');
      }
    }
  }

  Future<void> onUserSearchItemFilter(String searchString) async {
    if (searchString == '') {
      listAllFilterShop = await listAllShopFuture;
    }

    if (searchString == null) {
      listAllFilterShop = await listAllShopFuture;
    } else {
      List<Shop>? allShops = await listAllShopFuture;
      if (allShops != null) {
        listAllFilterShop = allShops.where((shop) {
          bool matchesSearchString =
              shop.shopName.toLowerCase().contains(searchString.toLowerCase());
          if (isCheckedTheFilterTime) {
            bool isOpen = shop.shopOpenTime.isBefore(isOpenCurrentTime);
            bool isClose = shop.shopCloseTime.isAfter(isOpenCurrentTime);
            return matchesSearchString && isOpen && isClose;
          } else {
            return matchesSearchString;
          }
        }).toList();

        // Apply the selected filter order
        if (searchFilterOrder == "คะแนนรวม") {
          listAllFilterShop?.sort((a, b) => b.shopScore.compareTo(a.shopScore));
        } else if (searchFilterOrder == "คะแนนอาหาร") {
          listAllFilterShop
              ?.sort((a, b) => b.shopScorePoint.compareTo(a.shopScorePoint));
        } else if (searchFilterOrder == "คะแนนบริการ") {
          listAllFilterShop?.sort(
              (a, b) => b.shopScoreService.compareTo(a.shopScoreService));
        } else if (searchFilterOrder == "คะแนนสถานที่") {
          listAllFilterShop
              ?.sort((a, b) => b.shopScorePlace.compareTo(a.shopScorePlace));
        } else if (searchFilterOrder == "ระยะทาง") {
          // Implement the sorting based on distance here
        }
      }
    }
  }

  Future<void> fetchAllShopItem() async {
    listAllShopFuture = service.fetchAllShopList();
    List<Shop>? result = await listAllShopFuture;
    listAllFilterShop = result;
    print(listAllFilterShop?.length);
  }
}

class ShopReview {
  final int shopId;
  final double averageFood;
  final double averageService;
  final double averagePlace;

  ShopReview({
    required this.shopId,
    required this.averageFood,
    required this.averageService,
    required this.averagePlace,
  });
}

class ShopStatistics {
  static List<ShopReview> calculateShopAverages(
      List<ReviewRecord> reviewRecords) {
    Map<int, List<double>> shopStarPoints = {};

    // Calculate sum of star points for each shop
    print(reviewRecords);
    for (ReviewRecord review in reviewRecords) {
      int shopId = review.shopId;
      double point = review.starPointPoint.toDouble();
      double service = review.starPointService.toDouble();
      double place = review.starPointPlace.toDouble();

      if (shopStarPoints.containsKey(shopId)) {
        shopStarPoints[shopId]![0] += point;
        shopStarPoints[shopId]![1] += service;
        shopStarPoints[shopId]![2] += place;
        shopStarPoints[shopId]![3] += 1; // count
      } else {
        shopStarPoints[shopId] = [point, service, place, 1];
      }
    }

    

    // Calculate average star points for each shop
    List<ShopReview> shopAverages = [];
    shopStarPoints.forEach((shopId, starPoints) {
      double count = starPoints[3];
      double averagePoint = starPoints[0] / count;
      double averageService = starPoints[1] / count;
      double averagePlace = starPoints[2] / count;

      shopAverages.add(ShopReview(
        shopId: shopId,
        averageFood: averagePoint,
        averageService: averageService,
        averagePlace: averagePlace,
      ));
    });

    return shopAverages;
  }
}
