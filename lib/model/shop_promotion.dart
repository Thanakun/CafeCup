class ShopPromotion {
  final int shopId;
  final int shopPromotionId;
  final int shopPromotionPointRequired;
  final String shopPromotionDescription;
  final int shopPromotionPrice;
  final int shopPromotionExpiredDate;

  ShopPromotion({
    required this.shopId,
    required this.shopPromotionId,
    required this.shopPromotionPointRequired,
    required this.shopPromotionDescription,
    required this.shopPromotionPrice,
    required this.shopPromotionExpiredDate,
  });

  factory ShopPromotion.fromJson(Map<String, dynamic> json) {
    return ShopPromotion(
      shopId: json['shop_id'] as int,
      shopPromotionId: json['shop_promotion_id'] as int,
      shopPromotionPointRequired: json['shop_promotion_point_required'] as int,
      shopPromotionDescription: json['shop_promotion_description'] as String,
      shopPromotionPrice: json['shop_promotion_price'] as int,
      shopPromotionExpiredDate: json['shop_promotion_expired_date'] as int,
    );
  }

   Map<String, dynamic> toJson() => {
        "shopId": shopId,
        "shopPromotionId" : shopPromotionId
    };
}
