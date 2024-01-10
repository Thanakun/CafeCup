import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/network/dio_network_api_service.dart';

class ShopRegisterService {
  late final DioApiService _dio;

  ShopRegisterService() {
    _dio = DioApiService();
  }

  Future getUserWhenEnteringTheRegisterPage() async {
    try {
      //TODO get userId API Or ShopId API
      final response = await _dio.getGetApiResponse("");
    } catch (e) {
      rethrow;
    }
  }
}
