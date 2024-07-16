// To parse this JSON data, do
//
//     final selectItems = selectItemsFromJson(jsonString);

import 'dart:convert';

SelectItems selectItemsFromJson(String str) =>
    SelectItems.fromJson(json.decode(str));

String selectItemsToJson(SelectItems data) => json.encode(data.toJson());

class SelectItems {
  bool success;
  String message;
  List<int> ids;
  List<ItemsAll> itemsAll;

  SelectItems({
    required this.success,
    required this.message,
    required this.ids,
    required this.itemsAll,
  });

  factory SelectItems.fromJson(Map<String, dynamic> json) => SelectItems(
        success: json["success"],
        message: json["message"],
        ids: List<int>.from(json["ids"].map((x) => x)),
        itemsAll: List<ItemsAll>.from(
            json["itemsAll"].map((x) => ItemsAll.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "ids": List<dynamic>.from(ids.map((x) => x)),
        "itemsAll": List<dynamic>.from(itemsAll.map((x) => x.toJson())),
      };
}

class ItemsAll {
  int id;
  String itemName;
  String price;
  var discount;
  var categoryId;
  int restaurantId;

  InventoryStatus inventoryStatus;
  dynamic associatedItem;
  String? image;
  int? varients;
  int? taxPercentage;
  DateTime createdAt;
  DateTime updatedAt;

  ItemsAll({
    required this.id,
    required this.itemName,
    required this.price,
    required this.discount,
    required this.categoryId,
    required this.restaurantId,
    //  required this.foodType,
    required this.inventoryStatus,
    required this.associatedItem,
    required this.image,
    required this.varients,
    required this.taxPercentage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemsAll.fromJson(Map<String, dynamic> json) => ItemsAll(
        id: json["id"],
        itemName: json["item_name"],
        price: json["price"],
        discount: json["discount"],
        categoryId: json["category_id"],
        restaurantId: json["restaurant_id"],
        //   foodType: foodTypeValues.map[json["food_type"]]!,
        inventoryStatus: inventoryStatusValues.map[json["inventory_status"]]!,
        associatedItem: json["associated_item"],
        image: json["Image"],
        varients: json["varients"],
        taxPercentage: json["tax_percentage"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "price": price,
        "discount": discount,
        "category_id": categoryId,
        "restaurant_id": restaurantId,
        //  "food_type": foodTypeValues.reverse[foodType],
        "inventory_status": inventoryStatusValues.reverse[inventoryStatus],
        "associated_item": associatedItem,
        "Image": image,
        "varients": varients,
        "tax_percentage": taxPercentage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum InventoryStatus { INSTOCK }

final inventoryStatusValues = EnumValues({"instock": InventoryStatus.INSTOCK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
