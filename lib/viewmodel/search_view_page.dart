import 'package:flutter_application_1/model/shop.dart';
import 'package:flutter_application_1/service/search_service/search_shop_interface.dart';
import 'package:flutter_application_1/service/search_service/search_shop_mock_service.dart';

class SearchViewModel {
  bool isCheckedTheFilterTime = false;
  DateTime isOpenCurrentTime = DateTime.now();
  Future<List<Shop>>? listAllShopFuture;

  List<Shop>? listFilterShopFuture;
  SearchShopServiceInterface service = SearchShopMockService();

  Future<void> onUserSearchItemFilter(String searchString) async {
    if (searchString == '') {
      listFilterShopFuture = await listAllShopFuture;
      // return;
    }

    if (searchString == null) {
      listFilterShopFuture = await listAllShopFuture;
    } else {
      List<Shop>? allShops = await listAllShopFuture;
      if (allShops != null) {
        listFilterShopFuture = allShops.where((shop) {
          bool matchesSearchString =
              shop.shopName.toLowerCase().contains(searchString.toLowerCase());
          if (isCheckedTheFilterTime) {
            bool isOpen = shop.shopOpenTime.isBefore(isOpenCurrentTime);
            bool isClose = shop.shopCloseTime.isAfter(isOpenCurrentTime);
            // print(isCheckedTheFilterTime);
            return matchesSearchString && isOpen && isClose;
          } else {
            // print("${isCheckedTheFilterTime} hi");

            return matchesSearchString;
          }
        }).toList();
      }
    }
  }

  Future<void> fetchAllShopItem() async {
    listAllShopFuture = service.fetchItemByKeyword();
    List<Shop>? result = await listAllShopFuture;
    listFilterShopFuture = result;
    print(listFilterShopFuture?.length);
  }
}
