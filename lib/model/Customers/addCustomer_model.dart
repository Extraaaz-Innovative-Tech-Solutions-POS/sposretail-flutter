class addCustomer {
  int? id;
  String? name;
  String? address;
  String? phone;
  int? restaurantId;
  DateTime? updatedAt;
  DateTime? createdAt;

  addCustomer({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.restaurantId,
    this.updatedAt,
    this.createdAt,
  });

  factory addCustomer.fromJson(Map<String, dynamic> json) {
    return addCustomer(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      restaurantId: json['restaurant_id'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'restaurant_id': restaurantId,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
