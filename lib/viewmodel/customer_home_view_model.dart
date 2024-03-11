import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/customer_recommendation.dart';
import 'package:coffee_application/model/response/rank_bar_chart_response.dart';
import 'package:coffee_application/model/response/top_reach_response.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/customer/customer_home_service.dart';

class CustomerHomeVM {
  final CustomerShopService _service = CustomerShopService();
  //Create void function call when init page
  late Future<List<ShopModel>> listAllShopFuture;
  late Future<List<CustomerRecommendation>> listRecommendationShopFuture;
  late Future<List<ShopReachModel>> listReachShopFuture;
  List<ShopModel> matchedShops = [];
  List<ShopModel> matchedReachShops = [];
  Future<void> getUserWhenEnteringTheRegisterPage() async {
    fetchAllShopItem();
    fetchRecommendationShopItem();
    fetchReachShopitem();
  }

  Future<void> fetchAllShopItem() async {
    try {
      listAllShopFuture = _service.getAllShop();
    } catch (_) {
      rethrow;
    }
  }

  Future<String> shopGetImagePathNetworkFromMinio({
    required int shopId,
    required String objectName,
  }) async {
    return Future.value(await _service.shopGetObjectFromMinio(
        shopId: shopId, objectName: objectName));
  }

  Future<void> fetchRecommendationShopItem() async {
    try {
      listRecommendationShopFuture = _service.getRecommendationShop();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> fetchReachShopitem() async {
    try {
      listReachShopFuture = _service.getTopReachShop();
    } catch (_) {
      rethrow;
    }
  }

  Future<ReviewRankBarChartResponse> fetchShopReviewRank(
      {required int shopId}) async {
    try {
      return _service.getShopReviewRank(shopId: shopId);
    } catch (_) {
      rethrow;
    }
  }

  void getShopRecommendation(
      List<ShopModel> shops, List<CustomerRecommendation> recommendShops) {
    matchedShops = [];

    for (var e in recommendShops) {
      // Use where method to filter shops based on the condition
      List<ShopModel> matchingShops =
          shops.where((shop) => shop.iId == e.iShopID).toList();

      // Take the first matching shop or use the default value
      ShopModel matchingShop = matchingShops.isNotEmpty
          ? matchingShops.first
          : ShopModel.defaultWithIdNegativeOne();

      // Add the matching shop to the list
      if (matchingShop.iId != -1) matchedShops.add(matchingShop);

      // If no matching shop is found, you can print a message or handle it as needed
    }
    // Now, 'matchedShops' contains the shops that match the condition or the default value
  }

  void getShopReach(List<ShopModel> shops, List<ShopReachModel> reachShops) {
    for (var e in reachShops) {
      // Use where method to filter shops based on the condition
      List<ShopModel> matchingShops =
          shops.where((shop) => shop.iId == e.iId).toList();

      ShopModel matchingShop = matchingShops.isNotEmpty
          ? matchingShops.first
          : ShopModel.defaultWithIdNegativeOne();

      if (matchingShop.iId != -1) matchedReachShops.add(matchingShop);
    }
  }
}
