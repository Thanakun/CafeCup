import 'package:coffee_application/model/review_record.dart';
import 'package:coffee_application/model/shop.dart';

abstract class SearchShopServiceInterface {
  Future<List<ShopModel>> fetchAllShopList();
  Future<List<ReviewRecord>> fetchReviewRecordAllShop();
}
