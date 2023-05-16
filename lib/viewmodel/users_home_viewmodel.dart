import 'package:flutter/cupertino.dart';
import 'dart:math';

class UserHomePageViewModel {
  final List<String> types = ['เมนูเส้น','เมนูตามสั่ง','เมนูของทอด','เมนูของหวาน'];

  final Random random = Random(1);

  late List<Map<String, dynamic>> myFavoriteShopUserTwoItems;
  late List<Map<String, dynamic>> myProductsWeekItems;
  late List<Map<String, dynamic>> myProductsMonth;
  late List<Map<String, dynamic>> myProductsWeek;

  UserHomePageViewModel() {
    myFavoriteShopUserTwoItems = _generateFavoriteShopItems(2);
    myProductsWeekItems = _generateProductWeekItems(4);
    myProductsMonth = _generateProductMonthItems(100);
    myProductsWeek = _generateProductWeekItems(100);
  }

  List<Map<String, dynamic>> _generateFavoriteShopItems(int count) {
    List<Map<String, dynamic>> items = [];
    for (int index = 0; index < count; index++) {
      items.add({
        "id": index,
        "name": "TwoItemsFavorite $index",
        "type": _getRandomType(),
        "date": DateTime.now(),
      });
    }
    return items;
  }

  List<Map<String, dynamic>> _generateProductWeekItems(int count) {
    List<Map<String, dynamic>> items = [];
    for (int index = 0; index < count; index++) {
      items.add({
        "id": index,
        "name": "ProductWeek $index",
        "type": _getRandomType(),
      });
    }
    return items;
  }

  List<Map<String, dynamic>> _generateProductMonthItems(int count) {
    List<Map<String, dynamic>> items = [];
    for (int index = 0; index < count; index++) {
      items.add({
        "idMonth": index,
        "name": "ProductMonth $index",
        "type": _getRandomType(),
      });
    }
    return items;
  }


  String getCategoryType(String type, String selectedCategory) {
    switch (selectedCategory) {
      case "เมนูเส้น":
        return type = "noodle";
      case "เมนูตามสั่ง":
        return type = "a la carte";
      case "เมนูของทอด":
        return type = "fried";
      case "เมนูของหวาน":
        return type = "dessert";
      default:
        return "";
    }
  }

  String _getRandomType() {
    return types[random.nextInt(types.length)];
  }

  // UserHomePageViewModel(required this.myFavoriteShopUserTwoItems,);
  String _selectedMonthWeek = "month";

  String getSelectedMonthWeek() {
    print(_selectedMonthWeek);
    return _selectedMonthWeek;
  }

  void updateSelectedMonthWeek(String selected) {
    if (_selectedMonthWeek != selected) {
      _selectedMonthWeek = selected;
      // print("$_selectedMonthWeek Hello");
      // onMonthWeekChanged();
    }
  }

  void updateSelectedFrequencyEat(String selected) {
    if (_selectedMonthWeek != selected) {
      _selectedMonthWeek = selected;
      // print("$_selectedMonthWeek Hello");
      // onMonthWeekChanged();
    }
  }

  List onMonthWeekChanged() {
    if (_selectedMonthWeek == "month") {
      // update myProductsMonth
      return myProductsMonth;
    } else {
      // update myProductsWeek
      return myProductsWeek;
    }
  }
}
  // List Category
  
  // String isselectedMonthWeek(){
    
  // };

  // String setSelectedMonthWeek(String select){
  //   _selectedMonthWeek = select;
  //   return 
  // };
