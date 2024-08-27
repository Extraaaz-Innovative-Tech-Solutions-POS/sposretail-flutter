class IngredientDetailsData {
    String id;
    String name;
    String unit;
    dynamic quantity;
    dynamic amount;
    dynamic threshold;
    IngredientDetailsData({
        required this.id,
        required this.name,
        required this.unit,
        required this.quantity,
        required this.amount,
        this.threshold
    });
    factory IngredientDetailsData.fromJson(Map<String, dynamic> json) {
    return IngredientDetailsData(
      id: json['id'].toString(),
      name: json['product_name'].toString(),
      unit: json['unit'].toString(),
      quantity: json['quantity'].toString(),
      amount: json['amount'].toString(),
      threshold: json['threshold_value'].toString(),
    );
  }
}