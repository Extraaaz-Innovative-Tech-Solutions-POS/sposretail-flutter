class Tax {
  int id;
  int taxId;
  double percentage;
  int isActive;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  Tax({
    required this.id,
    required this.taxId,
    required this.percentage,
    required this.isActive,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      id: json['id'],
      taxId: json['tax_id'],
      percentage: json['percentage'].toDouble(),
      isActive: json['is_active'],
      restaurantId: json['restaurant_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tax_id': taxId,
      'percentage': percentage,
      'is_active': isActive,
      'restaurant_id': restaurantId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'name': name,
    };
  }
}
