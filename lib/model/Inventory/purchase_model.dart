class PurchaseData {
  int? id;
  int? supplierId;
  String? productName;
  String? invoiceNumber;
  String? unit;
  String? quantity;
  String? rate;
  String? cgst;
  String? sgst;
  String? vat;
  int? tax;
  String? amount;
  String? discount;
  String? restaurantId;
  String? netPayable;
  String? reason;
  String? originalQuantity;
  String? createdAt;
  String? updatedAt;

  PurchaseData(
      {id,
      supplierId,
      productName,
      invoiceNumber,
      unit,
      quantity,
      rate,
      cgst,
      sgst,
      vat,
      tax,
      amount,
      discount,
      restaurantId,
      netPayable,
      reason,
      originalQuantity,
      createdAt,
      updatedAt});

  PurchaseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'];
    productName = json['product_name'];
    invoiceNumber = json['invoice_number'];
    unit = json['unit'];
    quantity = json['quantity'];
    rate = json['rate'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    vat = json['vat'];
    tax = json['tax'];
    amount = json['amount'];
    discount = json['discount'];
    restaurantId = json['restaurant_id'];
    netPayable = json['net_payable'];
    reason = json['reason'];
    originalQuantity = json['original_quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['supplier_id'] = supplierId;
    data['product_name'] = productName;
    data['invoice_number'] = invoiceNumber;
    data['unit'] = unit;
    data['quantity'] = quantity;
    data['rate'] = rate;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['vat'] = vat;
    data['tax'] = tax;
    data['amount'] = amount;
    data['discount'] = discount;
    data['restaurant_id'] = restaurantId;
    data['net_payable'] = netPayable;
    data['reason'] = reason;
    data['original_quantity'] = originalQuantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}