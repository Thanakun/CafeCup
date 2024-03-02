import 'dart:async';

import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/response/promotion.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/customer/customer_shop_service.dart';

class CustomerOnShopVM {
  CustomerOnShopService service = CustomerOnShopService();
  late final Future<ShopModel> shopModel;
  late final Future<List<Promotion>> promotionListModel;
  late final Future<CustomerModel> customerModel;
  late final Future<List<ReviewModel>> reviewList;

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
}
