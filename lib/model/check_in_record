class CheckInRecord {
  final int userId;
  final String shopName;
  final int shopId;
  final String shopLocation;
  final int menuId;
  final String menuName;
  final String menuCategory;
  final DateTime checkInTime;

  CheckInRecord({
    required this.userId,
    required this.shopName,
    required this.shopId,
    required this.shopLocation,
    required this.menuId,
    required this.menuName,
    required this.menuCategory,
    required this.checkInTime,
  });

  factory CheckInRecord.fromJson(Map<String, dynamic> json) {
    return CheckInRecord(
      userId: json['user_id'] as int,
      shopName: json['shop_name'] as String,
      shopId: json['shop_id'] as int,
      shopLocation: json['shop_location'] as String,
      menuId: json['menu_id'] as int,
      menuName: json['menu_name'] as String,
      menuCategory: json['menu_category'] as String,
      checkInTime: DateTime.parse(json['check_in_time'] as String),
    );
  }
}
