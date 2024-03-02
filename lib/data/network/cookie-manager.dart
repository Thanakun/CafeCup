import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/hive/users.dart';
import 'package:dio/dio.dart';
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
          clearToken();
        }
      } else if (response.data.containsKey('token') &&
          response.data.containsKey('currentShop')) {
        var token = response.data['token'] as String?;
        var currentShop = response.data['currentShop'] as Map<String, dynamic>?;

        if (token != null &&
            currentShop != null &&
            currentShop['_id'] != null) {
          _saveToken(token, currentShop['_id']);
        } else if (status == 401) {
          clearToken();
        }
      } else {}
    } catch (e) {
      print(e);
    }

    // Continue with the response handling
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      options.headers['token'] = '$_token';
      options.headers['Access-Control-Allow-Origin'] = '*';
      print(_token);
      if (options.path == "/customer/login") {
        options.queryParameters = {'_id': _id};
      }
      super.onRequest(options, handler);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> initToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');

    if (boxUsers.isNotEmpty) {
      var user = boxUsers.get(0);
      _id = user.id;
    }
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

  void clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = null;
    _id = null;
    prefs.remove("token");
    boxUsers.delete(0);
  }
}
