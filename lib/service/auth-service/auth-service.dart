import 'package:coffee_application/data/network/minio_service.dart';
import 'package:coffee_application/model/response/register_response.dart';
import 'package:coffee_application/model/response/validate_response.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:dio/dio.dart';
import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late final DioApiService _dio;
  late final MinioService _minio;
  late final SharedPreferences prefs;
  String userType = "Customer";

  AuthService() {
    _dio = DioApiService();
    _minio = MinioService();
  }

  Future mockingShopDataService() async {
    final prefs = await SharedPreferences.getInstance();
    final data = await _dio.getAuthApiWithParam("/shop/inserttest");
  }

  Future mockingCustomerDataService() async {
    final data = await _dio.postAuthApi("/customer/inserttest", []);
  }

  Future<ValidateTokenResponse> validateToken() async {
    try {
      final data = await _dio.getAuthApiWithParam("/validateToken");
      final response = ValidateTokenResponse.fromJson(data);

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> logout() async {
    try {
      _dio.clearCookies();
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      if (userType == "Customer") {
        final data = await _dio.postAuthApi(
            "/customer/login", {"username": username, "password": password});
        // final data = await dio.get(
        //   "http://172.31.48.1:3002/livez",
        // );
        // "/customer/login", {"username": username, "password": password});
        print("data");
        print(data);
      } else if (userType == "Shop") {
        final data = await _dio.postAuthApi(
            "/shop/login", {"username": username, "password": password});
        print("data");
        print(data);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> postShopRegister(ShopModel shop) async {
    try {
      final data = await _dio.postAuthApi("/shop/register", shop.toJson());
      RegisterResponse reponseData = RegisterResponse.fromJson(data);
      if (shop.coverImage != null) {
        _minio.uploadFilePathObject(
          bucketName: "Shop${reponseData.iId!.toString()}",
          objectName: "coverImage",
          filePath: shop.coverImage!,
        );
      }
      if (shop.shopImage != null) {
        _uploadImagesToMinIO("Shop${reponseData.iId!.toString()}", "shopimages",
            shop.shopImage!, Helper.pathListToXFileList(shop.shopImage!));
      }
      if (shop.foodImages != null) {
        _uploadImagesToMinIO(
          "Shop${reponseData.iId!.toString()}",
          "foodimages",
          shop.foodImages!,
          Helper.pathListToXFileList(shop.foodImages!),
        );
      }
      if (shop.menuImages != null) {
        _uploadImagesToMinIO(
          "Shop${reponseData.iId!.toString()}",
          "menuimages",
          shop.menuImages!,
          Helper.pathListToXFileList(shop.menuImages!),
        );
      }
      if (shop.otherImages != null) {
        _uploadImagesToMinIO(
          "Shop${reponseData.iId!.toString()}",
          "otherimages",
          shop.menuImages!,
          Helper.pathListToXFileList(shop.menuImages!),
        );
      }
      if (shop.menus != null || shop.menus!.isNotEmpty) {
        List<String> menuimagePath = [];

        for (var menu in shop.menus!) {
          menuimagePath.add(menu.image!);
        }

        await _uploadImagesToMinIO("Shop${shop.iId.toString()}", "menus",
            menuimagePath, Helper.pathListToXFileList(menuimagePath));
        _uploadImagesToMinIO("Shop${reponseData.iId!.toString()}", "menus",
            menuimagePath, Helper.pathListToXFileList(menuimagePath));
      }

      return true;
      // print(data);
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

  Future<bool> postCustomerRegister(CustomerModel customer) async {
    try {
      print(customer.toJson());
      final data =
          await _dio.postAuthApi("/customer/register", customer.toJson());
      print(data);
      return true;
    } catch (e) {
      print("e");
      print(e);
      return false;
    }
  }

  Future<void> getUserWhenEnteringTheRegisterPage() async {
    try {
      final data = await _dio.getApiAuth("/shop/get");
    } catch (_) {
      rethrow;
    }
  }
}
