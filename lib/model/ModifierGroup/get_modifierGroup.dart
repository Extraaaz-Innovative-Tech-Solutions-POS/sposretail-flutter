// To parse this JSON data, do
//
//     final getModifierGroup = getModifierGroupFromJson(jsonString);

import 'dart:convert';

GetModifierGroup getModifierGroupFromJson(String str) =>
    GetModifierGroup.fromJson(json.decode(str));

String getModifierGroupToJson(GetModifierGroup data) =>
    json.encode(data.toJson());

class GetModifierGroup {
  bool success;
  List<GetModifierGroupData> data;

  GetModifierGroup({
    required this.success,
    required this.data,
  });

  factory GetModifierGroup.fromJson(Map<String, dynamic> json) =>
      GetModifierGroup(
        success: json["success"],
        data: List<GetModifierGroupData>.from(
            json["data"].map((x) => GetModifierGroupData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetModifierGroupData {
  int id;
  int userId;
  var name;
  var description;
  var type;
  var sectionname;
  var sectionId;
  var itemCount;
  var modifiersCount;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  GetModifierGroupData({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.type,
    required this.sectionname,
    required this.sectionId,
    required this.itemCount,
    required this.modifiersCount,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory GetModifierGroupData.fromJson(Map<String, dynamic> json) =>
      GetModifierGroupData(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        sectionname: json['section_name'],
        sectionId: json['section_id'],
        itemCount: json['items_count'],
        modifiersCount: json['modifiers_count'],
        restaurantId: json["restaurant_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "description": description,
        "type": type,
        "section_name ": sectionname,
        "section_id": sectionId,
        "items_count": itemCount,
        "modifiers_count": modifiersCount,
        "restaurant_id": restaurantId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
