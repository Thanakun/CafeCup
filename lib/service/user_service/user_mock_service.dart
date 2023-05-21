import 'package:flutter_application_1/model/user_test_model.dart';
import 'package:flutter_application_1/service/user_service/user_service_interface.dart';

class UserMockService implements UserServiceInterface {
  @override
  Future<UserTestModel> fetchUserData(int userId) async {
    // final response = await http.get(Uri.parse(uri));
    return Future.value(
      
    );
    //TODO IMPLEMENT THE SERVICE
    throw UnimplementedError();
  }
}
