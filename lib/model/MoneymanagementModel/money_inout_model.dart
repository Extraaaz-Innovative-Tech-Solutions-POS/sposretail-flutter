// To parse this JSON data, do
//
//     final moneyInOutModel = moneyInOutModelFromJson(jsonString);

import 'dart:convert';

MoneyInOutModel moneyInOutModelFromJson(String str) => MoneyInOutModel.fromJson(json.decode(str));

String moneyInOutModelToJson(MoneyInOutModel data) => json.encode(data.toJson());

class MoneyInOutModel {
    String receiptNo;
    double amount;
    String paymentMethod;
    String moneyInDate;
    String paymentType;

    MoneyInOutModel({
        required this.receiptNo,
        required this.amount,
        required this.paymentMethod,
        required this.moneyInDate,
        required this.paymentType,
    });

    factory MoneyInOutModel.fromJson(Map<String, dynamic> json) => MoneyInOutModel(
        receiptNo: json["receipt_no"],
        amount: json["amount"]?.toDouble(),
        paymentMethod: json["payment_method"],
        moneyInDate: json["money_in_date"],
        paymentType: json["payment_type"],
    );

    Map<String, dynamic> toJson() => {
        "receipt_no": receiptNo,
        "amount": amount,
        "payment_method": paymentMethod,
        "money_in_date": moneyInDate,
        "payment_type": paymentType,
    };
}
