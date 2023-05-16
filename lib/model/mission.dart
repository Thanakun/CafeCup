class Mission {
  final int missionId;
  final String missionDescription;
  final String missionName;
  final String missionPoint;
  final DateTime missionTime;

  Mission({
    required this.missionId,
    required this.missionDescription,
    required this.missionName,
    required this.missionPoint,
    required this.missionTime,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      missionId: json['mission_id'] as int,
      missionDescription: json['mission_description'] as String,
      missionName: json['mission_name'] as String,
      missionPoint: json['mission_point'] as String,
      missionTime: DateTime.parse(json['mission_time'] as String),
    );
  }
}
