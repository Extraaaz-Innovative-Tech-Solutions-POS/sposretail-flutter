class ItemSalesReport {
  String name;
  String quantity;
  String price;
  String productTotal;
  //String isCancelled;
  var discount;

  ItemSalesReport({
    required this.name,
    required this.quantity,
    required this.price,
    required this.productTotal,
    //required this.isCancelled,
    required this.discount,
  });

  factory ItemSalesReport.fromJson(Map<String, dynamic> json) =>
      ItemSalesReport(
          name: json["name"],
          quantity: json["quantity"].toString(),
          price: json["price"],
          productTotal: json["product_total"].toString(),
          //isCancelled: json["is_cancelled"].toString(),
          discount: json["discount"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
        "product_total": productTotal,
        //"is_cancelled": isCancelled,
        "discount": discount,
      };
}
