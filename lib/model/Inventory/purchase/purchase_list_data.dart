import 'dart:convert';

class PurchaseListData {
    
    dynamic id;
    dynamic supplierId;
    dynamic productName;
    dynamic invoiceNumber;
    dynamic unit;
    dynamic quantity;
    dynamic rate;
    dynamic cgst;
    dynamic sgst;
    dynamic vat;
    dynamic tax;
    dynamic amount;
    dynamic discount;
    dynamic restaurantId;
    dynamic netPayable;
    dynamic reason;
    dynamic originalQuantity;
    PurchaseListData({
        required this.id,
        required this.supplierId,
        required this.productName,
        required this.invoiceNumber,
        required this.unit,
        required this.quantity,
        required this.rate,
        required this.cgst,
        required this.sgst,
        required this.vat,
        required this.tax,
        required this.amount,
        required this.discount,
        required this.restaurantId,
        required this.netPayable,
        required this.reason,
        required this.originalQuantity,
    });
    factory PurchaseListData.fromJson(Map<String, dynamic> json) {
    return PurchaseListData(
      id: json["id"],
        supplierId: json["supplier_id"],
        productName: json["product_name"],
        invoiceNumber: json["invoice_number"],
        unit: json["unit"],
        quantity: json["quantity"],
        rate: json["rate"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        vat: json["vat"],
        tax: json["tax"],
        amount: json["amount"],
        discount: json["discount"],
        restaurantId: json["restaurant_id"],
        netPayable: json["net_payable"],
        reason: json["reason"],
        originalQuantity: json["original_quantity"],
    );
  }
}