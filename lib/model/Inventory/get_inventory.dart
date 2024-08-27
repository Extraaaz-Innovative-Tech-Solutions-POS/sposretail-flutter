// class GetSupplierInventory {
//   int? id;
//   String? mobile;
//   String? name;
//   String? gstin;
//  var address;
//   String? restaurantId;
//   String? cPerson;
//   String? cNumber;
//   String? updatedAt;
//   String? createdAt;

//   GetSupplierInventory(
//       {this.id,
//       this.mobile,
//       this.name,
//       this.gstin,
//       this.address,
//       this.restaurantId,
//       this.cPerson,
//       this.cNumber,
//       this.updatedAt,
//       this.createdAt});

//   GetSupplierInventory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     mobile = json['mobile'];
//     name = json['name'];
//     gstin = json['gstin'];
//     address = json['address'];
//     restaurantId = json['restaurant_id'];
//     cPerson = json['c_person'];
//     cNumber = json['c_number'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = id;
//     data['mobile'] = mobile;
//     data['name'] = name;
//     data['gstin'] = gstin;
//     data['address'] = address;
//     data['restaurant_id'] = restaurantId;
//     data['c_person'] = cPerson;
//     data['c_number'] = cNumber;
//     data['updated_at'] = updatedAt;
//     data['created_at'] = createdAt;
//     return data;
//   }
// }

////////////////////

class SupplierData {
  int? id;
  String? mobile;
  String? name;
  String? gstin;
  var address;
  String? restaurantId;
  String? cPerson;
  String? cNumber;
  String? updatedAt;
  String? createdAt;
  ////////////

  SupplierData(
      {this.id,
      this.mobile,
      this.name,
      this.gstin,
      this.address,
      this.restaurantId,
      this.cPerson,
      this.cNumber,
      this.updatedAt,
      this.createdAt});

  factory SupplierData.fromJson(Map<String, dynamic> json) {
    return SupplierData(
      id: json["id"],
      mobile: json["mobile"],
      name: json["name"],
      gstin: json["gstin"],
      address: json["address"],
      restaurantId: json["restaurant_id"],
      cPerson: json["c_person"],
      cNumber: json["c_number"],
      updatedAt: json["updated_at"],
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['mobile'] = mobile;
    data['name'] = name;
    data['gstin'] = gstin;
    data['address'] = address;
    data['restaurant_id'] = restaurantId;
    data['c_person'] = cPerson;
    data['c_number'] = cNumber;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;

    return data;
  }
}
