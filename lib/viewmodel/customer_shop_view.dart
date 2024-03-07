import 'dart:async';

import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/response/customer_response.dart';
import 'package:coffee_application/model/response/promotion.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/customer/customer_shop_service.dart';

class CustomerOnShopVM {
  CustomerOnShopService service = CustomerOnShopService();
  late final Future<ShopModel> shopModel;
  late final Future<List<Promotion>> promotionListModel;
  late final Future<List<CustomerModelResponse>> customerModel;
  late final Future<List<ReviewModel>> reviewList;
  late Future<String> shopCoverImage;
  late Future<List<String>> shopHomeImage;
  late Future<List<String>> shopMenuImage;
  late Future<List<String>> shopFoodImage;
  late Future<List<String>> shopOtherImage;

  void onUserEnterTheShopPage({required int shopID}) {
    onUserEnterTheShopAddTheReachPage(shopID: shopID);
    getApiPromotion(shopID: shopID);
    getShopById(shopID: shopID);
    getCurrentCustomer();
    getReviewListByShopID(shopID: shopID);
  }

  Future<void> getShopById({required int shopID}) async {
    shopModel = service.getShopByShopId(id: shopID);
  }

  Future<void> getApiPromotion({required int shopID}) async {
    promotionListModel = service.getCustomerPromotionShopCode(shopID: shopID);
  }

  Future<void> onUserEnterTheShopAddTheReachPage({required int shopID}) async {
    service.postReachCustomerEnterShop(shopID: shopID);
  }

  Future<void> getCurrentCustomer() async {
    customerModel = service.getCurrentCustomer();
  }

  Future<void> getReviewListByShopID({required int shopID}) async {
    reviewList = service.getReviewListByShopID(shopID: shopID);
  }

  Future<String> shopGetImagePathNetworkFromMinio({
    required int shopId,
    required String objectName,
  }) async {
    shopCoverImage =
        service.shopGetObjectFromMinio(shopId: shopId, objectName: objectName);
    return shopCoverImage;
  }

  Future<List<String>> shopGetMenuImageFromMinio({
    required ShopModel shop,
    required String objectName,
  }) async {
    List<String> image = [];

    Future<String> getImage(int index) async {
      return await service.shopGetObjectFromMinio(
        shopId: shop.iId!,
        objectName: "$objectName/$index",
      );
    }

    for (int i = 1; i <= shop.menus!.length; i++) {
      image.add(await getImage(i));
    }
    return image;
  }

  Future<List<String>> shopGetImageShop({
    required ShopModel shop,
    required String objectName,
  }) async {
    List<String> image = [];

    Future<String> getImage(int index) async {
      return await service.shopGetObjectFromMinio(
        shopId: shop.iId!,
        objectName: "$objectName/$index",
      );
    }

    switch (objectName) {
      case "shopimages":
        for (int i = 1; i <= shop.shopImage!.length; i++) {
          image.add(await getImage(i));
        }
        shopHomeImage = Future.value(image);
        break;
      case "menuimages":
        for (int i = 1; i <= shop.menuImages!.length; i++) {
          image.add(await getImage(i));
        }
        shopHomeImage = Future.value(image);
        break;
      case "foodimages":
        for (int i = 1; i <= shop.foodImages!.length; i++) {
          image.add(await getImage(i));
        }
        shopFoodImage = Future.value(image);
        break;
      case "otherimages":
        for (int i = 1; i <= shop.otherImages!.length; i++) {
          image.add(await getImage(i));
        }
        shopOtherImage = Future.value(image);
        break;
    }

    return image;
  }
}
