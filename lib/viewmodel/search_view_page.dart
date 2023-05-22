import 'package:cloud_firestore/cloud_firestore.dart';
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

  String? searchFilterOrder;
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
      Map<int, List<double>> shopStarPoints = {};

      // Calculate sum of star points for each shop
      for (ReviewRecord review in listShopReviewRecord!) {
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

      // Calculate average star points for each shop and update the Shop model
      listAllFilterShop?.forEach((shop) {
        int shopId = shop.shopId;
        if (shopStarPoints.containsKey(shopId)) {
          double count = shopStarPoints[shopId]![3];
          double averagePoint = shopStarPoints[shopId]![0] / count;
          double averageService = shopStarPoints[shopId]![1] / count;
          double averagePlace = shopStarPoints[shopId]![2] / count;

          shop.shopAverageScorePoint = averagePoint;
          shop.shopAverageScoreService = averageService;
          shop.shopAverageScorePlace = averagePlace;
        }
      });

      // Print shop ID and average star points
      for (Shop shop in listAllFilterShop!) {
        print('Shop ID: ${shop.shopId}');
        print('Average All Point: ${shop.shopAverageAllScore}');
        print('Average Point: ${shop.shopAverageScorePoint}');
        print('Average Service: ${shop.shopAverageScoreService}');
        print('Average Place: ${shop.shopAverageScorePlace}');
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
          listAllFilterShop?.sort(
              (a, b) => b.shopAverageAllScore.compareTo(a.shopAverageAllScore));
        } else if (searchFilterOrder == "คะแนนอาหาร") {
          listAllFilterShop?.sort((a, b) =>
              b.shopAverageScorePoint.compareTo(a.shopAverageScorePoint));
        } else if (searchFilterOrder == "คะแนนบริการ") {
          listAllFilterShop?.sort((a, b) =>
              b.shopAverageScoreService.compareTo(a.shopAverageScoreService));
        } else if (searchFilterOrder == "คะแนนสถานที่") {
          listAllFilterShop?.sort((a, b) =>
              b.shopAverageScorePlace.compareTo(a.shopAverageScorePlace));
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
    print("${listAllFilterShop?.length} Hello");
  }

  Shop? getShopById(int id) {
    try {
      Shop? shop = listAllFilterShop?[id];
      // Do something with the shop
      return shop;
    } catch (e) {
      // Shop not found or error occurred
      return null;
    }
  }
}
