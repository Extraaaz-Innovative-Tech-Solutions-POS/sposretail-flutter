class BillingReport {
  bool? success;
  List<Result>? result;

  BillingReport({this.success, this.result});

  BillingReport.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? tableId;
  String? orderType;
  String? total;
  String? totalDiscount;
  String? paymentType;
  var billnumber;
  String? createdAt;

  Result(
      {this.tableId,
      this.orderType,
      this.total,
      this.totalDiscount,
      this.paymentType,
      this.billnumber,
      this.createdAt});

  Result.fromJson(Map<String, dynamic> json) {
    tableId = json['table_id'];
    orderType = json['order_type'];
    total = json['total'];
    totalDiscount = json['total_discount'];
    paymentType = json['payment_type'];
    billnumber = json['bill_number'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['table_id'] = this.tableId;
    data['order_type'] = this.orderType;
    data['total'] = this.total;
    data['total_discount'] = this.totalDiscount;
    data['payment_type'] = this.paymentType;
    data['bill_number'] = this.billnumber;
    data['created_at'] = this.createdAt;
    return data;
  }
}
