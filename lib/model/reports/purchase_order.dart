class PurchaseModel {
    dynamic unit;
    dynamic quantity;
    String productName;
    dynamic amount;
    dynamic discount;
    dynamic netPayable;
    String supplierName;

    PurchaseModel({
        required this.unit,
        required this.quantity,
        required this.productName,
        required this.amount,
        required this.discount,
        required this.netPayable,
        required this.supplierName,
    });

    factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
        unit: json["unit"],
        quantity: json["quantity"],
        productName: json["product_name"],
        amount: json["amount"],
        discount: json["discount"],
        netPayable: json["net_payable"],
        supplierName: json["supplier_name"],
    );

    Map<String, dynamic> toJson() => {
        "unit": unit,
        "quantity": quantity,
        "product_name": productName,
        "amount": amount,
        "discount": discount,
        "net_payable": netPayable,
        "supplier_name": supplierName,
    };
}
