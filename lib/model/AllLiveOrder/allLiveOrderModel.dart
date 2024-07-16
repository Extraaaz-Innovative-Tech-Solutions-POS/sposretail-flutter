// class AllLiveOrderModel {
//   bool? success;
//   List<AllLiveOrderList>? data;

//   AllLiveOrderModel({this.success, this.data});

//   AllLiveOrderModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <AllLiveOrderList>[];
//       json['data'].forEach((v) {
//         data!.add(new AllLiveOrderList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class AllLiveOrderList {
//   int? id;
//   String? tableId;
//   int? orderNumber;
//   int? isready;
//   int? subTableNumber;
//   int? tableNumber;
//   int? sectionId;
//   int? floorNumber;
//   String? orderType;
//   int? customerId;
//   int? restaurantId;
//   var message;
//   String? status;
//   int? isCancelled;
//  var cancelledReason;
//   int? total;
//   String? advanceOrderDateTime;
//   int? deliveryAddressId;
//   var deliveryStatus;
//   String? createdAt;
//   String? updatedAt;

//   AllLiveOrderList(
//       {this.id,
//       this.tableId,
//       this.orderNumber,
//       this.isready,
//       this.subTableNumber,
//       this.tableNumber,
//       this.sectionId,
//       this.floorNumber,
//       this.orderType,
//       this.customerId,
//       this.restaurantId,
//       this.message,
//       this.status,
//       this.isCancelled,
//       this.cancelledReason,
//       this.total,
//       this.advanceOrderDateTime,
//       this.deliveryAddressId,
//       this.deliveryStatus,
//       this.createdAt,
//       this.updatedAt});

//   AllLiveOrderList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tableId = json['table_id'];
//     orderNumber = json['order_number'];
//     isready = json['isready'];
//     subTableNumber = json['sub_table_number'];
//     tableNumber = json['table_number'];
//     sectionId = json['section_id'];
//     floorNumber = json['floor_number'];
//     orderType = json['order_type'];
//     customerId = json['customer_id'];
//     restaurantId = json['restaurant_id'];
//     message = json['message'];
//     status = json['status'];
//     isCancelled = json['is_cancelled'];
//     cancelledReason = json['cancelled_reason'];
//     total = json['total'];
//     advanceOrderDateTime = json['advance_order_date_time'];
//     deliveryAddressId = json['delivery_address_id'];
//     deliveryStatus = json['delivery_status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['table_id'] = this.tableId;
//     data['order_number'] = this.orderNumber;
//     data['isready'] = this.isready;
//     data['sub_table_number'] = this.subTableNumber;
//     data['table_number'] = this.tableNumber;
//     data['section_id'] = this.sectionId;
//     data['floor_number'] = this.floorNumber;
//     data['order_type'] = this.orderType;
//     data['customer_id'] = this.customerId;
//     data['restaurant_id'] = this.restaurantId;
//     data['message'] = this.message;
//     data['status'] = this.status;
//     data['is_cancelled'] = this.isCancelled;
//     data['cancelled_reason'] = this.cancelledReason;
//     data['total'] = this.total;
//     data['advance_order_date_time'] = this.advanceOrderDateTime;
//     data['delivery_address_id'] = this.deliveryAddressId;
//     data['delivery_status'] = this.deliveryStatus;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }




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
  int? total;
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

