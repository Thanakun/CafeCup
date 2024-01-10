import 'package:flutter_application_1/model/menu.dart';
import 'package:flutter_application_1/model/review_record.dart';
import 'package:flutter_application_1/model/shop_promotion_menu.dart';
import 'package:flutter_application_1/model/shop_reward_menu.dart';


abstract class ShopPageServiceInterface {
  Future<List<Menu>> fetchMenuOfShopWithId(int id);
  Future<List<ShopPromotionMenu>> fetchMenuPromotionOfShopWithId(int id);
  Future<List<ShopRewardMenu>> fetchMenuRewardOfShopWithId(int id);
  Future<List<ReviewRecord>> fetchReviewRecordWithShopId(int id);
}
