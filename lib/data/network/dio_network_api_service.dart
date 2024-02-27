import 'dart:io';
import 'package:coffee_application/hive/boxes.dart';
import 'package:dio/dio.dart';
import 'package:coffee_application/data/app_exception.dart';
import 'package:coffee_application/data/common/config.dart';
import 'package:coffee_application/data/network/cookie-manager.dart';
import 'package:coffee_application/data/network/base_api_service.dart';

class DioApiService implements BaseApiService {
  late final Dio _dioAuthService;
  late final Dio _dioAnalyticService;
  late final Dio _dioPromotionService;

  DioApiService._() {
    _dioAuthService = _createDio(baseUrlAuthService);
    _dioAnalyticService = _createDio(baseUrlAnalyticService);
    _dioPromotionService = _createDio(baseUrlPromotionService);
  }

  Dio _createDio(String baseUrl) {
    BaseOptions options = BaseOptions(
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      validateStatus: (int? status) {
        return status != null;
      },
    );

    Dio dio = Dio(options);
    dio.options.baseUrl = baseUrl;
    dio.interceptors.addAll([TokenManager.instance]);
    return dio;
  }

  factory DioApiService() => _instance;

  static final DioApiService _instance = DioApiService._();

  Dio get authService => _dioAuthService;

  Dio get analyticService => _dioAnalyticService;

  Dio get promotionService => _dioPromotionService;

  @override
  Future<dynamic> getApiAuth(String url, [Map<String, dynamic>? query]) async {
    dynamic responseJson;
    try {
      final response =
          await _dioAuthService.get(url, queryParameters: query ?? {});
      responseJson = returnResponse(response);
    } on DioException catch (_) {
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }

    return responseJson; // Return the processed response or null if not handled
  }

  Future<dynamic> getApiAnalytics(String url,
      [Map<String, dynamic>? query]) async {
    dynamic responseJson;
    try {
      final response =
          await _dioAnalyticService.get(url, queryParameters: query ?? {});
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> postApiAnalytics(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await _dioAnalyticService.post(url, data: data);
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> getApiPromotion(String url,
      [Map<String, dynamic>? query]) async {
    dynamic responseJson;
    try {
      final response =
          await _dioPromotionService.get(url, queryParameters: query ?? {});
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }
    return responseJson;
  }

  Future postApiPromotion(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await _dioPromotionService.post(url, data: data);
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio POST request');
    } on SocketException {
      throw FetchDataException('Cannot Post Data or No Internet Connection');
    }

    return responseJson;
  }

  Future<dynamic> putApiPromotion(String url,
      [Map<String, dynamic>? query]) async {
    dynamic responseJson;
    try {
      final response =
          await _dioPromotionService.put(url, queryParameters: query ?? {});
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> getApiAnalyticsWithParam(
    String url,
  ) async {
    dynamic responseJson;
    try {
      final response = await _dioAnalyticService
          .get(url, queryParameters: {"_id": boxUsers.get(0).id});
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }
    return responseJson;
  }

  void clearCookies() {
    TokenManager.instance.clearToken();
    _dioAuthService.options.headers.clear();
    _dioAnalyticService.options.headers.clear();
    _dioPromotionService.options.headers.clear();
  }

  Future getAuthApiWithParam(
    String url,
  ) async {
    dynamic responseJson;
    try {
      print("boxUsers.get(0).id");
      print(boxUsers.get(0).id);
      final response = await _dioAuthService
          .get(url, queryParameters: {"_id": boxUsers.get(0).id});
      responseJson = returnResponse(response);
    } on DioError catch (_) {
      print("Dio Error: ${_}");
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postAuthApi(String url, dynamic data,
      [Map<String, dynamic>? query]) async {
    dynamic responseJson;
    try {
      final response =
          await _dioAuthService.post(url, data: data, queryParameters: query);
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio POST request');
    } on SocketException {
      throw FetchDataException('Cannot Post Data or No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 401:
        throw UnautorizedException(response.data.toString());
      case 400:
        throw BadRequestException(response.data.toString());
      case 404:
        throw UnautorizedException(response.data.toString());
      case 500:
        throw InternalServerException(response.data.toString());
      default:
        throw FetchDataException(
            'Error while connecting to the server with status code ${response.statusCode}');
    }
  }
}
