class PaymentDetailsModel {
  int? id;
  int? supplierId;
  int? purchaseOrderId;
  String? amount;
  String? discount;
  String? outstandingAmount;
  int? isPartial;
  int? isFullPaid;
  String? paymentType;
  var paymentMethod;
  String? status;
  String? restaurantId;
  String? amountPaid;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  PaymentDetailsModel(
      {this.id,
      this.supplierId,
      this.purchaseOrderId,
      this.amount,
      this.discount,
      this.outstandingAmount,
      this.isPartial,
      this.isFullPaid,
      this.paymentType,
      this.paymentMethod,
      this.status,
      this.restaurantId,
      this.amountPaid,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  PaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'];
    purchaseOrderId = json['purchase_order_id'];
    amount = json['amount'];
    discount = json['discount'];
    outstandingAmount = json['outstanding_amount'];
    isPartial = json['is_partial'];
    isFullPaid = json['is_full_paid'];
    paymentType = json['payment_type'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    restaurantId = json['restaurant_id'];
    amountPaid = json['amount_paid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supplier_id'] = this.supplierId;
    data['purchase_order_id'] = this.purchaseOrderId;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['outstanding_amount'] = this.outstandingAmount;
    data['is_partial'] = this.isPartial;
    data['is_full_paid'] = this.isFullPaid;
    data['payment_type'] = this.paymentType;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['restaurant_id'] = this.restaurantId;
    data['amount_paid'] = this.amountPaid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}