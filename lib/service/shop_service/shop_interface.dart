import 'package:coffee_application/model/menu.dart';
import 'package:coffee_application/model/review_record.dart';
import 'package:coffee_application/model/shop_promotion_menu.dart';
import 'package:coffee_application/model/shop_reward_menu.dart';


abstract class ShopPageServiceInterface {
  Future<List<Menu>> fetchMenuOfShopWithId(int id);
  Future<List<ShopPromotionMenu>> fetchMenuPromotionOfShopWithId(int id);
  Future<List<ShopRewardMenu>> fetchMenuRewardOfShopWithId(int id);
  Future<List<ReviewRecord>> fetchReviewRecordWithShopId(int id);
}
