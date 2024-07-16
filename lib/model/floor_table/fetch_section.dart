class FetchSection {
    String id;
    String name;
    String restaurantId;
    String userId;
    FetchSection({
        required this.id,
        required this.name,
        required this.restaurantId,
        required this.userId,
    });
    factory FetchSection.fromJson(Map<String, dynamic> json) {
    return FetchSection(
      id: json['id'].toString(),
      name: json['name'].toString(),
      restaurantId: json['restaurant_id'].toString(),
      userId: json['user_id'].toString(),
    );
  }
}