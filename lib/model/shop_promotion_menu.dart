class ShopPromotionMenu {
  final int promotionId;
  final String promotionName;
  final String promtionImagePath;
  final String promotionCategory;
  final int promotionPrice;
  final int shopId;

  ShopPromotionMenu({
    required this.promotionId,
    required this.promotionName,
    required this.promtionImagePath,
    required this.promotionCategory,
    required this.promotionPrice,
    required this.shopId,
  });

  factory ShopPromotionMenu.fromJson(Map<String, dynamic> json) {
    return ShopPromotionMenu(
      promotionId: json['pmt_id'] as int,
      promotionName: json['pmt_name'] as String,
      promtionImagePath: json['pmt_img'] as String,
      promotionCategory: json['pmt_category'] as String,
      promotionPrice: json['pmt_price'] as int,
      shopId: json['shop_id'] as int,
    );
  }
}
