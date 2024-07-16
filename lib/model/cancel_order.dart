class CancelReport {
  bool? success;
  List<Orders>? orders;

  CancelReport({this.success, this.orders});

  CancelReport.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  //int? id;
  String? tableId;
  //int? kotId;
  //int? itemId;
  int? quantity;
  String? price;
  //String? instruction;
  int? productTotal;
  String? name;
  //int? isCancelled;
  String? status;
  //Null? cartId;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;
  String? cancelReason;

  Orders(
      {
        //this.id,
      this.tableId,
      // this.kotId,
      // this.itemId,
      this.quantity,
      this.price,
      //this.instruction,
      this.productTotal,
      this.name,
      //this.isCancelled,
      this.status,
      //this.cartId,
      this.restaurantId,
      this.createdAt,
      this.updatedAt,
      this.cancelReason});

  Orders.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    tableId = json['table_id'];
    // kotId = json['kot_id'];
    // itemId = json['item_id'];
    quantity = json['quantity'];
    price = json['price'];
    //instruction = json['instruction'];
    productTotal = json['product_total'];
    name = json['name'];
    //isCancelled = json['is_cancelled'];
    status = json['status'];
    //cartId = json['cart_id'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cancelReason = json['cancel_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    //data['id'] = this.id;
    data['table_id'] = tableId;
    // data['kot_id'] = this.kotId;
    // data['item_id'] = this.itemId;
    data['quantity'] = quantity;
    data['price'] = price;
    //data['instruction'] = this.instruction;
    data['product_total'] = productTotal;
    data['name'] = name;
    //data['is_cancelled'] = this.isCancelled;
    data['status'] = status;
    //data['cart_id'] = this.cartId;
    data['restaurant_id'] = restaurantId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cancel_reason'] = cancelReason;
    return data;
  }
}
