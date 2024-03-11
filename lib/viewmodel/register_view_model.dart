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
  List<int> daysOpen = [];
  // Private constructor
  RegisterVM({required this.customerProvider, required this.shopProvider});

  void userEnterPage() {
    // _service.mockingShopDataService();
    _service.getUserWhenEnteringTheRegisterPage();
  }

  void signUpFirstPage({required username, required password}) {
    if (userType == "Shop") {
      shopProvider.username = username;
      shopProvider.password = password;
    } else if (userType == "Customer") {
      customerProvider.username = username;
      customerProvider.password = password;
    }
  }

  void signUpShopPage(
      {required String nameShop,
      required String descriptionShop,
      required String selectedProvince,
      required String selectedDistrict,
      required String selectedSubDistrict,
      required String addressDetail}) {
    shopProvider.name = nameShop;
    shopProvider.description = descriptionShop;

    Address address = Address(
      country: "Thailand",
      province: selectedProvince,
      district: selectedDistrict,
      subDistrict: selectedSubDistrict,
      addressText: addressDetail,
    );
    shopProvider.address = address;
  }

  void shopSignUpForthPage({
    required String customerGroup,
    required int singleSeat,
    required int doubleSeat,
    required int largeSeat,
    required Map<String, bool> facilities,
    required Map<String, bool> cafeTakePhotoSpot,
    required Map<String, bool> cafeShopStyle,
    required Map<String, bool> cafeNoiseLevel,
  }) {
    shopProvider.customerGroup = customerGroup;
    shopProvider.singleSeat = singleSeat;
    shopProvider.doubleSeat = doubleSeat;
    shopProvider.largeSeat = largeSeat;
    shopProvider.wifi = facilities["ไวไฟ (wifi)"]!;
    shopProvider.powerPlugs = facilities["ปลั๊ก"]!;
    shopProvider.conferenceRoom = facilities["ห้องประชุม"]!;
    shopProvider.toilet = facilities["ห้องน้ำ"]!;
    shopProvider.smokingZone = facilities["ที่สูบบุหรี่"]!;
    shopProvider.noise = cafeNoiseLevel["ห้ามใช้เสียง"]! ? "QUITE" : "NORMAL";
    shopProvider.photoSpots = cafeTakePhotoSpot.entries
        .firstWhere((entry) => entry.value,
            orElse: () => const MapEntry("", false))
        .key;
  }

  void shopSignUpThirdPage(
      {required List<bool> dateOpen,
      required String openTime,
      required String closeTime}) {
    daysOpen.clear();
    for (int i = 0; i < dateOpen.length; i++) {
      if (dateOpen[i]) {
        // Adding (i + 1) when the day is open
        daysOpen.add(i + 1);
      }
    }
    shopProvider.daysOpen = daysOpen;
    shopProvider.timeOpen = openTime;
    shopProvider.timeClose = closeTime;
    print(shopProvider.toString());
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

  Future<bool> signUp(
      {required ShopModel shop,
      required CustomerModel customer,
      required String userType}) async {
    try {
      if (userType == "Shop") {
        // Assuming postShopRegister returns a Future or provides a way to handle the response
        return _service.postShopRegister(shopProvider.shop);
      } else if (userType == "Customer") {
        // Assuming postCustomerRegister returns a Future or provides a way to handle the response
        return _service.postCustomerRegister(customerProvider.customer);
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  void onCustomerAddAllTags(List<Map<String, String>> tags) {
    customerProvider.addAllTag(tags);
  }

  void onCustomerAddFavourite(int iShopID) {
    customerProvider.addFavourite(iShopID);
  }
}
