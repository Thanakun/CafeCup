import 'dart:math';

class UserShopHomePageViewModel {
  final List<String> types = [
    'เมนูเส้น',
    'เมนูตามสั่ง',
    'เมนูของทอด',
    'เมนูของหวาน'
  ];

  final List<String> favoriteType = ['บ่อยสุด', 'ล่าสุด', 'นานสุด'];

  final Random random = Random(1);

  // late Future<List<Map<String,dynamic>>> myInterestedListUser;
  // late Future<List<Map<String, dynamic>>> myFavoriteShopUserTwoItems;
  // late Future<List<Map<String, dynamic>>> myProductsWeekItems;
  // late Future<List<Map<String, dynamic>>> myProductsMonth;
  // late Future<List<Map<String, dynamic>>> myProductsWeek;
  late List<Map<String, dynamic>> myInterestedListUser;
  late List<Map<String, dynamic>> myFavoriteShopUserTwoItems;
  late List<Map<String, dynamic>> myProductsWeekItems;
  late List<Map<String, dynamic>> myProductsMonth;
  late List<Map<String, dynamic>> myProductsWeek;


  List frequentlyEat = [];
  List categoryEatMonth = [];
  List categoryEatWeek = [];
  List filterProductsByTypeMonth = [];
  List filterProductsByTypeWeek = [];
  late String selectedMonthWeek;
  late String selectedCategory;
  late String selectedFavoriteFrequncy;

  UserShopHomePageViewModel() {
    selectedMonthWeek = "month";
    selectedCategory = "เมนูเส้น";
    selectedFavoriteFrequncy = "บ่อยสุด";
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
        "isFavorite": true,
        "favoriteType": _getRandomFavoriteType(),
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

  List<Map<String, dynamic>> filterProductsByType(
    List<Map<String, dynamic>> products,
    String selectedType,
  ) {
    return products.where((item) => item['type'] == selectedType).toList();
  }

  List<Map<String, dynamic>> filterFavoriteItems(
    List<Map<String, dynamic>> favoriteItems,
    bool isFavorite,
    String favoriteType,
  ) {
    return  favoriteItems
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
