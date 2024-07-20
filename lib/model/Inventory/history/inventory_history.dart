class History {
  int? id;
  String? productName;
  String? qtyChange;
  String? changeType;
  String? restaurantId;
  // String? createdAt;
  // String? updatedAt;

  History(
      {this.id,
      this.productName,
      this.qtyChange,
      this.changeType,
      this.restaurantId,
      // this.createdAt,
      // this.updatedAt
      });

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    qtyChange = json['qty_change'];
    changeType = json['change_type'];
    restaurantId = json['restaurant_id'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['product_name'] = productName;
    data['qty_change'] = qtyChange;
    data['change_type'] = changeType;
    data['restaurant_id'] = restaurantId;
    // data['created_at'] = createdAt;
    // data['updated_at'] = updatedAt;
    return data;
  }
}