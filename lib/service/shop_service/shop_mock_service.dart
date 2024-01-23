// import 'package:coffee_application/model/menu.dart';
// import 'package:coffee_application/model/review_record.dart';
// import 'package:coffee_application/model/shop_promotion_menu.dart';
// import 'package:coffee_application/model/shop_reward_menu.dart';
// import 'package:coffee_application/service/shop_service/shop_interface.dart';

// class ShopPageMockService implements ShopPageServiceInterface {
//   @override
//   Future<List<Menu>> fetchMenuOfShopWithId(int id) async {
//     // Mock data for fetchMenuOfShopWithId
//     return List.generate(5, (index) {
//       return Menu(
//         menuId: index + 1,
//         menuName: 'Menu Item ${index + 1}',
//         menuImagePath: 'path/to/image$index.jpg',
//         menuCategory: 'Category $index',
//         menuPrice: (index + 1) * 10,
//         shopId: id,
//       );
//     });
//   }

//   @override
//   Future<List<ShopPromotionMenu>> fetchMenuPromotionOfShopWithId(int id) async {
//     // Mock data for fetchMenuPromotionOfShopWithId
//     return List.generate(3, (index) {
//       return ShopPromotionMenu(
//         promotionId: index + 1,
//         promotionName: 'Promotion ${index + 1}',
//         promtionImagePath: 'path/to/promo_image$index.jpg',
//         promotionCategory: 'Promo Category $index',
//         promotionPrice: (index + 1) * 5,
//         shopId: id,
//       );
//     });
//   }

//   @override
//   Future<List<ShopRewardMenu>> fetchMenuRewardOfShopWithId(int id) async {
//     // Mock data for fetchMenuRewardOfShopWithId
//     return List.generate(2, (index) {
//       return ShopRewardMenu(
//         shopRewardMenuId: index + 1,
//         shopRewardMenuName: 'Reward Menu ${index + 1}',
//         shopRewardMenuImagePath: 'path/to/reward_image$index.jpg',
//         shopRewardMenuCategory: 'Reward Category $index',
//         shopRewardMenuPoint: (index + 1) * 20,
//         shopId: id,
//       );
//     });
//   }

//   @override
//   Future<List<ReviewRecord>> fetchReviewRecordWithShopId(int id) async {
//     // Mock data for fetchReviewRecordWithShopId
//     return List.generate(4, (index) {
//       return ReviewRecord(
//         reviewId: index + 1,
//         userId: index + 101,
//         shopId: id,
//         shopImagePath: 'path/to/shop_image.jpg',
//         starPointPoint: 4.5,
//         starPointService: 4.0,
//         starPointPlace: 4.8,
//         comment: 'Great experience!',
//         foodImagePath: 'path/to/food_image$index.jpg',
//         checkInTime: DateTime.now().subtract(Duration(days: index)),
//       );
//     });
//   }
// }
