import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/shop.dart';

class CustomerShopService {
  late final DioApiService _dio;

  CustomerShopService() {
    _dio = DioApiService();
  }

  Future<List<ShopModel>> getAllShop() async {
    try {
      final response = await _dio.getGetApiResponse(
          "/shop/get");
      List<dynamic> responseData = response;
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
