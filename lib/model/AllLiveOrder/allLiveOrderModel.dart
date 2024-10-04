class Customer {
  int? id;
  String? name;
  String? address;
  String? phone;
  int? restaurantId;

  Customer({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.restaurantId,
  });

  // Factory method to create a Customer from a JSON map
  factory Customer.fromJson(Map<dynamic, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      restaurantId: json['restaurantId'],
    );
  }
}

// The AllLiveOrderModel class with fromJson factory method
class AllLiveOrderModel {
  int? id;
  String? tableId;
  int? orderNumber;
  int? isready;
  int? tableNumber;
  int? floorNumber;
  String? orderType;
  int? customerId;
  Customer? customer;
  int? restaurantId;
  dynamic message;
  String? status;
  int? isCancelled;
  dynamic cancelledReason;
  dynamic advanceOrderDateTime;
  dynamic deliveryAddress;
  dynamic deliveryStatus;
  dynamic total;
  dynamic totalDiscount;
  dynamic totalTax;
  var grandTotal;
  int? totalGivenAmount;
  var remainingMoney;

  AllLiveOrderModel({
    this.id,
    this.tableId,
    this.orderNumber,
    this.isready,
    this.tableNumber,
    this.floorNumber,
    this.orderType,
    this.customerId,
    this.customer,
    this.restaurantId,
    this.message,
    this.status,
    this.isCancelled,
    this.cancelledReason,
    this.advanceOrderDateTime,
    this.deliveryAddress,
    this.deliveryStatus,
    this.total,
    this.totalDiscount,
    this.totalTax,
    this.grandTotal,
    this.totalGivenAmount,
    this.remainingMoney,
  });

  // Factory method to create an AllLiveOrderModel from a JSON map
  factory AllLiveOrderModel.fromJson(Map<dynamic, dynamic> json) {
    return AllLiveOrderModel(
      id: json['id'],
      tableId: json['table_id'],
      orderNumber: json['order_number'],
      isready: json['is_ready'],
      tableNumber: json['table_number'],
      floorNumber: json['floor_number'],
      orderType: json['order_type'],
      customerId: json['customer_id'],
      customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      restaurantId: json['restaurant_id'],
      message: json['message'],
      status: json['status'],
      isCancelled: json['is_cancelled'],
      cancelledReason: json['cancelled_reason'],
      advanceOrderDateTime: json['advance_order_date_time'],
      deliveryAddress: json['delivery_address'],
      deliveryStatus: json['delivery_status'],
      total: json['total'],
      totalDiscount: json['total_discount'],
      totalTax: json['total_tax'],
      grandTotal: json['grand_total'],
      totalGivenAmount: json['total_given_amount'],
      remainingMoney: json['remaining_money'],
    );
  }
}

