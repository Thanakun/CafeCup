import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/shop.dart';

class CustomerOnShopService {
  late final DioApiService _dio;

  CustomerOnShopService() {
    _dio = DioApiService();
  }

  Future<ShopModel> getShopByShopId({required int id}) async {
    try {
      final response = await _dio.getApiAuth("/shop/getById/", {"_id": id});
      return ShopModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
