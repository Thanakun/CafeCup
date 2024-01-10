class ShopRewardMenu {
  final int shopRewardMenuId;
  final String shopRewardMenuName;
  final String shopRewardMenuImagePath;
  final String shopRewardMenuCategory;
  final int shopRewardMenuPoint;
  final int shopId;

  ShopRewardMenu({
    required this.shopRewardMenuId,
    required this.shopRewardMenuName,
    required this.shopRewardMenuImagePath,
    required this.shopRewardMenuCategory,
    required this.shopRewardMenuPoint,
    required this.shopId,
  });

  factory ShopRewardMenu.fromJson(Map<String, dynamic> json) {
    return ShopRewardMenu(
      shopRewardMenuId: json['spm_id'] as int,
      shopRewardMenuName: json['spm_name'] as String,
      shopRewardMenuImagePath: json['spm_img'] as String,
      shopRewardMenuCategory: json['spm_category'] as String,
      shopRewardMenuPoint: json['spm_points'] as int,
      shopId: json['shop_id'] as int,
    );
  }
}
