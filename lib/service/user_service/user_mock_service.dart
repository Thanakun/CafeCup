import 'package:coffee_application/model/user_test_model.dart';
import 'package:coffee_application/service/user_service/user_service_interface.dart';

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
