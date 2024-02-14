import 'package:coffee_application/model/customer.dart';
import 'package:flutter/material.dart';

class CustomerProvider with ChangeNotifier {
  final CustomerModel _customer = CustomerModel();

  get customer => _customer;

  // Setters (add validation logic if needed)
  set username(String value) {
    _customer.username = value;
    notifyListeners();
  }

  set password(String value) {
    _customer.password = value;
    notifyListeners();
  }

  set name(String value) {
    _customer.name = value;
    notifyListeners();
  }

  set gender(String value) {
    _customer.gender = _convertStringToGender(value);
    notifyListeners();
  }

  set age(String value) {
    _customer.age = value;
    notifyListeners();
  }

  set occupation(String value) {
    _customer.occupation = value;
    notifyListeners();
  }

  set tags(List<Tags> value) {
    _customer.tags = value;
    notifyListeners();
  }

  set favourites(List<Favourites> value) {
    _customer.favourites = value;
    notifyListeners();
  }

  // Methods for managing favourites and tags
  void addFavourite(int shopId) {
    _customer.favourites!.add(Favourites(
      iShopID: shopId,
    ));
    notifyListeners();
  }

  void addTag(int key, String value) {
    _customer.tags!.add(Tags(
      key: key,
      value: value,
    ));
    notifyListeners();
  }

  void addAllTag(List<Map<String, String>> listTag) {
    _customer.tags ??= [];

    for (var e in listTag) {
      print("e");
      print(e);
      Tags tag = Tags(key: int.parse(e["key"]!), value: e["value"]);
      _customer.tags!.add(tag);
    }
    notifyListeners();
  }

  void removeAtWithIndexTag(int index) {
    _customer.tags!.removeAt(index);
    notifyListeners();
  }

  void insertTagsWithIndexItem(int index, int key, String value) {
    _customer.tags!.insert(
        index,
        Tags(
          key: key,
          value: value,
        ));
    notifyListeners();
  }

  Gender? _convertStringToGender(String value) {
    switch (value.toLowerCase()) {
      case 'male':
        return Gender.MALE;
      case 'female':
        return Gender.FEMALE;
      default:
        return null; // Handle unknown values appropriately
    }
  }
}
