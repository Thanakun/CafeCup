import 'dart:typed_data';

import 'package:coffee_application/model/response/customer_response.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/shop_service/shop_information_service.dart';
import 'package:image_picker/image_picker.dart';

class ShopInformationVM {
  final ShopInformationService _service = ShopInformationService();
  late final Future<ShopModel> shopModel;
  late final Future<List<CustomerModelResponse>> customerList;
  late final Future<List<ReviewModel>> reviewList;
  late Future<String> shopCoverImage;
  late Future<List<String>> menuShopImage;

  int maxImageLength = 5;

  void onUserEnterShopInformation() {
    getShopInformation();
    getReviewListByShopID();
    getCustomerListByShopID();
  }

  Future<void> getShopInformation() async {
    shopModel = _service.getShopByShopId();
  }

  void onUserAddEditShopMenu(
      {required int shopId, required List<Menus> menu}) async {
    _service.addMenuToShopId(menu, shopId);
  }

  void onUserAddImagesShop({
    required int shopId,
    required List<String> shopImages,
    required List<String> menuImages,
    required List<String> foodImages,
    required List<String> otherImages,
  }) async {
    _service.addImagesToShopId(
        shopId: shopId,
        shopImages: shopImages,
        menuImages: menuImages,
        foodImages: foodImages,
        otherImages: otherImages);
  }

  Future onUserAddCoverImageShop({
    required int shopId,
    required String coverImage,
    required XFile coverImageXfile,
  }) async {
    _service.addCoverImageToShopId(shopId, coverImage, coverImageXfile);
  }

  void onUserAddTimeOpenAndClose({
    required List<int> openDays,
    required String openTime,
    required String closeTime,
  }) {
    _service.addTimeOpenAndCloseToShopId(openDays, openTime, closeTime);
  }

  Future<String> shopGetImagePathNetworkFromMinio({
    required int shopId,
    required String objectName,
  }) async {
    shopCoverImage =
        _service.shopGetObjectFromMinio(shopId: shopId, objectName: objectName);

    return shopCoverImage;
  }

  Future<List<String>> shopGetMenuImageFromMinio({
    required ShopModel shop,
    required String objectName,
  }) async {
    List<String> image = [];

    Future<String> getImage(int index) async {
      return await _service.shopGetObjectFromMinio(
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
      return await _service.shopGetObjectFromMinio(
        shopId: shop.iId!,
        objectName: "$objectName/$index",
      );
    }

    switch (objectName) {
      case "shopimages":
        for (int i = 1; i <= shop.shopImage!.length; i++) {
          image.add(await getImage(i));
        }
        Future.value(image);
        break;
      case "menuimages":
        for (int i = 1; i <= shop.menuImages!.length; i++) {
          image.add(await getImage(i));
        }
        Future.value(image);
        break;
      case "foodimages":
        for (int i = 1; i <= shop.foodImages!.length; i++) {
          image.add(await getImage(i));
        }
        Future.value(image);
        break;
      case "otherimages":
        for (int i = 1; i <= shop.otherImages!.length; i++) {
          image.add(await getImage(i));
        }
        Future.value(image);
        break;
    }

    return image;
  }

  void onUserAddShopDescription({required String description}) {
    _service.addDescriptionToShopId(description);
  }

  void onUserAddShopName({required String name}) {
    _service.addShopNameToShopId(name);
  }

  Future<List<CustomerModelResponse>> getCustomerListByShopID() async {
    customerList = _service.getCustomerListByShopID();
    return customerList;
  }

  Future<List<ReviewModel>> getReviewListByShopID() async {
    reviewList = _service.getReviewListByShopID();
    return reviewList;
  }
}
