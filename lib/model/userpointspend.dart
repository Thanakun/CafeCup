class UsersPointSpendRecord {
  final int userId;
  final int usersPointSpend;
  final DateTime spendTime;

  UsersPointSpendRecord({
    required this.userId,
    required this.usersPointSpend,
    required this.spendTime,
  });

  factory UsersPointSpendRecord.fromJson(Map<String, dynamic> json) {
    return UsersPointSpendRecord(
      userId: json['user_id'] as int,
      usersPointSpend: json['users_point_spend'] as int,
      spendTime: DateTime.parse(json['spend_time'] as String),
    );
  }
}
