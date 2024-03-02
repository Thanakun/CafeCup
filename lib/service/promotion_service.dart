import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/response/promotion.dart';
import 'package:coffee_application/model/request/promotion_create_request.dart';
import 'package:coffee_application/model/response/promotion_shop.dart';

class PromotionService {
  late final DioApiService _dio;

  PromotionService() {
    _dio = DioApiService();
  }

  Future<bool> createPromotion(
      {required PromotionCreateRequestBody promotion}) async {
    try {
      promotion.iShopId = boxUsers.get(0).id;
      final response =
          await _dio.postApiPromotion("/promo/create", promotion.toJson());
      print("response");
      print(response);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<PromotionShop> getPromotionByShopID() async {
    try {
      final response = await _dio.getApiPromotion(
          "promo/getShopCodes", {"_shopId": boxUsers.get(0).id});
      return PromotionShop.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
