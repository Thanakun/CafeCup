import 'dart:convert';

import 'package:coffee_application/service/auth-service/auth-service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenVM {
  final AuthService _authService = AuthService();
  Future<bool> validateToken() async {
    // String? token = await getTokenFromStorage();
    try {
      bool result = await _authService.validateToken();
      print("result");
      print(result);
      return result;
    } catch (_) {
      print(_);
      return false;
    }
  }

  Future<String?> getTokenFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
