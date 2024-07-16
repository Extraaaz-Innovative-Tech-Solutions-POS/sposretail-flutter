class SoldItemTotal {
  int itemId;
  String name;
  int quantity;
  int productTotal;
  String price;

  SoldItemTotal({
    required this.itemId,
    required this.name,
    required this.quantity,
    required this.productTotal,
    required this.price,
  });

  factory SoldItemTotal.fromJson(Map<String, dynamic> json) => SoldItemTotal(
        itemId: json["item_id"],
        name: json["name"],
        quantity: json["quantity"],
        productTotal: json["product_total"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
        "product_total": productTotal,
      };
}
