import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/promotion.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';

class CustomerOnShopService {
  late final DioApiService _dio;

  CustomerOnShopService() {
    _dio = DioApiService();
  }

  Future<ShopModel> getShopByShopId({required int id}) async {
    try {
      final response = await _dio.getApiAuth("/shop/getById/", {"_id": id});
      return ShopModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Promotion>> getCustomerPromotionShopCode(
      {required int shopID}) async {
    try {
      final response = await _dio.getApiPromotion("/promo/getCustomerCodes",
          {"_customerId": boxUsers.get(0).id, "_shopId": shopID});
      List<dynamic> responseData = response;
      List<Promotion> promotions =
          responseData.map((data) => Promotion.fromJson(data)).toList();

      return promotions;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> postReachCustomerEnterShop({required int shopID}) async {
    try {
      final response = await _dio.postApiAnalytics("/reach/create", {
        "_customerId": boxUsers.get(0).id,
        "_shopId": shopID,
      });
    } catch (_) {
      rethrow;
    }
  }

  Future<CustomerModel> getCurrentCustomer() async {
    try {
      final response = await _dio
          .getApiAuth("/customer/getById", {"_id": boxUsers.get(0).id});
      return CustomerModel.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<ReviewModel>> getReviewListByShopID({
    required int shopID,
  }) async {
    try {
      final response = await _dio
          .getApiAnalytics("/review/get", {"_shopId": shopID});
      List<dynamic> responseData = response;
      List<ReviewModel> reviewList =
          responseData.map((data) => ReviewModel.fromJson(data)).toList();

      return reviewList;
    } catch (_) {
      rethrow;
    }
  }
}
