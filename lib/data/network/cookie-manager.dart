import 'dart:convert';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/hive/users.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager extends Interceptor {
  // Singleton Static field with getter
  static final TokenManager _instance = TokenManager._internal();
  static TokenManager get instance => _instance;
  TokenManager._internal();

  String? _token;
  int? _id;
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    try {
      if (response.data.containsKey('token') &&
          response.data.containsKey('currentUser')) {
        var token = response.data['token'] as String?;
        var currentUser = response.data['currentUser'] as Map<String, dynamic>?;

        if (token != null &&
            currentUser != null &&
            currentUser['_id'] != null) {
          _saveToken(token, currentUser['_id']);
        } else if (status == 401) {
          _clearToken();
        }
      } else {}
    } catch (e) {}

    // Continue with the response handling
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['token'] = '$_token';
    options.headers['Access-Control-Allow-Origin'] = '*';
    //   "Access-Control-Allow-Credentials": true,
    // "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    // "Access-Control-Allow-Methods": "POST, OPTIONS"
    if (options.path == "/customer/login") {
      options.queryParameters = {'_id': _id};
    }

    print(options.uri);
    return super.onRequest(options, handler);
  }

  Future<void> initToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _id = boxUsers.get(0).id;
  }

  void _saveToken(String newToken, int id) async {
    if (_token != newToken) {
      _token = newToken;
      _id = id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", _token!);
      boxUsers.put(
          0,
          Users(
            id: _id!,
          ));
    }
  }

  void _clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = null;
    _id = null;
    prefs.remove("token");
    boxUsers.delete(0);
  }
}
