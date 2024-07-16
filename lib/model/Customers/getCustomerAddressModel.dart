class CustomerAddress {
  bool? success;
  List<CustomerAddressData>? data;
  String? message;

  CustomerAddress({this.success, this.data, this.message});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CustomerAddressData>[];
      json['data'].forEach((v) {
        data!.add(new CustomerAddressData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class CustomerAddressData {
  int? id;
  int? userId;
  int? customerId;
  String? type;
  String? address;
  String? city;
  String? state;
  String? country;
  var pincode;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  CustomerAddressData(
      {this.id,
      this.userId,
      this.customerId,
      this.type,
      this.address,
      this.city,
      this.state,
      this.country,
      this.pincode,
      this.restaurantId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CustomerAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    type = json['type'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['customer_id'] = this.customerId;
    data['type'] = this.type;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
