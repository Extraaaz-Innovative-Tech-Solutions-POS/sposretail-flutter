import 'dart:convert';

class MenuItem {
  int itemId;
  String itemName;
  String foodType;
  double price;
  double discount;
  int restaurantId;
  String image;
  int categoryId;
  String categoryName;

  MenuItem({
    required this.itemId,
    required this.itemName,
    required this.foodType,
    required this.price,
    required this.discount,
    required this.restaurantId,
    required this.image,
    required this.categoryId,
    required this.categoryName,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      itemId: json['item_id'],
      itemName: json['item_name'],
      foodType: json['food_type'],
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
      restaurantId: json['restaurant_id'],
      image: json['Image'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'item_name': itemName,
      'food_type': foodType,
      'price': price,
      'discount': discount,
      'restaurant_id': restaurantId,
      'Image': image,
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }
}

List<MenuItem> menuItemsFromJson(String str) {
  dynamic decoded = json.decode(str);

  if (decoded is List) {
    return List<MenuItem>.from(decoded.map((x) => MenuItem.fromJson(x)));
  } else if (decoded is Map<String, dynamic>) {
    return [MenuItem.fromJson(decoded)];
  } else {
    throw Exception("Invalid JSON format");
  }
}

String menuItemsToJson(List<MenuItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
