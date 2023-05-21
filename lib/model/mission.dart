class Mission {
  final int shopId;
  final int userId;
  final int missionId;
  final String missionName;
  final String missionDescription;
  final String missionPoint;
  final String missionStatus;
  final DateTime missionTime;

  Mission({
    required this.shopId,
    required this.userId,
    required this.missionId,
    required this.missionName,
    required this.missionDescription,
    required this.missionPoint,
    required this.missionStatus,
    required this.missionTime,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      shopId: json['shop_id'] as int,
      userId: json['user_id'] as int,
      missionId: json['mission_id'] as int,
      missionName: json['mission_name'] as String,
      missionDescription: json['mission_description'] as String,
      missionPoint: json['mission_point'] as String,
      missionStatus: json['mission_status'] as String,
      missionTime: DateTime.parse(json['mission_time'] as String),
    );
  }
}
