import 'package:coffee_application/service/auth-service/auth-service.dart';

class LogoutVM {
  final AuthService _service = AuthService();

  void logout() {
    _service.logout();
  }
}
