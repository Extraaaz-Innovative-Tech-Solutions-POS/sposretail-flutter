// class Order {
//   String name;
//   String address;
//   String phone;
//   int table;
//   int floor;
//   List<OrderItem> items;

//   Order({
//     required this.name,
//     required this.address,
//     required this.phone,
//     required this.table,
//     required this.floor,
//     required this.items,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//     List<dynamic> itemsJson = json['items'];
//     List<OrderItem> orderItems =
//         List<OrderItem>.from(itemsJson.map((x) => OrderItem.fromJson(x)));

//     return Order(
//       name: json['name'],
//       address: json['address'],
//       phone: json['phone'],
//       table: json['table'],
//       floor: json['floor'],
//       items: orderItems,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'address': address,
//       'phone': phone,
//       'table': table,
//       'floor': floor,
//       'items': items.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class OrderItem {
//   int id;
//   int cartId;
//   int kotId;
//   int quantity;
//   String status;
//   int itemId;
//   int isCancelled;
//   String itemName;
//   String price;
//   String image;
//   String discount;

//   OrderItem({
//     required this.id,
//     required this.cartId,
//     required this.kotId,
//     required this.quantity,
//     required this.status,
//     required this.itemId,
//     required this.isCancelled,
//     required this.itemName,
//     required this.price,
//     required this.image,
//     required this.discount,
//   });

//   factory OrderItem.fromJson(Map<String, dynamic> json) {
//     return OrderItem(
//       id: json['id'],
//       cartId: json['cart_id'],
//       kotId: json['kot_id'],
//       quantity: json['quantity'],
//       status: json['status'],
//       itemId: json['item_id'],
//       isCancelled: json['is_cancelled'],
//       itemName: json['item_name'],
//       price: json['price'],
//       image: json['Image'],
//       discount: json['discount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'cart_id': cartId,
//       'kot_id': kotId,
//       'quantity': quantity,
//       'status': status,
//       'item_id': itemId,
//       'is_cancelled': isCancelled,
//       'item_name': itemName,
//       'price': price,
//       'Image': image,
//       'discount': discount,
//     };
//   }
// }
