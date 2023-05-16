import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'user.dart';
import 'package:uri/uri.dart';

class Services {
  static const ROOT = 'http://localhost:80/flutter_application_1/lib/xamppfiles/ConnectSettings.php';

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_users_ACTION = 'ADD_USER';
  static const _UPDATE_users_ACTION = 'UPDATE_USER';
  static const _DELETE_users_ACTION = 'DELETE_USER';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Users>> getusers() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getusers Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Users> list = parseResponse(response.body);
        return list;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: ${e.toString()}');
    }
  }

  static List<Users> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Users>((json) => Users.fromJSon(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> addUsers(String username, String password,String email,String gender,int age,String user_role) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_users_ACTION;
      map['username'] = username;
      map['_password'] = password;
      map['email'] = password;
      map['gender'] = gender;
      map['age'] = age;
      map['user_point'] = 0;
      map['user_role'] = user_role;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addusers Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateusers(
      String userid, String username, String gender,String age) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_users_ACTION;
      map['user_id'] = userid;
      map['username'] = username;
      map['gender'] = gender;
      map['age'] = age;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('updateusers Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an users from Database...
  static Future<String> deleteusers(String userid) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_users_ACTION;
      map['user_id'] = userid;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteuserid Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  


}
