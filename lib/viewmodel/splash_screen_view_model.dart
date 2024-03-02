import 'dart:convert';

import 'package:coffee_application/model/response/validate_response.dart';
import 'package:coffee_application/service/auth-service/auth-service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenVM {
  final AuthService _authService = AuthService();
  Future<validateData> validateToken() async {
    // String? token = await getTokenFromStorage();
    try {
      var result = await _authService.validateToken();
      if (result.status == "ok") {
        return result.data!;
      } else {
        return validateData(
          iId: -1,
          role: "Unknown",
        );
      }
    } catch (_) {
      return validateData(
        iId: -1,
        role: "Unknown",
      );
    }
  }

  Future<String?> getTokenFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
