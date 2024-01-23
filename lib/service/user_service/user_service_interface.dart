import 'package:coffee_application/model/user_test_model.dart';

abstract class UserServiceInterface {
  Future<UserTestModel> fetchUserData(int userId);
}
