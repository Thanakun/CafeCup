import 'package:hive/hive.dart';

part 'users.g.dart';

@HiveType(typeId: 1)
class Users {
  Users({required this.id});
  @HiveField(0)
  int id;
}
