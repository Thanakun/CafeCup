import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/auth-service/auth-service.dart';

class RegisterVM {
  final AuthService _service = AuthService();
  late CustomerProvider customerProvider;
  late ShopProvider shopProvider;
  String userType = "Customer";
  // Private constructor
  RegisterVM({required this.customerProvider, required this.shopProvider});

  void userEnterPage() {
    // _service.mockingShopDataService();
    _service.getUserWhenEnteringTheRegisterPage();
  }

  void signUpFirstPage({required username, required password}) {
    customerProvider.username = username;
    customerProvider.password = password;
  }

  void signUpSecondPage(
      {required name, required age, required gender, required occupation}) {
    customerProvider.name = name;
    customerProvider.age = age;
    customerProvider.gender = gender;
    customerProvider.occupation = occupation;

    print(customerProvider.customer.toString());
  }

  // void signUpThirdPage({required List<Map<String,String>> tags, required favorites}) {
  //   customerProvider.tags = tags;
  //   customerProvider.favourites = favorites;
  //   print(customerProvider.customer.toString());
  // }

  void signUp(
      {required ShopModel shop,
      required CustomerModel customer,
      required String userType}) {
    if (userType == "Shop") {
      // Assuming postShopRegister returns a Future or provides a way to handle the response
      _service.postShopRegister(shop).then((response) {
        // Handle the response, e.g., show a message to the user
      }).catchError((error) {
        // Handle the error, e.g., show an error message
      });
    } else if (userType == "Customer") {
      // Assuming postCustomerRegister returns a Future or provides a way to handle the response
      _service.postCustomerRegister(customerProvider.customer).then((response) {
        // Handle the response, e.g., show a message to the user
      }).catchError((error) {
        // Handle the error, e.g., show an error message
      });
    }
  }

  void onCustomerAddAllTags(List<Map<String, String>> tags) {
    customerProvider.addAllTag(tags);
  }

  void onCustomerAddFavourite(int iShopID) {
    customerProvider.addFavourite(iShopID);
  }
}
