class CustomerModelResponse {
  int? reviewPoints;
  int? iId;
  String? username;
  String? password;
  String? name;
  String? gender;
  String? age;
  String? occupation;
  List<Tags>? tags;
  List<int>? favourites;

  CustomerModelResponse(
      {this.reviewPoints,
      this.iId,
      this.username,
      this.password,
      this.name,
      this.gender,
      this.age,
      this.occupation,
      this.tags,
      this.favourites});

  CustomerModelResponse.fromJson(Map<String, dynamic> json) {
    reviewPoints = json['reviewPoints'];
    iId = json['_id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    occupation = json['occupation'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    if (json['favourites'] != null) {
      favourites = <int>[];
      json['favourites'].forEach((v) {
        favourites!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewPoints'] = reviewPoints;
    data['_id'] = iId;
    data['username'] = username;
    data['password'] = password;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['occupation'] = occupation;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (favourites != null) {
      data['favourites'] = favourites!.map((v) => v).toList();
    }
    return data;
  }
}

class Tags {
  int? key;
  String? value;
  String? sId;

  Tags({this.key, this.value, this.sId});

  Tags.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    data['_id'] = sId;
    return data;
  }
}
