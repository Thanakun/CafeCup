import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users {
  // static Future <bool?> get_signin() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return pref.getBool("Sign-in");
  // }
  // static Future set_signin(bool sign_in) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setString("id", users.fromJSon());

  // }

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
        userPoint: json['userPoint'] as int,
        userRole: json['userRole'] as String,
        favoriteList: json['favoriteList'] as List<Object>);
  }
}
