// To parse this JSON data, do
//
//     final moneyDepositModel = moneyDepositModelFromJson(jsonString);

import 'dart:convert';

MoneyDepositModel moneyDepositModelFromJson(String str) => MoneyDepositModel.fromJson(json.decode(str));

String moneyDepositModelToJson(MoneyDepositModel data) => json.encode(data.toJson());

class MoneyDepositModel {
    int id;
    int userId;
    String receiptNo;
    DateTime moneyInDate;
    String amount;
    String paymentMethod;
    String paymentType;
    DateTime createdAt;
    int restaurantId;
    DateTime updatedAt;

    MoneyDepositModel({
        required this.id,
        required this.userId,
        required this.receiptNo,
        required this.moneyInDate,
        required this.amount,
        required this.paymentMethod,
        required this.paymentType,
        required this.createdAt,
        required this.restaurantId,
        required this.updatedAt,
    });

    factory MoneyDepositModel.fromJson(Map<String, dynamic> json) => MoneyDepositModel(
        id: json["id"],
        userId: json["user_id"],
        receiptNo: json["receipt_no"],
        moneyInDate: DateTime.parse(json["money_in_date"]),
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        paymentType: json["payment_type"],
        createdAt: DateTime.parse(json["created_at"]),
        restaurantId: json["restaurant_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "receipt_no": receiptNo,
        "money_in_date": moneyInDate.toIso8601String(),
        "amount": amount,
        "payment_method": paymentMethod,
        "payment_type": paymentType,
        "created_at": createdAt.toIso8601String(),
        "restaurant_id": restaurantId,
        "updated_at": updatedAt.toIso8601String(),
    };
}
