import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/customer.dart';
import 'package:flutter_application_1/model/shop.dart';
import 'package:flutter_application_1/service/shop_register_service/register_service.dart';

class RegisterVM extends ChangeNotifier {
  final RegisterService _service = RegisterService();

  void userEnterPage() {
    // _service.mockingShopDataService();
    _service.getUserWhenEnteringTheRegisterPage();
  }

  void signUp(ShopModel shop, CustomerModel customer, String userType) {
    if (userType == "Shop") {
      _service.postShopRegister(shop);
    } else if (userType == "Customer") {
      _service.postCustomerRegister(customer);
    }

    // print(response.body);
  }
}
