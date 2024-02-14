class LoginResponse {
  Customer? customer;
  String? token;

  LoginResponse({this.customer, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Customer {
  int? iId;
  String? username;
  String? password;
  String? name;
  String? gender;
  String? age;
  String? occupation;
  List<Favourites>? favourites;
  List<Tags>? tags;

  Customer(
      {this.iId,
      this.username,
      this.password,
      this.name,
      this.gender,
      this.age,
      this.occupation,
      this.favourites,
      this.tags});

  Customer.fromJson(Map<String, dynamic> json) {
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
    data['_id'] = iId;
    data['username'] = username;
    data['password'] = password;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['occupation'] = occupation;
    if (favourites != null) {
      data['favourites'] = favourites!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return data;
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
