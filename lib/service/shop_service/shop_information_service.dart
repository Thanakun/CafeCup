import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/response/customer_response.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';

class ShopInformationService {
  late final DioApiService _dio;

  ShopInformationService() {
    _dio = DioApiService();
  }

  Future<ShopModel> getShopByShopId() async {
    try {
      final response =
          await _dio.getApiAuth("/shop/getById/", {"_id": boxUsers.get(0).id});
      return ShopModel.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<ReviewModel>> getReviewListByShopID() async {
    try {
      final response = await _dio
          .getApiAnalytics("/review/get", {"_shopId": boxUsers.get(0).id});
      List<dynamic> responseData = response;
      List<ReviewModel> reviewList =
          responseData.map((data) => ReviewModel.fromJson(data)).toList();

      return reviewList;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CustomerModelResponse>> getCustomerListByShopID() async {
    try {
      final response = await _dio
          .getApiAuth("/customer/get", {"_shopId": boxUsers.get(0).id});
      List<dynamic> responseData = response;
      List<CustomerModelResponse> customerList = responseData
          .map((data) => CustomerModelResponse.fromJson(data))
          .toList();

      return customerList;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> addMenuToShopId(List<Menus> menus) async {
    try {
      List<Map<String, dynamic>> menusJsonList =
          menus.map((menu) => menu.toJson()).toList();

      final response = await _dio.putAuthApi("/shop/update",
          {"menus": menusJsonList}, {"_id": boxUsers.get(0).id});

      print(response);
      return true;
    } catch (_) {
      return false;
      // rethrow;
    }
  }

  Future<bool> addImagesToShopId(
      {required List<String> shopImages,
      required List<String> menuImages,
      required List<String> foodImages,
      required List<String> otherImages}) async {
    try {
      final response = await _dio.putAuthApi("/shop/update", {
        "shopImages": shopImages,
        "menuImages": menuImages,
        "foodImages": foodImages,
        "otherImages": otherImages
      }, {
        "_id": boxUsers.get(0).id
      });

      print(response);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> addCoverImageToShopId(String coverImage) async {
    try {
      final response = await _dio.putAuthApi("/shop/update",
          {"coverImage": coverImage}, {"_id": boxUsers.get(0).id});
      print(response);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> addTimeOpenAndCloseToShopId(
      List<int> dayOpens, String timeOpen, String timeClose) async {
    try {
      final response = await _dio.putAuthApi(
          "/shop/update",
          {"daysOpen": dayOpens, "timeOpen": timeOpen, "timeClose": timeClose},
          {"_id": boxUsers.get(0).id});
      print(response);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> addDescriptionToShopId(String description) async {
    try {
      final response = await _dio.putAuthApi("/shop/update",
          {"description": description}, {"_id": boxUsers.get(0).id});
      print(response);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> addShopNameToShopId(String shopName) async {
    try {
      final response = await _dio.putAuthApi(
          "/shop/update", {"name": shopName}, {"_id": boxUsers.get(0).id});
      print(response);
      return true;
    } catch (_) {
      return false;
    }
  }
}
