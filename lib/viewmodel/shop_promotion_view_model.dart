import 'package:coffee_application/model/request/promotion_create_request.dart';
import 'package:coffee_application/model/response/promotion_shop.dart';
import 'package:coffee_application/service/promotion_service.dart';

class ShopPromotionVM {
  final PromotionService _service = PromotionService();
  late Future<PromotionShop> promotionList;

  Future<bool> createPromotion(
      {required PromotionCreateRequestBody request}) async {
    return _service.createPromotion(promotion: request);
  }

  Future<PromotionShop> getPromotionByShopID() {
    promotionList = _service.getPromotionByShopID();
    return promotionList;
  }
}
