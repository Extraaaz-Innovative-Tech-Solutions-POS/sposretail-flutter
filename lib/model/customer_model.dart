class Customer {
  final int? id;
  final String name;
  final String address;
  final String phone;
  final String? restaurantsId;

  Customer({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    this.restaurantsId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      restaurantsId: json['resturants_id'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
    };
  }
}
