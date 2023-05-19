// To parse this JSON data, do
//
//     final userTestModel = userTestModelFromJson(jsonString);

import 'dart:convert';

List<UserTestModel> userTestModelFromJson(String str) => List<UserTestModel>.from(json.decode(str).map((x) => UserTestModel.fromJson(x)));

String userTestModelToJson(List<UserTestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserTestModel {
    int postId;
    int id;
    String name;
    String email;
    String body;

    UserTestModel({
        required this.postId,
        required this.id,
        required this.name,
        required this.email,
        required this.body,
    });

    factory UserTestModel.fromJson(Map<String, dynamic> json) => UserTestModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };
}
