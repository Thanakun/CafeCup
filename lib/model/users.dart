import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class users{

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
  int user_point;
  String users_role;

  users({required this.id,required this.username,required this.password,required this.email,required this.gender,required this.age,required this.user_point,required this.users_role});

  factory users.fromJSon(Map<String,dynamic> json){
    return users(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['_password'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      age: json['age'] as String,
      user_point: json['user_point'] as int,
      users_role: json['user_role'] as String,
    );
  }
  



}