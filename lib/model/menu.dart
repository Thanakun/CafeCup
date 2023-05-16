class Menu {
  final int menuId;
  final String menuName;
  final String menuCategory;
  final int shopId;

  Menu({
    required this.menuId,
    required this.menuName,
    required this.menuCategory,
    required this.shopId,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuId: json['menu_id'] as int,
      menuName: json['menu_name'] as String,
      menuCategory: json['menu_category'] as String,
      shopId: json['shop_id'] as int,
    );
  }
}
