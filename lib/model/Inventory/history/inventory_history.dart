class History {
  int? id;
  String? productName;
  String? qtyChange;
  String? changeType;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;

  History(
      {this.id,
      this.productName,
      this.qtyChange,
      this.changeType,
      this.restaurantId,
      this.createdAt,
      this.updatedAt});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    qtyChange = json['qty_change'];
    changeType = json['change_type'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['qty_change'] = this.qtyChange;
    data['change_type'] = this.changeType;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}