import 'package:flutter_application_1/model/user_test_model.dart';

abstract class UserServiceInterface {
  Future<UserTestModel> fetchUserData(int userId);
}
