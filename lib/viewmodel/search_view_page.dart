import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/search_service/search_shop_service.dart';

class SearchCustomerVM {
  SearchCustomerService service = SearchCustomerService();
  late Future<List<ShopModel>> listAllFilterShop;
  List filterMapList = [];
  late Future<List<ShopModel>> nextPageShopsFuture;
  late List<ShopModel> shopsBeloaded;

  void onUserSearchByNameAndFilterShop(
      {required String searchString, required int pageToLoad}) async {
    Map<String, dynamic> filters = {"name": searchString};

    for (var e in filterMapList) {
      switch (e) {
        case "largeSeat":
          filters["largeSeat"] = true;
          break;
        case "wifi":
          filters["wifi"] = true;
          break;
        case "powerPlugs":
          filters["powerPlugs"] = true;
          break;
        case "conferenceRoom":
          filters["conferenceRoom"] = true;
          break;
        case "toilet":
          filters["toilet"] = true;
          break;
        case "smokingZone":
          filters["smokingZone"] = true;
          break;
        case "QUITE":
          filters["noice"] = "QUITE";
          break;
        case "NORMAL":
          filters["noice"] = "NORMAL";
          break;
        case "STUDENT":
          filters["customerGroup"] = "NORMAL";
          break;
        case "OFFICE_WORKER":
          filters["customerGroup"] = "OFFICE_WORKER";
          break;
        case "TOURIST":
          filters["customerGroup"] = "TOURIST";
          break;
        case "DIGITAL_NORMAD":
          filters["customerGroup"] = "DIGITAL_NORMAD";
          break;
        case "TAKEAWAY":
          filters["customerGroup"] = "TAKEAWAY";
          break;
      }
    }
    listAllFilterShop = service
        .getShopByShopNameAndTag(filters, {"page": pageToLoad, "pageSize": 20});
    shopsBeloaded = await listAllFilterShop;
  }

  Future<bool> onLoadingMorePage(
      {required String searchString, required int nextPageToLoad}) async {
    try {
      Map<String, dynamic> filters = {"name": searchString};

      for (var e in filterMapList) {
        switch (e) {
          case "largeSeat":
            filters["largeSeat"] = true;
            break;
          case "wifi":
            filters["wifi"] = true;
            break;
          case "powerPlugs":
            filters["powerPlugs"] = true;
            break;
          case "conferenceRoom":
            filters["conferenceRoom"] = true;
            break;
          case "toilet":
            filters["toilet"] = true;
            break;
          case "smokingZone":
            filters["smokingZone"] = true;
            break;
          case "QUITE":
            filters["noice"] = "QUITE";
            break;
          case "NORMAL":
            filters["noice"] = "NORMAL";
            break;
          case "STUDENT":
            filters["customerGroup"] = "NORMAL";
            break;
          case "OFFICE_WORKER":
            filters["customerGroup"] = "OFFICE_WORKER";
            break;
          case "TOURIST":
            filters["customerGroup"] = "TOURIST";
            break;
          case "DIGITAL_NORMAD":
            filters["customerGroup"] = "DIGITAL_NORMAD";
            break;
          case "TAKEAWAY":
            filters["customerGroup"] = "TAKEAWAY";
            break;
        }
      }

      nextPageShopsFuture = service.getShopByShopNameAndTag(
          filters, {"page": nextPageToLoad, "pageSize": 20});
      shopsBeloaded.addAll(await nextPageShopsFuture);
      return true;
    } catch (_) {
      //TODO MAYBE RETHROW
      return false;
    }
  }

  void onUserTapRemoveFilter({required String filter}) {
    filterMapList.remove(filter);
  }

  void onUserTapAddFilter({required String filter}) {
    filterMapList.add(filter);
  }

  void onUserClearFilter() {
    filterMapList.clear();
  }

  Future<String> shopGetImagePathNetworkFromMinio({
    required int shopId,
    required String objectName,
  }) async {
    return service.shopGetObjectFromMinio(
        shopId: shopId, objectName: objectName);

    // return shopCoverImage;
  }
}
