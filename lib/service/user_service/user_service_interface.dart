import 'package:flutter_application_1/model/user_test_model';

abstract class UserServiceInterface {
  Future<UserTestModel> fetchUserData(int userId);
  // Future<UserTestModel> fetchBitcoinDataByCurrencyQuoteToCurrencyBase(
  //     {required String currencybaseParam, required String currencyquoteParam});
  // UserTestModel serviceFetchFormat({required UserTestModel coin});
}
