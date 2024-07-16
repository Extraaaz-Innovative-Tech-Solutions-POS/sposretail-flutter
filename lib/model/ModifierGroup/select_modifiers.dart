// To parse this JSON data, do
//
//     final selectModifier = selectModifierFromJson(jsonString);

import 'dart:convert';

SelectModifier selectModifierFromJson(String str) =>
    SelectModifier.fromJson(json.decode(str));

String selectModifierToJson(SelectModifier data) => json.encode(data.toJson());

class SelectModifier {
  bool success;
  String message;
  List<int> ids;
  List<ModifiersAll> modifiersAll;

  SelectModifier({
    required this.success,
    required this.message,
    required this.ids,
    required this.modifiersAll,
  });

  factory SelectModifier.fromJson(Map<String, dynamic> json) => SelectModifier(
        success: json["success"],
        message: json["message"],
        ids: List<int>.from(json["ids"].map((x) => x)),
        modifiersAll: List<ModifiersAll>.from(
            json["modifiersAll"].map((x) => ModifiersAll.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "ids": List<dynamic>.from(ids.map((x) => x)),
        "modifiersAll": List<dynamic>.from(modifiersAll.map((x) => x.toJson())),
      };
}

class ModifiersAll {
  int id;
  int userId;
  String name;
  dynamic type;
  dynamic shortName;
  var description;
  String price;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  ModifiersAll({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.shortName,
    required this.description,
    required this.price,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory ModifiersAll.fromJson(Map<String, dynamic> json) => ModifiersAll(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        type: json["type"],
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
        "type": type,
        "short_name": shortName,
        "description": description,
        "price": price,
        "restaurant_id": restaurantId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
