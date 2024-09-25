// class CateringPendingOrder {
//   bool? success;
//   List<CateringPendingOrderData>? data;
//   String? message;

//   CateringPendingOrder({this.success, this.data, this.message});

//   CateringPendingOrder.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <CateringPendingOrderData>[];
//       json['data'].forEach((v) {
//         data!.add(new CateringPendingOrderData.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }

// class CateringPendingOrderData {
//   dynamic id;
//   dynamic tableId;
//   dynamic orderNumber;
//   dynamic isready;
//   var tableNumber;
//   var floorNumber;
//   dynamic orderType;
//   dynamic customerId;
//   Customer? customer;
//   dynamic restaurantId;
//   var message;
//   dynamic status;
//   dynamic isCancelled;
//   var cancelledReason;
//   var order_date;
//   var deliveryAddress;
//   var deliveryStatus;
//   dynamic total;
//   dynamic totalDiscount;
//   var totalTax;
//   dynamic grandTotal;
//   dynamic totalGivenAmount;
//   int? remainingMoney;
//   List<CateringItems>? items;
//   List<Payments>? payments;

//   CateringPendingOrderData(
//       {this.id,
//       this.tableId,
//       this.orderNumber,
//       this.isready,
//       this.tableNumber,
//       this.floorNumber,
//       this.orderType,
//       this.customerId,
//       this.customer,
//       this.restaurantId,
//       this.message,
//       this.status,
//       this.isCancelled,
//       this.cancelledReason,
//       this.order_date,
//       this.deliveryAddress,
//       this.deliveryStatus,
//       this.total,
//       this.totalDiscount,
//       this.totalTax,
//       this.grandTotal,
//       this.totalGivenAmount,
//       this.remainingMoney,
//       this.items,
//       this.payments});

//   CateringPendingOrderData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tableId = json['table_id'];
//     orderNumber = json['order_number'];
//     isready = json['isready'];
//     tableNumber = json['table_number'];
//     floorNumber = json['floor_number'];
//     orderType = json['order_type'];
//     customerId = json['customer_id'];
//     customer = json['customer'] != null
//         ? new Customer.fromJson(json['customer'])
//         : null;
//     restaurantId = json['restaurant_id'];
//     message = json['message'];
//     status = json['status'];
//     isCancelled = json['is_cancelled'];
//     cancelledReason = json['cancelled_reason'];
//     order_date = json['order_date'];
//     deliveryAddress = json['delivery_address'];
//     deliveryStatus = json['delivery_status'];
//     total = json['total'];
//     totalDiscount = json['total_discount'];
//     totalTax = json['total_tax'];
//     grandTotal = json['grand_total'];
//     totalGivenAmount = json['total_given_amount'];
//     remainingMoney = json['remaining_money'];
//     if (json['items'] != null) {
//       items = <CateringItems>[];
//       json['items'].forEach((v) {
//         items!.add(new CateringItems.fromJson(v));
//       });
//     }
//     if (json['payments'] != null) {
//       payments = <Payments>[];
//       json['payments'].forEach((v) {
//         payments!.add(new Payments.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['table_id'] = this.tableId;
//     data['order_number'] = this.orderNumber;
//     data['isready'] = this.isready;
//     data['table_number'] = this.tableNumber;
//     data['floor_number'] = this.floorNumber;
//     data['order_type'] = this.orderType;
//     data['customer_id'] = this.customerId;
//     if (this.customer != null) {
//       data['customer'] = this.customer!.toJson();
//     }
//     data['restaurant_id'] = this.restaurantId;
//     data['message'] = this.message;
//     data['status'] = this.status;
//     data['is_cancelled'] = this.isCancelled;
//     data['cancelled_reason'] = this.cancelledReason;
//     data['order_date'] = this.order_date;
//     data['delivery_address'] = this.deliveryAddress;
//     data['delivery_status'] = this.deliveryStatus;
//     data['total'] = this.total;
//     data['total_discount'] = this.totalDiscount;
//     data['total_tax'] = this.totalTax;
//     data['grand_total'] = this.grandTotal;
//     data['total_given_amount'] = this.totalGivenAmount;
//     data['remaining_money'] = this.remainingMoney;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     if (this.payments != null) {
//       data['payments'] = this.payments!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Customer {
//   int? id;
//   String? name;
//   String? address;
//   String? phone;
//   int? restaurantId;

//   Customer({this.id, this.name, this.address, this.phone, this.restaurantId});

//   Customer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     address = json['address'];
//     phone = json['phone'];
//     restaurantId = json['restaurant_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['phone'] = this.phone;
//     data['restaurant_id'] = this.restaurantId;
//     return data;
//   }
// }

// class CateringItems {
//   int? id;
//   String? tableId;
//   int? kotId;
//   int? itemId;
//   int? quantity;
//   String? price;
//   String? name;
//   int? productTotal;
//   int? isCancelled;
//   String? status;
//   int? restaurantId;
//   var cancelReason;

//   CateringItems(
//       {this.id,
//       this.tableId,
//       this.kotId,
//       this.itemId,
//       this.quantity,
//       this.price,
//       this.name,
//       this.productTotal,
//       this.isCancelled,
//       this.status,
//       this.restaurantId,
//       this.cancelReason});

//   CateringItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tableId = json['table_id'];
//     kotId = json['kot_id'];
//     itemId = json['item_id'];
//     quantity = json['quantity'];
//     price = json['price'];
//     name = json['name'];
//     productTotal = json['product_total'];
//     isCancelled = json['is_cancelled'];
//     status = json['status'];
//     restaurantId = json['restaurant_id'];
//     cancelReason = json['cancel_reason'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['table_id'] = this.tableId;
//     data['kot_id'] = this.kotId;
//     data['item_id'] = this.itemId;
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     data['name'] = this.name;
//     data['product_total'] = this.productTotal;
//     data['is_cancelled'] = this.isCancelled;
//     data['status'] = this.status;
//     data['restaurant_id'] = this.restaurantId;
//     data['cancel_reason'] = this.cancelReason;
//     return data;
//   }
// }

// class Payments {
//   int? id;
//   int? userId;
//   var orderId;
//   int? customerId;
//   String? tableId;
//   String? orderNumber;
//   String? restaurantId;
//   String? paymentType;
//   var paymentMethod;
//   String? amount;
//   String? moneyGiven;
//   int? isPartialPaid;
//   int? isFullPaid;
//   String? status;
//   var transactionId;
//   var paymentDetails;
//   String? createdAt;
//   String? updatedAt;
//   var deletedAt;

//   Payments(
//       {this.id,
//       this.userId,
//       this.orderId,
//       this.customerId,
//       this.tableId,
//       this.orderNumber,
//       this.restaurantId,
//       this.paymentType,
//       this.paymentMethod,
//       this.amount,
//       this.moneyGiven,
//       this.isPartialPaid,
//       this.isFullPaid,
//       this.status,
//       this.transactionId,
//       this.paymentDetails,
//       this.createdAt,
//       this.updatedAt,
//       this.deletedAt});

//   Payments.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     orderId = json['order_id'];
//     customerId = json['customer_id'];
//     tableId = json['table_id'];
//     orderNumber = json['order_number'];
//     restaurantId = json['restaurant_id'];
//     paymentType = json['payment_type'];
//     paymentMethod = json['payment_method'];
//     amount = json['amount'];
//     moneyGiven = json['money_given'];
//     isPartialPaid = json['is_partial_paid'];
//     isFullPaid = json['is_full_paid'];
//     status = json['status'];
//     transactionId = json['transaction_id'];
//     paymentDetails = json['payment_details'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['order_id'] = this.orderId;
//     data['customer_id'] = this.customerId;
//     data['table_id'] = this.tableId;
//     data['order_number'] = this.orderNumber;
//     data['restaurant_id'] = this.restaurantId;
//     data['payment_type'] = this.paymentType;
//     data['payment_method'] = this.paymentMethod;
//     data['amount'] = this.amount;
//     data['money_given'] = this.moneyGiven;
//     data['is_partial_paid'] = this.isPartialPaid;
//     data['is_full_paid'] = this.isFullPaid;
//     data['status'] = this.status;
//     data['transaction_id'] = this.transactionId;
//     data['payment_details'] = this.paymentDetails;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     return data;
//   }
// }
