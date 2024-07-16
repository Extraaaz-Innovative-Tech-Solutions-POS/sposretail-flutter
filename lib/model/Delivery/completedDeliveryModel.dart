class CompletedDeliveryOrders {
  bool? success;
  List<CompletedDeliveryOrdersData>? data;

  CompletedDeliveryOrders({this.success, this.data});

  CompletedDeliveryOrders.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompletedDeliveryOrdersData>[];
      json['data'].forEach((v) {
        data!.add(CompletedDeliveryOrdersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedDeliveryOrdersData {
  int? id;
  String? tableId;
  int? orderNumber;
  int? isready;
  var tableNumber;
  var floorNumber;
  String? orderType;
  int? customerId;
  Customer? customer;
  int? restaurantId;
  var message;
  String? status;
  int? isCancelled;
  var cancelledReason;
  var advanceOrderDateTime;
  var deliveryAddress;
  String? deliveryStatus;
  int? total;
  int? remainingMoney;
  List<CompletedDeliveryOrdersItems>? items;
  List<Payments>? payments;

  CompletedDeliveryOrdersData(
      {this.id,
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
      this.remainingMoney,
      this.items,
      this.payments});

  CompletedDeliveryOrdersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableId = json['table_id'];
    orderNumber = json['order_number'];
    isready = json['isready'];
    tableNumber = json['table_number'];
    floorNumber = json['floor_number'];
    orderType = json['order_type'];
    customerId = json['customer_id'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    restaurantId = json['restaurant_id'];
    message = json['message'];
    status = json['status'];
    isCancelled = json['is_cancelled'];
    cancelledReason = json['cancelled_reason'];
    advanceOrderDateTime = json['advance_order_date_time'];
    deliveryAddress = json['delivery_address'];
    deliveryStatus = json['delivery_status'];
    total = json['total'];
    remainingMoney = json['remaining_money'];
    if (json['items'] != null) {
      items = <CompletedDeliveryOrdersItems>[];
      json['items'].forEach((v) {
        items!.add(CompletedDeliveryOrdersItems.fromJson(v));
      });
    }
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['table_id'] = tableId;
    data['order_number'] = orderNumber;
    data['isready'] = isready;
    data['table_number'] = tableNumber;
    data['floor_number'] = floorNumber;
    data['order_type'] = orderType;
    data['customer_id'] = customerId;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['restaurant_id'] = restaurantId;
    data['message'] = message;
    data['status'] = status;
    data['is_cancelled'] = isCancelled;
    data['cancelled_reason'] = cancelledReason;
    data['advance_order_date_time'] = advanceOrderDateTime;
    data['delivery_address'] = deliveryAddress;
    data['delivery_status'] = deliveryStatus;
    data['total'] = total;
    data['remaining_money'] = remainingMoney;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? address;
  String? phone;
  int? restaurantId;

  Customer({this.id, this.name, this.address, this.phone, this.restaurantId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['phone'] = phone;
    data['restaurant_id'] = restaurantId;
    return data;
  }
}

class CompletedDeliveryOrdersItems {
  int? id;
  String? tableId;
  int? kotId;
  int? itemId;
  int? quantity;
  String? price;
  String? name;
  int? productTotal;
  int? isCancelled;
  String? status;
  int? restaurantId;
 var cancelReason;

  CompletedDeliveryOrdersItems(
      {this.id,
      this.tableId,
      this.kotId,
      this.itemId,
      this.quantity,
      this.price,
      this.name,
      this.productTotal,
      this.isCancelled,
      this.status,
      this.restaurantId,
      this.cancelReason});

  CompletedDeliveryOrdersItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableId = json['table_id'];
    kotId = json['kot_id'];
    itemId = json['item_id'];
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    productTotal = json['product_total'];
    isCancelled = json['is_cancelled'];
    status = json['status'];
    restaurantId = json['restaurant_id'];
    cancelReason = json['cancel_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['table_id'] = tableId;
    data['kot_id'] = kotId;
    data['item_id'] = itemId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['name'] = name;
    data['product_total'] = productTotal;
    data['is_cancelled'] = isCancelled;
    data['status'] = status;
    data['restaurant_id'] = restaurantId;
    data['cancel_reason'] = cancelReason;
    return data;
  }
}

class Payments {
  int? id;
  int? userId;
  int? orderId;
  int? customerId;
  String? tableId;
  String? orderNumber;
  String? restaurantId;
  String? paymentType;
  var paymentMethod;
  String? amount;
  String? moneyGiven;
  int? isPartialPaid;
  int? isFullPaid;
  String? status;
 var transactionId;
  var paymentDetails;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  Payments(
      {this.id,
      this.userId,
      this.orderId,
      this.customerId,
      this.tableId,
      this.orderNumber,
      this.restaurantId,
      this.paymentType,
      this.paymentMethod,
      this.amount,
      this.moneyGiven,
      this.isPartialPaid,
      this.isFullPaid,
      this.status,
      this.transactionId,
      this.paymentDetails,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    customerId = json['customer_id'];
    tableId = json['table_id'];
    orderNumber = json['order_number'];
    restaurantId = json['restaurant_id'];
    paymentType = json['payment_type'];
    paymentMethod = json['payment_method'];
    amount = json['amount'];
    moneyGiven = json['money_given'];
    isPartialPaid = json['is_partial_paid'];
    isFullPaid = json['is_full_paid'];
    status = json['status'];
    transactionId = json['transaction_id'];
    paymentDetails = json['payment_details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_id'] = orderId;
    data['customer_id'] = customerId;
    data['table_id'] = tableId;
    data['order_number'] = orderNumber;
    data['restaurant_id'] = restaurantId;
    data['payment_type'] = paymentType;
    data['payment_method'] = paymentMethod;
    data['amount'] = amount;
    data['money_given'] = moneyGiven;
    data['is_partial_paid'] = isPartialPaid;
    data['is_full_paid'] = isFullPaid;
    data['status'] = status;
    data['transaction_id'] = transactionId;
    data['payment_details'] = paymentDetails;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
