// To parse this JSON data, do
//
//     final dayBlockModel = dayBlockModelFromJson(jsonString);

import 'dart:convert';

DayBlockModel dayBlockModelFromJson(String str) => DayBlockModel.fromJson(json.decode(str));

String dayBlockModelToJson(DayBlockModel data) => json.encode(data.toJson());

class DayBlockModel {
    DateTime reportDate;
    String totalSales;
    dynamic totalDiscounts;
    int totalOrders;
    String totalItemsSold;

    DayBlockModel({
        required this.reportDate,
        required this.totalSales,
        required this.totalDiscounts,
        required this.totalOrders,
        required this.totalItemsSold,
    });

    factory DayBlockModel.fromJson(Map<String, dynamic> json) => DayBlockModel(
        reportDate: DateTime.parse(json["report_date"]),
        totalSales: json["total_sales"],
        totalDiscounts: json["total_discounts"],
        totalOrders: json["total_orders"],
        totalItemsSold: json["total_items_sold"],
    );

    Map<String, dynamic> toJson() => {
        "report_date": "${reportDate.year.toString().padLeft(4, '0')}-${reportDate.month.toString().padLeft(2, '0')}-${reportDate.day.toString().padLeft(2, '0')}",
        "total_sales": totalSales,
        "total_discounts": totalDiscounts,
        "total_orders": totalOrders,
        "total_items_sold": totalItemsSold,
    };
}
