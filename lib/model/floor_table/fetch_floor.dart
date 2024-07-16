class FetchFloor {
    dynamic id;
    String restaurantId;
    String floor;
    // DateTime createdAt;
    // DateTime updatedAt;

    FetchFloor({
        required this.id,
        required this.restaurantId,
        required this.floor,
        // required this.createdAt,
        // required this.updatedAt,
    });

    factory FetchFloor.fromJson(Map<String, dynamic> json) {
    return FetchFloor(
      id: json['id'].toString(),
      restaurantId: json['restaurant_id'].toString(),
      floor: json['floor'].toString(),
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
    );
  }

}
