import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/service/customer/customer_edit_service.dart';

class CustomerEditVM {
  final CustomerEditService _service = CustomerEditService();
  late final Future<CustomerModel> customerModel;

  Future<void> getCurrentCustomer() async {
    customerModel = _service.getCurrentCustomer();
  }

  Future<void> onUserTapUpdateCustomerTag({required List<Tags> tags}) async {
    await _service.updateCustomerTags(tags: tags);
  }
}
