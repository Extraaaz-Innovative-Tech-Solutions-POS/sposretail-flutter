class FloorList {
    dynamic id;
    String userId;
    String floor;
    String sectionsCount;
    String restaurantId;
    // DateTime createdAt;
    // DateTime updatedAt;

    FloorList({
        required this.id,
        required this.userId,
        required this.floor,
        required this.sectionsCount,
        required this.restaurantId,
        // required this.createdAt,
        // required this.updatedAt,
    });

    factory FloorList.fromJson(Map<String, dynamic> json) {
    return FloorList(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      floor: json['floor'].toString(),
      sectionsCount: json['sections_count'].toString(),
      restaurantId: json['restaurant_id'].toString(),
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
    );
  }

}
