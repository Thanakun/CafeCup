import 'package:flutter/material.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/shop_register_service/register_service.dart';

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
