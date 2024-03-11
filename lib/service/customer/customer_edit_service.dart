import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/customer.dart';

class CustomerEditService {
  late final DioApiService _dio;

  CustomerEditService() {
    _dio = DioApiService();
  }

  Future<CustomerModel> getCurrentCustomer() async {
    try {
      final response = await _dio
          .getApiAuth("/customer/getById", {"_id": boxUsers.get(0).id});
      return CustomerModel.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateCustomerTags(
      {required List<Tags> tags}) async {
    try {
      final tagsJson = tags.map((tag) => tag.toJson()).toList();
      final response = await _dio.putAuthApi(
        "/customer/update",
        {
          "tags": tagsJson,
        },
        {
          "_id": boxUsers.get(0).id,
        },
      );
    } catch (_) {
      rethrow;
    }
  }
}
