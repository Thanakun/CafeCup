// import 'package:flutter_application_1/model/menu.dart';
// import 'package:flutter_application_1/service/shop_service/shop_mock_service.dart';
// import 'package:flutter_application_1/service/shop_service/shop_service.dart';


// class ShopViewModel{

//   //Service
//   final ShopPageMockService service = ShopPageMockService();
  
//   late List<String> categoryListOfShop;
//   late List<Menu> menuListOfShop;

// void getMenuToListOfShopWithIdShop(List<Menu> menuList,int shopId) {
//     // Mock data for groups
//     menuListOfShop = service.fetchMenuOfShopWithId(shopId);

//     // Mock data for menus
//     menuListOfShop = [
//       Menu(
//         menuId: 1,
//         // menuName: 'Menu Item 1',
//         menuImagePath: 'path/to/image1.jpg',
//         menuCategory: 'Appetizers',
//         menuPrice: 10.99,
//         shopId: 1,
//       ),
//       // ... (other menu items)
//     ];

//     // Assign menus to the shop based on shopId and group
//     menuListOfShop = menuListOfShop
//         .where((menu) => menu.shopId == shopId)
//         .toList();
//   }



// }