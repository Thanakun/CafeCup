import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users {

  int id;
  String username;
  String password;
  String email;
  String gender;
  String age;
  int userPoint;
  String userRole;
  List favoriteList;

  Users(
      {required this.id,
      required this.username,
      required this.password,
      required this.email,
      required this.gender,
      required this.age,
      required this.userPoint,
      required this.userRole,
      required this.favoriteList});

  factory Users.fromJSon(Map<String, dynamic> json) {
    return Users(
        id: json['id'] as int,
        username: json['username'] as String,
        password: json['_password'] as String,
        email: json['email'] as String,
        gender: json['gender'] as String,
        age: json['age'] as String,
        userPoint: json['user_point'] as int,
        userRole: json['user_role'] as String,
        favoriteList: json['favoriteList'] as List<Object>);
  }
}
