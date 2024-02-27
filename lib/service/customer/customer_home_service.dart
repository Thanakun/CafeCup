import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/customer_recommendation.dart';
import 'package:coffee_application/model/shop.dart';

class CustomerShopService {
  late final DioApiService _dio;

  CustomerShopService() {
    _dio = DioApiService();
  }

  Future<List<ShopModel>> getAllShop([Map<String, dynamic>? filter]) async {
    try {
      final response = await _dio
          .postAuthApi("/shop/get", filter, {"page": 1, "pageSize": 500});

      // Check if "data" is not null and is a List<dynamic>
      if (response["data"] != null && response["data"] is List<dynamic>) {
        List<dynamic> responseData = response["data"];
        List<ShopModel> shops =
            responseData.map((e) => ShopModel.fromJson(e)).toList();

        return shops;
      } else {
        // Handle the case where "data" is null or not of type List<dynamic>
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<CustomerRecommendation>> getRecommendationShop() async {
    try {
      final response = await _dio.getAuthApiWithParam("/customer/recommend");
      List<dynamic> responseData = response;
      List<CustomerRecommendation> recommendations = responseData
          .map((data) => CustomerRecommendation.fromJson(data))
          .toList();
      return recommendations;
    } catch (_) {
      rethrow;
    }
  }
}
