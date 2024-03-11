import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/data/network/minio_service.dart';
import 'package:coffee_application/model/customer_recommendation.dart';
import 'package:coffee_application/model/response/rank_bar_chart_response.dart';
import 'package:coffee_application/model/response/top_reach_response.dart';
import 'package:coffee_application/model/shop.dart';

class CustomerShopService {
  late final DioApiService _dio;
  late final MinioService _minio;

  CustomerShopService() {
    _dio = DioApiService();
    _minio = MinioService();
  }

  Future<List<ShopModel>> getAllShop([Map<String, dynamic>? filter]) async {
    try {
      final response = await _dio
          .postAuthApi("/shop/get", filter, {"page": 1, "pageSize": 100});

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

  Future<String> shopGetObjectFromMinio({
    required int shopId,
    required objectName,
  }) async {
    try {
      return await _minio.getObjectItem(
        bucketName: "Shop${shopId.toString()}",
        objectName: objectName,
      );
    } catch (e) {
      return "";
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

  Future<List<ShopReachModel>> getTopReachShop() async {
    try {
      final response = await _dio.getApiAuth("/shop/getWithSortByReach");
      ShopTopReachModelResponse responseData =
          ShopTopReachModelResponse.fromJson(
        response,
      );
      if (responseData.data != null) {
        List<ShopReachModel> shops = responseData.data!;
        return shops;
      } else {
        return [];
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<ReviewRankBarChartResponse> getShopReviewRank(
      {required int shopId}) async {
    try {
      final response = await _dio.getApiAnalytics("/analytic/reviewRank", {
        "_shopId": shopId,
      });
      ReviewRankBarChartResponse responseData =
          ReviewRankBarChartResponse.fromJson(
        response,
      );
      return responseData;
    } catch (_) {
      rethrow;
    }
  }
}
