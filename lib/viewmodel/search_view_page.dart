import 'package:flutter_application_1/model/shop.dart';
import 'package:flutter_application_1/service/search_service/search_shop_interface.dart';
import 'package:flutter_application_1/service/search_service/search_shop_mock_service.dart';

class SearchViewModel {
  Future<List<Shop>>? listAllShopFuture;

  Future<List<Shop>>? listFilterShopFuture;
  SearchShopServiceInterface service = SearchShopMockService();

  Future<void> onUserSearchItemFilter(String searchString) async {
    if (searchString == '') {
      listFilterShopFuture = listAllShopFuture;
      // return;
    }

    if (searchString == null) {
      listFilterShopFuture = listAllShopFuture;
    } else {
      List<Shop>? allShops = await listAllShopFuture;
      if (allShops != null) {
        listFilterShopFuture = Future.value(allShops
            .where((shop) => shop.shopName
                .toLowerCase()
                .contains(searchString.toLowerCase()))
            .toList());
      }
    }
  }

  Future<void> fetchAllShopItem() async {
    listAllShopFuture = service.fetchItemByKeyword();
    listFilterShopFuture = listAllShopFuture;
  }
}
