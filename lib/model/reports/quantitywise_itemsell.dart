class QuantityWiseItemSales {
    String itemName;
    dynamic quantity;
    dynamic subtotal;

    QuantityWiseItemSales({
        required this.itemName,
        required this.quantity,
        required this.subtotal,
    });

    factory QuantityWiseItemSales.fromJson(Map<String, dynamic> json) => QuantityWiseItemSales(
        itemName: json["item_name"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
    );

    Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "quantity": quantity,
        "subtotal": subtotal,
    };
}