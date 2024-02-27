import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/shop.dart';

class SearchCustomerService {
  late final DioApiService _dio;

  SearchCustomerService() {
    _dio = DioApiService();
  }

  Future<List<ShopModel>> getShopByShopNameAndTag(Map<String, dynamic> data,
      [Map<String, dynamic>? query]) async {
    try {
      final response = await _dio.postAuthApi("/shop/get", data, query);
      List<dynamic> responseData = response["data"];
      List<ShopModel> shops =
          responseData.map((data) => ShopModel.fromJson(data)).toList();

      return shops;
    } catch (error) {
      // Handle DioError or any other exception that might occur
      print("Error: $error");
      rethrow;
    }
  }
}
