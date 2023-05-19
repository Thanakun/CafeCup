import 'package:flutter_application_1/model/shop.dart';

import 'package:flutter/material.dart';

abstract class SearchShopServiceInterface {
  Future<List<Shop>> fetchItemByKeyword();
}
