
import 'package:flutter_application_1/model/review_record.dart';
import 'package:flutter_application_1/model/shop.dart';


abstract class SearchShopServiceInterface {
  Future<List<Shop>> fetchAllShopList();
  Future<List<ReviewRecord>> fetchReviewRecordAllShop();
}
