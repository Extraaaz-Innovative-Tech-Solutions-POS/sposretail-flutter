class Customermodel {
   int ?id;
  String? name;
  String? address;
  String? phone;
  int? restaurantId;

  Customermodel({
    this.id,
    this.name,
     this.address,
     this.phone,
    this.restaurantId,
  });

  factory Customermodel.fromJson(Map<String, dynamic> json) {
    return Customermodel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      restaurantId: json['restaurant_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'restaurant_id': restaurantId,
      
    };
  }
}
