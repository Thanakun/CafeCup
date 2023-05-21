class CheckInRecord {
  final int checkinId;
  final int userId;
  final String shopName;
  final int shopId;
  final DateTime checkinDate;
  final DateTime checkinTime;
  final int reviewId;

  CheckInRecord({
    required this.checkinId,
    required this.userId,
    required this.shopName,
    required this.shopId,
    required this.checkinDate,
    required this.checkinTime, 
    required this.reviewId,
  });

  factory CheckInRecord.fromJson(Map<String, dynamic> json) {
    return CheckInRecord(
      checkinId: json['checkin_id'] as int,
      userId: json['user_id'] as int,
      shopName: json['shop_name'] as String,
      shopId: json['shop_id'] as int,
      checkinDate: DateTime.parse(json['checkin_date'] as String),
      checkinTime: DateTime.parse(json['checkin_time'] as String),
      reviewId: json['review_id'] as int,
    );
  }
}
