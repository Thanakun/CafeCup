import 'dart:math';
import 'package:intl/intl.dart';

class UserShopHomePageViewModel {
  final List<String> types = [
    'เมนูเส้น',
    'เมนูตามสั่ง',
    'เมนูของทอด',
    'เมนูของหวาน'
  ];

  final List<String> favoriteType = ['บ่อยสุด', 'ล่าสุด', 'นานสุด'];

  final Random random = Random(1);

  late List<Map<String, dynamic>> myListShopHasPromotion;
  late List<Map<String, dynamic>> myInterestedListUser;
  late List<Map<String, dynamic>> myFavoriteShopUserTwoItems;
  late List<Map<String, dynamic>> myProductsWeekItems;
  late List<Map<String, dynamic>> myProductsMonth;
  late List<Map<String, dynamic>> myProductsWeek;
  late List<Map<String, dynamic>> myListThatMightLike;

  // List listThatMightLikeView = [];
  // List listShopHasPromotion = [];
  List frequentlyEat = [];
  List<Map<String, dynamic>> categoryEatMonth = [];
  List<Map<String, dynamic>> categoryEatWeek = [];
  List filterProductsByTypeMonth = [];
  List filterProductsByTypeWeek = [];
  late String selectedMonthWeek;
  late String selectedCategory;
  late String selectedFavoriteFrequncy;

  UserShopHomePageViewModel() {
    selectedMonthWeek = "month";
    selectedCategory = "เมนูเส้น";
    selectedFavoriteFrequncy = "บ่อยสุด";
    myListShopHasPromotion = _generateListShopHasPromotion(20);
    myListThatMightLike = _generateListThatMightLike(20);
    myFavoriteShopUserTwoItems = _generateFavoriteShopItems(2);
    myProductsWeekItems = _generateProductWeekItems(4);
    myProductsMonth = _generateProductMonthItems(100);
    myProductsWeek = _generateProductWeekItems(100);
  }

  List<Map<String, dynamic>> _generateListShopHasPromotion(int count) {
    List<Map<String, dynamic>> items = [];
    for (int index = 0; index < count; index++) {
      items.add({
        "id": index,
        "name": "TwoItemsFavorite $index",
        "shoptype": _getRandomType(),
        // TODO: Not accurate how to integration on this list may using the score to be implement.
        "PromotionId": 1,
        "isMightLikeParam": random.nextDouble(),
        "isFavorite": true,
        "favoriteType": _getRandomFavoriteType(),
      });
    }
    print(items);
    // items.sort((a, b) => b['PromotionId'].compareTo(a['isMightLikeParam']));
    return items;
  }

  List<Map<String, dynamic>> _generateFavoriteShopItems(int count) {
    List<Map<String, dynamic>> items = [];
    for (int index = 0; index < count; index++) {
      items.add({
        "id": index,
        "name": "TwoItemsFavorite $index",
        "shoptype": _getRandomType(),
        "isFavorite": true,
        "favoriteType": _getRandomFavoriteType(),
      });
    }
    return items;
  }

  List<Map<String, dynamic>> _generateListThatMightLike(int count) {
    List<Map<String, dynamic>> items = [];
    for (int index = 0; index < count; index++) {
      items.add({
        "id": index,
        "name": "TwoItemsFavorite $index",
        "shoptype": _getRandomType(),
        // TODO: Not accurate how to integration on this list may using the score to be implement.
        "isMightLikeParam": random.nextDouble(),
        "isFavorite": true,
        "favoriteType": _getRandomFavoriteType(),
      });
    }
    items
        .sort((a, b) => b['isMightLikeParam'].compareTo(a['isMightLikeParam']));
    return items;
  }

  List<Map<String, dynamic>> _generateProductWeekItems(int count) {
    Random random = Random();
    List<Map<String, dynamic>> items = [];
    DateTime currentDate = DateTime.now();

    for (int index = 0; index < count; index++) {
      DateTime weekStartDate =
          currentDate.subtract(Duration(days: random.nextInt(365)));
      items.add({
        "id": index,
        "name": "ProductWeeksasasasasasasas $index",
        "shoptype": _getRandomType(),
        "date": DateFormat('yyyy-MM-dd').format(weekStartDate),
        "unitSale": random.nextInt(991) + 10,
      });
    }
    items.sort((a, b) => b['unitSale'].compareTo(a['unitSale']));
    return items;
  }

  List<Map<String, dynamic>> _generateProductMonthItems(int count) {
    Random random = Random();
    List<Map<String, dynamic>> items = [];

    DateTime currentDate = DateTime.now();
    int currentMonth = currentDate.month;
    int currentYear = currentDate.year;

    for (int index = 0; index < count; index++) {
      int month = (currentMonth - index) % 12;
      int yearOffset = ((currentMonth - index) / 12).floor();
      int year = currentYear - yearOffset;
      DateTime monthStartDate = DateTime(year, month);
      items.add({
        "id": index,
        "name": "ProductMonth $index",
        "shoptype": _getRandomType(),
        "date": DateFormat('yyyy-MM-dd').format(monthStartDate),
        "unitSale": random.nextInt(991) + 10,
      });
    }
    items.sort((a, b) => b['unitSale'].compareTo(a['unitSale']));
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

  List<Map<String, dynamic>> filterProductsByType(
    List<Map<String, dynamic>> products,
    String selectedType,
  ) {
    print("{$selectedType} อันนี้");
    print(products);
    return products.where((item) => item['shoptype'] == selectedType).toList();
  }

  List<Map<String, dynamic>> filterFavoriteItems(
    List<Map<String, dynamic>> favoriteItems,
    bool isFavorite,
    String favoriteType,
  ) {
    return favoriteItems
        .where((item) =>
            item['isFavorite'] == isFavorite &&
            item['favoriteType'] == favoriteType)
        .toList();
  }

  String _getRandomType() {
    return types[random.nextInt(types.length)];
  }

  String _getRandomFavoriteType() {
    return favoriteType[random.nextInt(favoriteType.length)];
  }
}
