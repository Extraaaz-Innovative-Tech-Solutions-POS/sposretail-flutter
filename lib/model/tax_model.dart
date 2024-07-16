class Tax {
  int? id;
  int? taxId;
  double percentage;
  int? isActive;
  int? restaurantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  Tax({
    this.id,
    this.taxId,
    required this.percentage,
    this.isActive,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
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
      'percentage': percentage,
      'is_active': 1,
      'name': name,
    };
  }
}
