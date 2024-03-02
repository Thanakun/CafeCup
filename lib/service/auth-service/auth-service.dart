import 'package:coffee_application/model/response/validate_response.dart';
import 'package:dio/dio.dart';
import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = Dio();
  late final DioApiService _dio;
  late final SharedPreferences prefs;
  String userType = "Customer";

  AuthService() {
    _dio = DioApiService();
  }

  Future mockingShopDataService() async {
    final prefs = await SharedPreferences.getInstance();
    final data = await _dio.getAuthApiWithParam("/shop/inserttest");
  }

  Future mockingCustomerDataService() async {
    final data = await _dio.postAuthApi("/customer/inserttest", []);
  }

  Future<ValidateTokenResponse> validateToken() async {
    try {
      final data = await _dio.getAuthApiWithParam("/validateToken");
      final response = ValidateTokenResponse.fromJson(data);

      return response;
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
      if (userType == "Customer") {
        final data = await _dio.postAuthApi(
            "/customer/login", {"username": username, "password": password});
        // final data = await dio.get(
        //   "http://172.31.48.1:3002/livez",
        // );
        // "/customer/login", {"username": username, "password": password});
        print("data");
        print(data);
      } else if (userType == "Shop") {
        final data = await _dio.postAuthApi(
            "/shop/login", {"username": username, "password": password});
        print("data");
        print(data);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> postShopRegister(ShopModel shop) async {
    try {
      final data = await _dio.postAuthApi("/shop/register", shop.toJson());

      return true;
      // print(data);
    } catch (_) {
      return false;
    }
  }

  Future<bool> postCustomerRegister(CustomerModel customer) async {
    try {
      print(customer.toJson());
      final data =
          await _dio.postAuthApi("/customer/register", customer.toJson());
      print(data);
      return true;
    } catch (e) {
      return false;
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
