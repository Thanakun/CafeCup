import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/response/customer_response.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/shop_service/shop_information_service.dart';

class ShopInformationVM {
  final ShopInformationService _service = ShopInformationService();
  late final Future<ShopModel> shopModel;
  late final Future<List<CustomerModelResponse>> customerList;
  late final Future<List<ReviewModel>> reviewList;

  void onUserEnterShopInformation() {
    getShopInformation();
    getReviewListByShopID();
    getCustomerListByShopID();
  }

  Future<void> getShopInformation() async {
    shopModel = _service.getShopByShopId();
  }

  void onUserAddEditShopMenu({required List<Menus> menu}) async {
    _service.addMenuToShopId(menu);
  }

  void onUserAddImagesShop(
      {required List<String> shopImages,
      required List<String> menuImages,
      required List<String> foodImages,
      required List<String> otherImages}) async {
    _service.addImagesToShopId(
        shopImages: shopImages,
        menuImages: menuImages,
        foodImages: foodImages,
        otherImages: otherImages);
  }

  void onUserAddCoverImageShop({
    required String coverImage,
  }) {
    _service.addCoverImageToShopId(coverImage);
  }

  void onUserAddTimeOpenAndClose({
    required List<int> openDays,
    required String openTime,
    required String closeTime,
  }) {
    _service.addTimeOpenAndCloseToShopId(openDays, openTime, closeTime);
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
