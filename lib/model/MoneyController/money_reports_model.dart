import 'dart:convert';

MoneyReportsModel moneyReportsModelFromJson(String str) => MoneyReportsModel.fromJson(json.decode(str));

String moneyReportsModelToJson(MoneyReportsModel data) => json.encode(data.toJson());

class MoneyReportsModel {
    int id;
    int userId;
    int receiptNo;
    DateTime moneyInDate;
    int amount;
    String paymentMethod;
    String paymentType;
    DateTime createdAt;
    int restaurantId;
    DateTime updatedAt;

    MoneyReportsModel({
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

    factory MoneyReportsModel.fromJson(Map<String, dynamic> json) => MoneyReportsModel(
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
