class ViewStatementData {
  String? createdAt;
  String? quantity;
  String? amount;
  String? rate;
  String? productName;

  ViewStatementData(
      {this.createdAt,
      this.quantity,
      this.amount,
      this.rate,
      this.productName});

  ViewStatementData.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    quantity = json['quantity'];
    amount = json['amount'];
    rate = json['rate'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['rate'] = this.rate;
    data['product_name'] = this.productName;
    return data;
  }
}