class ShopPromotion {
  final int promotionId;
  final String promotionName;
  final String promtionImagePath;
  final String promotionCategory;
  final int promotionPrice;
  final int shopId;

  ShopPromotion({
    required this.promotionId,
    required this.promotionName,
    required this.promtionImagePath,
    required this.promotionCategory,
    required this.promotionPrice,
    required this.shopId,
  });

  factory ShopPromotion.fromJson(Map<String, dynamic> json) {
    return ShopPromotion(
      promotionId: json['pmt_id'] as int,
      promotionName: json['pmt_name'] as String,
      promtionImagePath: json['pmt_img'] as String,
      promotionCategory: json['pmt_category'] as String,
      promotionPrice: json['pmt_price'] as int,
      shopId: json['shop_id'] as int,
    );
  }
}
