enum Gender { MALE, FEMALE }

class CustomerModel {
  int? iId;
  int? reviewPoints;
  String? username;
  String? password;
  String? name;
  String? gender;
  String? age;
  String? occupation;
  List<Favourites>? favourites;
  List<Tags>? tags;

  CustomerModel(
      {this.reviewPoints,
      this.iId,
      this.username,
      this.password,
      this.name,
      this.gender,
      this.age,
      this.occupation,
      this.favourites,
      this.tags});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    reviewPoints = json['reviewPoints'];
    iId = json['_id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    occupation = json['occupation'];
    if (json['favourites'] != null) {
      favourites = <Favourites>[];
      json['favourites'].forEach((v) {
        favourites!.add(Favourites.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
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
    if (favourites != null) {
      data['favourites'] = favourites!.map((v) => v.toJson()).toList();
    } else {
      data['favourites'] = [];
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  set setUsername(String value) {
    username = value;
  }

  set setPassword(String value) {
    password = value;
  }

  set setName(String value) {
    name = value;
  }

  set setGender(String value) {
    gender = value;
  }

  set setAge(String value) {
    age = value;
  }

  set setOccupation(String value) {
    occupation = value;
  }

  set setTags(List<Tags> value) {
    tags = value;
  }

  set setFavourites(List<Favourites> value) {
    favourites = value;
  }

  //print Info
  @override
  String toString() {
    return 'CustomerModel{username: $username, password: $password, name: $name, gender: $gender, age: $age, occupation: $occupation, favourites: $favourites, tags: $tags}';
  }
}

class Favourites {
  int? iShopID;

  Favourites({this.iShopID});

  Favourites.fromJson(Map<String, dynamic> json) {
    iShopID = json['_shopID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_shopID'] = iShopID;
    return data;
  }
}

class Tags {
  int? key;
  String? value;

  Tags({this.key, this.value});

  Tags.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
