enum Gender { MALE, FEMALE }

class CustomerModel {
  String? username;
  String? password;
  String? name;
  Gender? gender;
  String? age;
  String? occupation;
  List<Favourites>? favourites;
  List<Tags>? tags;

  CustomerModel(
      {this.username,
      this.password,
      this.name,
      this.gender,
      this.age,
      this.occupation,
      this.favourites,
      this.tags});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    name = json['name'];
    if (json['gender'] != null) {
      gender = Gender.values.firstWhere(
        (e) => e.toString().split('.').last == json['gender'],
        orElse: () => Gender.MALE, // Default value if not found
      );
    }
    age = json['age'];
    occupation = json['occupation'];
    if (json['favourites'] != null) {
      favourites = <Favourites>[];
      json['favourites'].forEach((v) {
        favourites!.add(new Favourites.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    if (gender != null) {
      data['gender'] = gender.toString().split('.').last;
    }
    data['age'] = this.age;
    data['occupation'] = this.occupation;
    if (this.favourites != null) {
      data['favourites'] = this.favourites!.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
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

  set setGender(Gender value) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_shopID'] = this.iShopID;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
