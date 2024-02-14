import 'package:coffee_application/model/shop.dart';
import 'package:flutter/material.dart';

class ShopProvider with ChangeNotifier {

  ShopModel _shop = ShopModel();

  get shop => _shop;
  String _username = '';
  String _password = '';
  String _name = '';
  String _description = '';
  final Map<String, dynamic> _address = {};
  final List<Map<String, dynamic>> _menus = [];
  final String _coverImage = '';
  final List<String> _shopImage = [];
  final List<String> _menuImages = [];
  final List<String> _foodImages = [];
  final List<String> _otherImages = [];
  final List<int> _daysOpen = [];
  final String _timeOpen = '';
  final String _timeClose = '';
  final int _singleSeat = 0;
  final int _doubleSeat = 0;
  final int _largeSeat = 0;
  final bool _wifi = false;
  final bool _powerPlugs = false;
  final bool _conferenceRoom = false;
  final bool _toilet = false;
  final bool _smokingZone = false;
  final String _photoSpots = 'FEW';
  final String _noise = 'QUIET';
  final String _customerGroup = 'STUDENT';

  // Getters
  String get username => _username;
  String get password => _password;
  String get name => _name;
  String get description => _description;
  Map<String, dynamic> get address => _address;
  List<Map<String, dynamic>> get menus => _menus;
  String get coverImage => _coverImage;
  List<String> get shopImage => _shopImage;
  List<String> get menuImages => _menuImages;
  List<String> get foodImages => _foodImages;
  List<String> get otherImages => _otherImages;
  List<int> get daysOpen => _daysOpen;
  String get timeOpen => _timeOpen;
  String get timeClose => _timeClose;
  int get singleSeat => _singleSeat;
  int get doubleSeat => _doubleSeat;
  int get largeSeat => _largeSeat;
  bool get wifi => _wifi;
  bool get powerPlugs => _powerPlugs;
  bool get conferenceRoom => _conferenceRoom;
  bool get toilet => _toilet;
  bool get smokingZone => _smokingZone;
  String get photoSpots => _photoSpots;
  String get noise => _noise;
  String get customerGroup => _customerGroup;

  // Setters (add validation logic if needed)
  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  // Other setters for the remaining properties

  // Methods for managing menus and images
  void addMenu(Map<String, dynamic> menu) {
    _menus.add(menu);
    notifyListeners();
  }

  void addShopImage(String image) {
    _shopImage.add(image);
    notifyListeners();
  }

  // Other methods for managing images

  // Other methods for managing properties
}
