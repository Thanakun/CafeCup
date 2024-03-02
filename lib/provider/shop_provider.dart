import 'package:coffee_application/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShopProvider with ChangeNotifier {
  ShopModel _shop = ShopModel(
    menus: [],
    shopImage: [],
    menuImages: [],
    foodImages: [],
    otherImages: [],
    daysOpen: [],
    address: Address(),
    coverImage: null,
    singleSeat: 0,
    doubleSeat: 0,
    largeSeat: 0,
  );

  get shop => _shop;
  get filteredMenus => _filteredMenus;
  List<Menus> _filteredMenus = [];
  // Setters (add validation logic if needed)
  set username(String value) {
    _shop.username = value;
    notifyListeners();
  }

  set password(String value) {
    _shop.password = value;
    notifyListeners();
  }

  set name(String value) {
    _shop.name = value;
    notifyListeners();
  }

  set description(String value) {
    _shop.description = value;
    notifyListeners();
  }

  set address(Address value) {
    _shop.address = value;
    notifyListeners();
  }

  set menus(List<Menus> value) {
    _shop.menus!.clear();
    _filteredMenus.clear();
    _filteredMenus.addAll(value);
    _shop.menus!.addAll(value);
    notifyListeners();
  }

  set coverImage(String? value) {
    // Add validation logic if needed
    _shop.coverImage = value;
    notifyListeners();
  }

  set shopImage(List<String> value) {
    _shop.shopImage!.clear();
    _shop.shopImage!.addAll(value);
    notifyListeners();
  }

  set menuImages(List<String> value) {
    _shop.menuImages!.clear();
    _shop.menuImages!.addAll(value);
    notifyListeners();
  }

  set foodImages(List<String> value) {
    _shop.foodImages!.clear();
    _shop.foodImages!.addAll(value);
    notifyListeners();
  }

  set otherImages(List<String> value) {
    _shop.otherImages!.clear();
    _shop.otherImages!.addAll(value);
    notifyListeners();
  }

  set daysOpen(List<int> value) {
    _shop.daysOpen!.clear();
    _shop.daysOpen!.addAll(value);
    notifyListeners();
  }

  set timeOpen(String value) {
    _shop.timeOpen = value;
    notifyListeners();
  }

  set timeClose(String value) {
    _shop.timeClose = value;
    notifyListeners();
  }

  set singleSeat(int value) {
    _shop.singleSeat = value;
    notifyListeners();
  }

  set doubleSeat(int value) {
    _shop.doubleSeat = value;
    notifyListeners();
  }

  set largeSeat(int value) {
    _shop.largeSeat = value;
    notifyListeners();
  }

  set wifi(bool value) {
    _shop.wifi = value;
    notifyListeners();
  }

  set powerPlugs(bool value) {
    _shop.powerPlugs = value;
    notifyListeners();
  }

  set conferenceRoom(bool value) {
    _shop.conferenceRoom = value;
    notifyListeners();
  }

  set toilet(bool value) {
    _shop.toilet = value;
    notifyListeners();
  }

  set smokingZone(bool value) {
    _shop.smokingZone = value;
    notifyListeners();
  }

  set photoSpots(String value) {
    _shop.photoSpots = value;
    notifyListeners();
  }

  set noise(String value) {
    _shop.noice = value;
    notifyListeners();
  }

  set customerGroup(String value) {
    _shop.customerGroup = value;
    notifyListeners();
  }

  // Other setters for the remaining properties

  // Methods for managing menus and images
  void addMenu(Menus menu) {
    _filteredMenus.add(menu);
    _shop.menus!.add(menu);
    notifyListeners();
  }

  void addShopImage(String image) {
    _shop.shopImage!.add(image);
    notifyListeners();
  }

  void addMenuImage(String image) {
    _shop.menuImages!.add(image);
    notifyListeners();
  }

  void addFoodImage(String image) {
    _shop.foodImages!.add(image);
    notifyListeners();
  }

  void addOtherImage(String image) {
    _shop.otherImages!.add(image);
    notifyListeners();
  }

  void addShopImageAll(List<String> allImages) {
    _shop.shopImage!.clear();
    _shop.shopImage!.addAll(allImages);
    notifyListeners();
  }

  void addMenuImageAll(List<String> allImages) {
    _shop.menuImages!.clear();

    _shop.menuImages!.addAll(allImages);
    notifyListeners();
  }

  void addFoodImageAll(List<String> allImages) {
    _shop.foodImages!.clear();

    _shop.foodImages!.addAll(allImages);
    notifyListeners();
  }

  void addOtherImageAll(List<String> allImages) {
    _shop.otherImages!.clear();

    _shop.otherImages!.addAll(allImages);
    notifyListeners();
  }

  Menus removeMenuAt(int index) {
    Menus menu = _shop.menus![index];
    _shop.menus!.removeAt(index);
    notifyListeners();
    return menu;
  }

  void insertMenuItem(int index, Menus menu) {
    _shop.menus!.insert(index, menu);
    notifyListeners();
  }

  void filterMenusByName(String query) {
    // Update the list of filtered menus based on the name
    _filteredMenus = _shop.menus!
        .where((menu) =>
            (menu.name!.toLowerCase().contains(query.toLowerCase())) ||
            (menu.category!.toLowerCase().contains(query.toLowerCase())) ||
            (menu.price.toString().contains(query)))
        .toList();
    notifyListeners();
  }

  void clearWhenEnteringShopRegister() {
    _shop = ShopModel(
      menus: [],
      shopImage: [],
      menuImages: [],
      foodImages: [],
      otherImages: [],
      daysOpen: [],
      address: Address(),
      coverImage: null,
      singleSeat: 0,
      doubleSeat: 0,
      largeSeat: 0,
    );
  }

  // Other methods for managing images

  @override
  String toString() {
    return '''
    ShopProvider{
      shop: $_shop,
      username: ${_shop.username},
      password: ${_shop.password},
      name: ${_shop.name},
      description: ${_shop.description},
      address: ${_shop.address},
      menus: ${_shop.menus},
      coverImage: ${_shop.coverImage},
      shopImage: ${_shop.shopImage},
      menuImages: ${_shop.menuImages},
      foodImages: ${_shop.foodImages},
      otherImages: ${_shop.otherImages},
      daysOpen: ${_shop.daysOpen},
      timeOpen: ${_shop.timeOpen},
      timeClose: ${_shop.timeClose},
      singleSeat: ${_shop.singleSeat},
      doubleSeat: ${_shop.doubleSeat},
      largeSeat: ${_shop.largeSeat},
      wifi: ${_shop.wifi},
      powerPlugs: ${_shop.powerPlugs},
      conferenceRoom: ${_shop.conferenceRoom},
      toilet: ${_shop.toilet},
      smokingZone: ${_shop.smokingZone},
      photoSpots: ${_shop.photoSpots},
      noise: ${_shop.noice},
      customerGroup: ${_shop.customerGroup},
      filteredMenus: $_filteredMenus,
      // Add other properties as needed
    }
  ''';
  }
}
