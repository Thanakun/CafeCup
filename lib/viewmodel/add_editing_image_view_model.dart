import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/service/shop_service/shop_information_service.dart';

class AddEditImageVM {
  final ShopInformationService _service = ShopInformationService();

  Future<List<String>> shopGetMenuImageFromMinio(
      {required ShopModel shop,
      required String objectName,
      required int maxImageLength}) async {
    List<String> image = [];

    Future<String> getImage(int index) async {
      return await _service.shopGetObjectFromMinio(
        shopId: shop.iId!,
        objectName: "$objectName/$index",
      );
    }

    for (int i = 1; i <= maxImageLength; i++) {
      image.add(await getImage(i));
    }
    return image;
  }
}
