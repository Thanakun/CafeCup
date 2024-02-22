import 'package:dio/dio.dart';
import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late final DioApiService _dio;
  late final SharedPreferences prefs;

  AuthService() {
    _dio = DioApiService();
  }

  Future mockingShopDataService() async {
    final prefs = await SharedPreferences.getInstance();
    final data =
        await _dio.getAuthApiWithParam("/shop/inserttest");
  }

  Future mockingCustomerDataService() async {
    final data = await _dio.postAuthApi("/customer/inserttest", []);
  }

  Future<bool> validateToken() async {
    try {
      final data =
          await _dio.getAuthApiWithParam("/validateToken");
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> logout() async {
    try {
      _dio.clearCookies();
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final data = await _dio.postAuthApi(
          "/customer/login", {"username": username, "password": password});

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<dynamic> postShopRegister(ShopModel shop) async {
    try {
      final data = await _dio.postAuthApi("/shop/register", shop);

      return data;
      // print(data);
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> postCustomerRegister(CustomerModel customer) async {
    try {
      final data = await _dio.postAuthApi(
          "/customer/register", customer.toJson());
      return data;
      // print(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getUserWhenEnteringTheRegisterPage() async {
    try {
      final data = await _dio.getApiAuth("/shop/get");
    } catch (_) {
      rethrow;
    }
  }
}
