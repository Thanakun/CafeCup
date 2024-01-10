class Menu {
  int menuID;
  String name;
  String category;
  String description;
  int price;
  String image;

  Menu({
    required this.menuID,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuID: json['menuID'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}
