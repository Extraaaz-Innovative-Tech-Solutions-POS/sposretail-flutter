// To parse this JSON data, do
//
//     final cutOffDayModdel = cutOffDayModdelFromJson(jsonString);

import 'dart:convert';

CutOffDayModdel cutOffDayModdelFromJson(String str) => CutOffDayModdel.fromJson(json.decode(str));

String cutOffDayModdelToJson(CutOffDayModdel data) => json.encode(data.toJson());

class CutOffDayModdel {
    DateTime reportDate;
    String totalSales;
    String totalDiscounts;
    int totalOrders;
    String totalItemsSold;

    CutOffDayModdel({
        required this.reportDate,
        required this.totalSales,
        required this.totalDiscounts,
        required this.totalOrders,
        required this.totalItemsSold,
    });

    factory CutOffDayModdel.fromJson(Map<String, dynamic> json) => CutOffDayModdel(
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
