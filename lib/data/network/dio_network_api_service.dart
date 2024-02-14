import 'dart:io';
import 'package:dio/dio.dart';
import 'package:coffee_application/data/app_exception.dart';
import 'package:coffee_application/data/common/config.dart';
import 'package:coffee_application/data/network/cookie-manager.dart';
import 'package:coffee_application/data/network/base_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioApiService implements BaseApiService {
  late final Dio _dio;

  final baseOptions = BaseOptions(
    baseUrl: baseUrl,
    receiveTimeout: const Duration(seconds: 20),
    connectTimeout: const Duration(seconds: 20),
    responseType: ResponseType.json,
    contentType: Headers.jsonContentType,
    validateStatus: (int? status) {
      return status != null;
      // return status != null && status >= 200 && status < 300;
    },
  );

  // Private constructor
  DioApiService._() {
    _dio = Dio(baseOptions);
    _dio.interceptors.addAll([
      TokenManager.instance,
      LogInterceptor(
        responseBody: true,
        responseHeader: true,
      ),
    ]);
  }

  // Singleton instance
  static final DioApiService _instance = DioApiService._();

  // Factory constructor to return the singleton instance
  factory DioApiService() => _instance;

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await _dio.get(url);
      print("response");
      print(response);
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }

    return responseJson;
  }

  Future getGetApiResponseWithRequestParam(String url) async {
    dynamic responseJson;
    try {
      final prefs = await SharedPreferences.getInstance();
      final response =
          await _dio.get(url, queryParameters: {"_id": prefs.getInt("_id")!});
      responseJson = returnResponse(response);
    } on DioError catch (e) {
      print("Dio Error: $e");
      throw FetchDataException('Error during Dio GET request');
    } on SocketException {
      throw FetchDataException('Cannot Get Data or No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await _dio.post(url, data: data);
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

// class ErrorInterceptor extends Interceptor {
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     final status = response.statusCode;
//     final isValid = status != null && status >= 200 && status < 300;
//     if (!isValid) {
//       throw DioException.badResponse(
//         statusCode: status!,
//         requestOptions: response.requestOptions,
//         response: response,
//       );
//     }

//     super.onResponse(response, handler);
//   }
// }
