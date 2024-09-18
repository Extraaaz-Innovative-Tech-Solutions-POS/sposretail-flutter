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

    factory ViewStatementData.fromJson(Map<String, dynamic> json) {
    return ViewStatementData(
      createdAt: json["created_at"],
      quantity: json['quantity'],
    amount :json['amount'],
    rate : json['rate'],
    productName: json['product_name']
    );
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['created_at'] = createdAt;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['rate'] = rate;
    data['product_name'] = productName;
    return data;
  }
}