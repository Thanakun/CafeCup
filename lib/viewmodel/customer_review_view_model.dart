import 'dart:async';

import 'package:coffee_application/model/request/customer_review_request.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/customer/customer_review_service.dart';

class CustomerReviewVM {
  final CustomerReviewService _service = CustomerReviewService();

  late Future<List<ShopModel>> listAllShopFuture;

  Future<void> onUserWhenEnteringReviewPage() async {
    fetchAllShopItem();
  }

  Future<void> fetchAllShopItem() async {
    try {
      listAllShopFuture = _service.getAllShop();
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> onUserSubmitReview(
      {required CustomerReviewRequestBody review}) async {
    try {
      bool isSubmitSuccess = await _service.submitReview(body: review);
      return isSubmitSuccess;
    } catch (_) {
      rethrow;
    }
  }
}
