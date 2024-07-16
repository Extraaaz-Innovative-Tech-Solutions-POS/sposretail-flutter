// To parse this JSON data, do
//
//     final varientModel = varientModelFromJson(jsonString);

import 'dart:convert';

VarientModel varientModelFromJson(String str) =>
    VarientModel.fromJson(json.decode(str));

String varientModelToJson(VarientModel data) => json.encode(data.toJson());

class VarientModel {
  bool success;
  String message;
  List<ModifierGroup> modifierGroups;

  VarientModel({
    required this.success,
    required this.message,
    required this.modifierGroups,
  });

  factory VarientModel.fromJson(Map<String, dynamic> json) => VarientModel(
        success: json["success"],
        message: json["message"],
        modifierGroups: List<ModifierGroup>.from(
            json["modifierGroups"].map((x) => ModifierGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "modifierGroups":
            List<dynamic>.from(modifierGroups.map((x) => x.toJson())),
      };
}

class ModifierGroup {
  int id;
  int userId;
  String userName;
  String name;
  String description;
  int type;
  int restaurantId;
  int itemsCount;
  int modifiersCount;
  DateTime createdAt;
  DateTime updatedAt;
  List<Modifier> modifiers;

  ModifierGroup({
    required this.id,
    required this.userId,
    required this.userName,
    required this.name,
    required this.description,
    required this.type,
    required this.restaurantId,
    required this.itemsCount,
    required this.modifiersCount,
    required this.createdAt,
    required this.updatedAt,
    required this.modifiers,
  });

  factory ModifierGroup.fromJson(Map<String, dynamic> json) => ModifierGroup(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        restaurantId: json["restaurant_id"],
        itemsCount: json["items_count"],
        modifiersCount: json["modifiers_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        modifiers: List<Modifier>.from(
            json["modifiers"].map((x) => Modifier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "name": name,
        "description": description,
        "type": type,
        "restaurant_id": restaurantId,
        "items_count": itemsCount,
        "modifiers_count": modifiersCount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "modifiers": List<dynamic>.from(modifiers.map((x) => x.toJson())),
      };
}

class Modifier {
  int id;
  int userId;
  String name;
  dynamic shortName;
  dynamic description;
  var price;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Modifier({
    required this.id,
    required this.userId,
    required this.name,
    required this.shortName,
    required this.description,
    required this.price,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) => Modifier(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        shortName: json["short_name"],
        description: json["description"],
        price: json["price"],
        restaurantId: json["restaurant_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "short_name": shortName,
        "description": description,
        "price": price,
        "restaurant_id": restaurantId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
