class Menu {
  final int menuId;
  final String menuName;
  final String menuImagePath;
  final String menuCategory;
  final int menuPrice;
  final int shopId;

  Menu({
    required this.menuId,
    required this.menuName,
    required this.menuImagePath,
    required this.menuCategory,
    required this.menuPrice,
    required this.shopId,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuId: json['menu_id'] as int,
      menuName: json['menu_name'] as String,
      menuImagePath: json['menu_img'] as String,
      menuCategory: json['menu_category'] as String,
      menuPrice: json['menu_price'] as int,
      shopId: json['shop_id'] as int,
    );
  }
}
