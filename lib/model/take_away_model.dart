class TakeAwayOrder {
  int id;
  String name;
  String phone;
  String address;
  String orderType;
  List<OrderItem> items;

  TakeAwayOrder({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.orderType,
    required this.items,
  });

  factory TakeAwayOrder.fromJson(Map<String, dynamic> json) {
    List<OrderItem> orderItems = [];

    if (json['items'] != null) {
      var itemsJson = json['items'];

      if (itemsJson is List) {
        orderItems = itemsJson.map((item) => OrderItem.fromJson(item)).toList();
      }
    }

    return TakeAwayOrder(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      orderType: json['order_type'],
      items: orderItems,
    );
  }
}

class OrderItem {
  int itemId;
  String itemName;
  int quantity;
  String price;
  int isCancelled;

  OrderItem({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.isCancelled,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['item_id'],
      itemName: json['item_name'],
      quantity: json['quantity'],
      price: json['price'],
      isCancelled: json['is_cancelled'],
    );
  }
}
