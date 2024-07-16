// To parse this JSON data, do
//
//     final showModifier = showModifierFromJson(jsonString);

import 'dart:convert';

ShowModifier showModifierFromJson(String str) =>
    ShowModifier.fromJson(json.decode(str));

String showModifierToJson(ShowModifier data) => json.encode(data.toJson());

class ShowModifier {
  bool success;
  String message;
  List<ShowModifierData> data;

  ShowModifier({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ShowModifier.fromJson(Map<String, dynamic> json) => ShowModifier(
        success: json["success"],
        message: json["message"],
        data: List<ShowModifierData>.from(
            json["data"].map((x) => ShowModifierData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShowModifierData {
  int id;
  int userId;
  String name;
  dynamic type;
  var shortName;
  var description;
  String price;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Pivot pivot;

  ShowModifierData({
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
    required this.pivot,
  });

  factory ShowModifierData.fromJson(Map<String, dynamic> json) =>
      ShowModifierData(
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
        pivot: Pivot.fromJson(json["pivot"]),
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
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int modifiergroupId;
  int modifierId;

  Pivot({
    required this.modifiergroupId,
    required this.modifierId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modifiergroupId: json["modifiergroup_id"],
        modifierId: json["modifier_id"],
      );

  Map<String, dynamic> toJson() => {
        "modifiergroup_id": modifiergroupId,
        "modifier_id": modifierId,
      };
}
