class ReviewRecord {
  final int reviewId;
  final int userId;
  final int shopId;
  final String shopImagePath;
  final double starPointPoint;
  final double starPointService;
  final double starPointPlace;
  final String comment;
  final String foodImagePath;
  final DateTime checkInTime;

  ReviewRecord({
    required this.reviewId,
    required this.userId,
    required this.shopId,
    required this.shopImagePath,
    required this.starPointPoint,
    required this.starPointService,
    required this.starPointPlace,
    required this.comment,
    required this.foodImagePath,
    required this.checkInTime,
  });

  factory ReviewRecord.fromJson(Map<String, dynamic> json) {
    return ReviewRecord(
      reviewId: json['review_id'] as int,
      userId: json['user_id'] as int,
      shopId: json['shop_id'] as int,
      shopImagePath: json['shop_image'] as String,
      starPointPoint: json['star_point_food'] as double,
      starPointService: json['star_point_service'] as double,
      starPointPlace: json['star_point_place'] as double,
      comment: json['comment'] as String,
      foodImagePath: json['food_image'] as String,
      checkInTime: DateTime.parse(json['check_in_time'] as String),
    );
  }
}
