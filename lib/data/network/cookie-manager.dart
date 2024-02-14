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
    final isValid = status != null && status >= 200 && status < 300;

    if (!isValid) {
      throw DioException.badResponse(
        statusCode: status!,
        requestOptions: response.requestOptions,
        response: response,
      );
    }

    // Handle the token for any successful response
    if (response.data['token'] != null && response.data["currentUser"]['_id'] != null) {
      _saveToken(response.data['token'].toString(), response.data["currentUser"]['_id']);
    } else if (status == 401) {
      // Assuming 401 is used for unauthorized access
      _clearToken();
    }

    // Continue with the response handling
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('token: $_token');
    debugPrint('_id: $_id');
    options.headers['token'] = '$_token'; // Use 'Authorization' for JWT tokens
    options.queryParameters = {'_id': _id};
    return super.onRequest(options, handler);
  }

  Future<void> initToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _id = prefs.getInt('_id');
  }

  void _saveToken(String newToken, int id) async {
    if (_token != newToken) {
      _token = newToken;
      _id = id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", _token!);
      prefs.setInt("_id", _id!);
      debugPrint(_token);
      debugPrint(_id.toString());
    }
  }

  void _clearToken() async {
    _token = null;
    _id = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("_id");
  }
}
