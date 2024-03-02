import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/response/promotion.dart';
import 'package:coffee_application/model/request/customer_review_request.dart';
import 'package:coffee_application/model/response/promotion_claim_response.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';

class CustomerReviewService {
  late final DioApiService _dio;

  CustomerReviewService() {
    _dio = DioApiService();
  }

  Future<List<ShopModel>> getAllShop([Map<String, dynamic>? filter]) async {
    try {
      final response = await _dio.postAuthApi("/shop/get", filter);
      List<dynamic> responseData = response["data"];
      List<ShopModel> shops =
          responseData.map((data) => ShopModel.fromJson(data)).toList();

      return shops;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> submitReview({required CustomerReviewRequestBody body}) async {
    try {
      body.iCustomerId = boxUsers.get(0).id;
      final data = await _dio.postApiAnalytics("/review/create", body.toJson());
      return true;
    } catch (_) {
      return false;
      // rethrow;
    }
  }
}
