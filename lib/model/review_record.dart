class ReviewRecord {
  final int userId;
  final double starPoint;
  final int shopId;
  final String shopName;
  final String menuId;
  final String menuName;
  final String comment;
  final String foodImage;
  final DateTime checkInTime;

  ReviewRecord({
    required this.userId,
    required this.starPoint,
    required this.shopId,
    required this.shopName,
    required this.menuId,
    required this.menuName,
    required this.comment,
    required this.foodImage,
    required this.checkInTime,
  });

  factory ReviewRecord.fromJson(Map<String, dynamic> json) {
    return ReviewRecord(
      userId: json['user_id'] as int,
      starPoint: json['star_point'] as double,
      shopId: json['shop_id'] as int,
      shopName: json['shop_name'] as String,
      menuId: json['menu_id'] as String,
      menuName: json['menu_name'] as String,
      comment: json['comment'] as String,
      foodImage: json['food_image'] as String,
      checkInTime: DateTime.parse(json['check_in_time'] as String),
    );
  }
}
