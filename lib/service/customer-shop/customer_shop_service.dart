import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/model/shop.dart';

class CustomerShopService {
  late final DioApiService _dio;

  CustomerShopService() {
    _dio = DioApiService();
  }

  Future<List<ShopModel>> getAllShop() async {
    try {
      // final response = await _dio.getGetApiResponse(
      //     "/shop/get"); // Use _dio.get instead of _dio.getGetApiResponse

      // // Check if the response status code is successful (2xx)
      // if (response.statusCode == 200) {
      //   // Assuming the response data is a list of shops
      //   List<dynamic> responseData = response.data;

      //   // Convert the list of data to a list of ShopModel instances
      //   List<ShopModel> shops =
      //       responseData.map((data) => ShopModel.fromJson(data)).toList();

      //   return shops;
      // } else {
      //   // Handle non-successful response (e.g., display an error message)
      //   // print("Error: ${response.statusCode}");
      //   return []; // Return an empty list or throw an exception based on your requirement
      // }
      return [];
    } catch (error) {
      // Handle DioError or any other exception that might occur
      print("Error: $error");
      rethrow;
    }
  }
}
