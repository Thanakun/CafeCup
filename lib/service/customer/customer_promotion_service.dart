import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/promotion.dart';
import 'package:coffee_application/model/response/promotion_claim_response.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';

class CustomerPromtionService {
  late final DioApiService _dio;

  CustomerPromtionService() {
    _dio = DioApiService();
  }

  Future<List<Promotion>> getCustomerPromotionShopCode() async {
    try {
      final response = await _dio.getApiPromotion(
          "/promo/getCustomerCodes", {"_customerId": boxUsers.get(0).id});
      List<dynamic> responseData = response;
      List<Promotion> promotions =
          responseData.map((data) => Promotion.fromJson(data)).toList();

      return promotions;
    } catch (_) {
      rethrow;
    }
  }

  Future<PromotionClaimResponse> getCustomerClaimShopCode() async {
    try {
      final response = await _dio.putApiPromotion(
          "/promo/customerClaimCode", {"_customerId": boxUsers.get(0).id});
      PromotionClaimResponse promotionClaimCode = PromotionClaimResponse.fromJson(response);
      return promotionClaimCode;
    } catch (_) {
      rethrow;
    }
  }
}
