import 'dart:convert';

StockReportModdel stockReportModdelFromJson(String str) => StockReportModdel.fromJson(json.decode(str));

String stockReportModdelToJson(StockReportModdel data) => json.encode(data.toJson());

class StockReportModdel {
    String productName;
    String quantity;
    String thresholdValue;

    StockReportModdel({
        required this.productName,
        required this.quantity,
        required this.thresholdValue,
    });

    factory StockReportModdel.fromJson(Map<String, dynamic> json) => StockReportModdel(
        productName: json["product_name"],
        quantity: json["quantity"],
        thresholdValue: json["threshold_value"],
    );

    Map<String, dynamic> toJson() => {
        "product_name": productName,
        "quantity": quantity,
        "threshold_value": thresholdValue,
    };
}
