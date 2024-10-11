// To parse this JSON data, do
//
//     final salesProfitLossModel = salesProfitLossModelFromJson(jsonString);

import 'dart:convert';

SalesProfitLossModel salesProfitLossModelFromJson(String str) => SalesProfitLossModel.fromJson(json.decode(str));

String salesProfitLossModelToJson(SalesProfitLossModel data) => json.encode(data.toJson());

class SalesProfitLossModel {
    int orderId;
    String revenue;
    dynamic discounts;
    int taxes;
    int cogs;
    int netProfit;
    DateTime createdAt;

    SalesProfitLossModel({
        required this.orderId,
        required this.revenue,
        required this.discounts,
        required this.taxes,
        required this.cogs,
        required this.netProfit,
        required this.createdAt,
    });

    factory SalesProfitLossModel.fromJson(Map<String, dynamic> json) => SalesProfitLossModel(
        orderId: json["order_id"],
        revenue: json["revenue"],
        discounts: json["discounts"],
        taxes: json["taxes"],
        cogs: json["cogs"],
        netProfit: json["net_profit"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "revenue": revenue,
        "discounts": discounts,
        "taxes": taxes,
        "cogs": cogs,
        "net_profit": netProfit,
        "created_at": createdAt.toIso8601String(),
    };
}
