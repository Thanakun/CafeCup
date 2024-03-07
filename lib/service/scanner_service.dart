import 'package:coffee_application/data/network/dio_network_api_service.dart';

class ScannerService {
  late final DioApiService _dio;

  ScannerService() {
    _dio = DioApiService();
  }

  Future<bool> onUserScannedCode({required String code}) async {
    try {
      final response =
          await _dio.putApiPromotion("/promo/customerActivatedCode", {
        "codeString": code
          });
      print(response);
      return true;
    } catch (_) {
      return false;
    }
  }
}
