import 'package:coffee_application/service/auth-service/auth-service.dart';

class LoginVM {
  String username = "";
  String password = "";

  final AuthService _service = AuthService();
  void onUserEnterPage() {}

  void login({
    required username,
    required password,
  }) async {

    bool isLoginSuccess = await _service.login(username, password);
    print("LoginVM : $username, $password");
  }
}
