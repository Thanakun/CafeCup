class Food {
  final int foodShopId;
  final String foodName;
  final String foodCategory;
  final int menuId;

  Food({
    required this.foodShopId,
    required this.foodName,
    required this.foodCategory,
    required this.menuId,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      foodShopId: json['food_shop_id'] as int,
      foodName: json['food_name'] as String,
      foodCategory: json['food_category'] as String,
      menuId: json['menu_id'] as int,
    );
  }
}
