import 'dart:typed_data';

import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/data/network/minio_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/response/customer_response.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:image_picker/image_picker.dart';

class ShopInformationService {
  late final DioApiService _dio;
  late final MinioService _minio;

  ShopInformationService() {
    _dio = DioApiService();
    _minio = MinioService();
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
      final response = await _dio.getApiAuth("/customer/get");
      List<dynamic> responseData = response;
      List<CustomerModelResponse> customerList = responseData
          .map((data) => CustomerModelResponse.fromJson(data))
          .toList();

      return customerList;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> addMenuToShopId(List<Menus> menus, int shopId) async {
    try {
      List<Map<String, dynamic>> menusJsonList =
          menus.map((menu) => menu.toJson()).toList();

      final response = await _dio.putAuthApi("/shop/update",
          {"menus": menusJsonList}, {"_id": boxUsers.get(0).id});

      List<String> menuimagePath = [];

      for (var menu in menus) {
        menuimagePath.add(menu.image!);
      }

      await _uploadImagesToMinIO("Shop${shopId.toString()}", "menus",
          menuimagePath, Helper.pathListToXFileList(menuimagePath));
      print(response);
      return true;
    } catch (_) {
      return false;
      // rethrow;
    }
  }

  Future<bool> addImagesToShopId({
    required int shopId,
    required List<String> shopImages,
    required List<String> menuImages,
    required List<String> foodImages,
    required List<String> otherImages,
  }) async {
    try {
      Map<String, dynamic> requestBody = {};

      if (shopImages.isNotEmpty) {
        requestBody["shopImages"] = shopImages;
        await _uploadImagesToMinIO("Shop${shopId.toString()}", "shopImages",
            shopImages, Helper.pathListToXFileList(shopImages));
      }
      if (menuImages.isNotEmpty) {
        requestBody["menuImages"] = menuImages;
        await _uploadImagesToMinIO("Shop${shopId.toString()}", "menuImages",
            menuImages, Helper.pathListToXFileList(menuImages));
      }
      if (foodImages.isNotEmpty) {
        requestBody["foodImages"] = foodImages;

        await _uploadImagesToMinIO("Shop${shopId.toString()}", "foodImages",
            foodImages, Helper.pathListToXFileList(foodImages));
      }
      if (otherImages.isNotEmpty) {
        requestBody["otherImages"] = otherImages;

        await _uploadImagesToMinIO("Shop${shopId.toString()}", "otherImages",
            otherImages, Helper.pathListToXFileList(otherImages));
      }

      final response = await _dio.putAuthApi("/shop/update", requestBody, {
        "_id": boxUsers.get(0).id,
      });

      // Upload images to MinIO for each category

      print(response);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _uploadImagesToMinIO(
    String bucketName,
    String category,
    List<String> imagePaths,
    List<XFile> xFiles,
  ) async {
    // Construct object names based on the category, index, and file names
    List<String> objectNames = List.generate(
      imagePaths.length,
      (index) => '${category.toLowerCase()}/${index + 1}',
    );

    await _minio.uploadMultipleFiles(
      bucketName: bucketName,
      objectNames: objectNames,
      filePaths: imagePaths,
      xfiles: xFiles,
    );
  }

  Future<String> shopGetObjectFromMinio({
    required int shopId,
    required objectName,
  }) async {
    try {
      return await _minio.getObjectItem(
        bucketName: "Shop${shopId.toString()}",
        objectName: objectName,
      );
    } catch (e) {
      return "";
    }
  }

  Future<String> addCoverImageToShopId(
      int shopId, String coverImage, XFile coverImageXfile) async {
    try {
      final response = await _dio.putAuthApi("/shop/update",
          {"coverImage": coverImage}, {"_id": boxUsers.get(0).id});
      return await _minio.uploadFilePathObject(
        bucketName: "Shop${shopId.toString()}",
        objectName: "coverImage",
        filePath: coverImage,
      );
    } catch (_) {
      print(_);
      return "";
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
