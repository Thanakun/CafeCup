import 'dart:async';

import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/customer/customer_shop_service.dart';

class CustomerOnShopVM {
  CustomerOnShopService service = CustomerOnShopService();
  late final Future<ShopModel> shopModel;

  Future<void> getShopById({required int id}) async {
    shopModel = service.getShopByShopId(id: id);
  }
}
