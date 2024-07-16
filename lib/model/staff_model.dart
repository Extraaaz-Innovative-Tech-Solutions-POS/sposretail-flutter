class StaffModel {
  bool? success;
  String? message;
  List<Staff>? data;

  StaffModel({this.success, this.message, this.data});

  StaffModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Staff>[];
      json['data'].forEach((v) {
        data!.add(new Staff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Staff {
  int? id;
  int? restaurantId;
  int? isadmin;
  String? name;
  String? email;
  String? phone;
  var address;
  var plainPassword;
  var resetToken;
  var resetTokenExpires;
  String? createdAt;
  String? updatedAt;
  String? role;
  String? status;

  Staff(
      {this.id,
      this.restaurantId,
      this.isadmin,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.plainPassword,
      this.resetToken,
      this.resetTokenExpires,
      this.createdAt,
      this.updatedAt,
      this.role,
      this.status});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    isadmin = json['isadmin'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    plainPassword = json['plain_password'];
    resetToken = json['reset_token'];
    resetTokenExpires = json['reset_token_expires'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['isadmin'] = this.isadmin;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['plain_password'] = this.plainPassword;
    data['reset_token'] = this.resetToken;
    data['reset_token_expires'] = this.resetTokenExpires;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    data['status'] = this.status;
    return data;
  }
}
