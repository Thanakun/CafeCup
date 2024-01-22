import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/app_exception.dart';
import 'package:flutter_application_1/data/common/config.dart';
import 'package:flutter_application_1/data/network/base_api_service.dart';

class DioApiService implements BaseApiService {
  late final Dio _dio;

  // Private constructor
  DioApiService._() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ));
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
