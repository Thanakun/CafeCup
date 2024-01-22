class CustomerModel {
  int? id;
  String? username;
  String? password;
  String? name;
  String? gender;
  String? age;
  String? occupation;
  List<int>? favorites; // array of ShopId
  List<Tag>? tags;

  CustomerModel(
      {this.id,
      this.username,
      this.password,
      this.name,
      this.gender,
      this.age,
      this.occupation,
      this.favorites,
      this.tags});

  CustomerModel.toJson() {}
}

class Tag {
  int? key;
  String? value;
}
