import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/customer-shop/customer_shop_service.dart';

class CustomerShopViewModel {
  final CustomerShopService _service = CustomerShopService();
  //Create void function call when init page
  late Future<List<ShopModel>> listAllShopFuture;

  Future getUserWhenEnteringTheRegisterPage() async {
    fetchAllShopItem();
  }

  Future<void> fetchAllShopItem() async {
    try {
    listAllShopFuture = _service.getAllShop();
    } catch (_) {
      rethrow;
    }
  }

  // Future mockingCustomerDataService() async {
  //   final data = await _dio.getPostApiResponse("/customer/inserttest", []);
  //   print(data);
  // }

  // Future mockingShopDataService() async {
  //   final data = await _dio.getPostApiResponse("/shop/inserttest", []);
  //   print(data);
  // }
}
