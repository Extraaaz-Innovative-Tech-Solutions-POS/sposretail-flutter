class CreditReport {
    String customerName;
    String paymentType;
    dynamic amount;
    dynamic outstandingBalance;

    CreditReport({
        required this.customerName,
        required this.paymentType,
        required this.amount,
        required this.outstandingBalance,
    });

    factory CreditReport.fromJson(Map<String, dynamic> json) => CreditReport(
        customerName: json["customer_name"],
        paymentType: json["payment_type"],
        amount: json["amount"],
        outstandingBalance: json["outstanding_balance"],
    );

    Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "payment_type": paymentType,
        "amount": amount,
        "outstanding_balance": outstandingBalance,
    };
}
