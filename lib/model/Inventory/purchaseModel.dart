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
      {this.id,
      this.supplierId,
      this.productName,
      this.invoiceNumber,
      this.unit,
      this.quantity,
      this.rate,
      this.cgst,
      this.sgst,
      this.vat,
      this.tax,
      this.amount,
      this.discount,
      this.restaurantId,
      this.netPayable,
      this.reason,
      this.originalQuantity,
      this.createdAt,
      this.updatedAt});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supplier_id'] = this.supplierId;
    data['product_name'] = this.productName;
    data['invoice_number'] = this.invoiceNumber;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['rate'] = this.rate;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['vat'] = this.vat;
    data['tax'] = this.tax;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['restaurant_id'] = this.restaurantId;
    data['net_payable'] = this.netPayable;
    data['reason'] = this.reason;
    data['original_quantity'] = this.originalQuantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}