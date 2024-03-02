import 'dart:async';

import 'package:coffee_application/model/response/promotion.dart';
import 'package:coffee_application/model/response/promotion_claim_response.dart';
import 'package:coffee_application/service/customer/customer_promotion_service.dart';

class CustomerPromotionVM {
  CustomerPromtionService service = CustomerPromtionService();

  late Future<List<Promotion>> promotionListModel;
  late List<Promotion> promotionList;
  late List<Promotion> filteredPromotions;

  void onUserEnterThePromotionPage() {
    getApiPromotion();
  }

  Future<void> getApiPromotion() async {
    try {
      promotionListModel = service.getCustomerPromotionShopCode();
      promotionList = await promotionListModel;
      filteredPromotions = promotionList;
    } catch (_) {
      rethrow;
    }
  }

  void onCustomerSearchShopByName({required String textFilterShopName}) {
    filteredPromotions = promotionList
        .where((promotion) =>
            promotion.name != null &&
            promotion.name!
                .toLowerCase()
                .contains(textFilterShopName.toLowerCase()))
        .toList();

    // Now, 'filteredPromotions' contains the promotions that match the search criteria
    // You can use this filtered list as needed in your application logic.
  }

  Future<bool> onUserClaimingPromotionCode() async {
    try {
      PromotionClaimResponse result = await service.getCustomerClaimShopCode();
      if (result.claimedCode == null) {
        } else {
        if (result.claimedCode!.iId != null) {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (error) {
      // Handle errors
      rethrow;
    }
  }
}
