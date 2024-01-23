import 'package:dio/dio.dart';
import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/shop.dart';

class RegisterService {
  late final DioApiService _dio;

  RegisterService() {
    _dio = DioApiService();
  }

  // Future mockingShopDataService() async {
  //   final data = await _dio.getPostApiResponse("/shop/inserttest", []);
  //   print(data);
  // }

  Future mockingCustomerDataService() async {
    final data = await _dio.getPostApiResponse("/customer/inserttest", []);
    print(data);
  }

  Future postShopRegister(ShopModel shop) async {
    try {
      final data = await _dio.getPostApiResponse("/shop/register", shop);

      return data;
      // print(data);
    } catch (_) {
      rethrow;
    }
  }

  Future postCustomerRegister(CustomerModel customer) async {
    try {
      final data =
          await _dio.getPostApiResponse("/customer/register", customer);
      return data;
      // print(data);
    } catch (e) {
      rethrow;
    }
  }

  Future getUserWhenEnteringTheRegisterPage() async {
    try {
      final data = await _dio.getGetApiResponse("/shop/get");

    } catch (_) {
      rethrow;
    }
  }
}
