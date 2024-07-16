class PendingOrder {
  bool? success;
  List<PendingOrderData>? data;

  PendingOrder({this.success, this.data});

  PendingOrder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PendingOrderData>[];
      json['data'].forEach((v) {
        data!.add(new PendingOrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingOrderData {
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
  int? total;
  int? remainingMoney;
  List<Items>? items;
  List<Payments>? payments;

  PendingOrderData(
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
      this.total,
      this.remainingMoney,
      this.items,
      this.payments});

  PendingOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableId = json['table_id'];
    orderNumber = json['order_number'];
    isready = json['isready'];
    tableNumber = json['table_number'];
    floorNumber = json['floor_number'];
    orderType = json['order_type'];
    customerId = json['customer_id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    restaurantId = json['restaurant_id'];
    message = json['message'];
    status = json['status'];
    isCancelled = json['is_cancelled'];
    cancelledReason = json['cancelled_reason'];
    total = json['total'];
    remainingMoney = json['remaining_money'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(new Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['table_id'] = this.tableId;
    data['order_number'] = this.orderNumber;
    data['isready'] = this.isready;
    data['table_number'] = this.tableNumber;
    data['floor_number'] = this.floorNumber;
    data['order_type'] = this.orderType;
    data['customer_id'] = this.customerId;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['restaurant_id'] = this.restaurantId;
    data['message'] = this.message;
    data['status'] = this.status;
    data['is_cancelled'] = this.isCancelled;
    data['cancelled_reason'] = this.cancelledReason;
    data['total'] = this.total;
    data['remaining_money'] = this.remainingMoney;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
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
  List<CustomerAddress>? customerAddress;

  Customer(
      {this.id,
      this.name,
      this.address,
      this.phone,
      this.restaurantId,
      this.customerAddress});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    restaurantId = json['restaurant_id'];
    if (json['customer_address'] != null) {
      customerAddress = <CustomerAddress>[];
      json['customer_address'].forEach((v) {
        customerAddress!.add(new CustomerAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['restaurant_id'] = this.restaurantId;
    if (this.customerAddress != null) {
      data['customer_address'] =
          this.customerAddress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAddress {
  int? id;
  int? customerId;
  String? type;
  String? address;
  String? city;
  String? state;
  String? country;
  int? pincode;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  CustomerAddress(
      {this.id,
      this.customerId,
      this.type,
      this.address,
      this.city,
      this.state,
      this.country,
      this.pincode,
      this.restaurantId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    type = json['type'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['type'] = this.type;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Items {
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

  Items(
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

  Items.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['table_id'] = this.tableId;
    data['kot_id'] = this.kotId;
    data['item_id'] = this.itemId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['name'] = this.name;
    data['product_total'] = this.productTotal;
    data['is_cancelled'] = this.isCancelled;
    data['status'] = this.status;
    data['restaurant_id'] = this.restaurantId;
    data['cancel_reason'] = this.cancelReason;
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['customer_id'] = this.customerId;
    data['table_id'] = this.tableId;
    data['order_number'] = this.orderNumber;
    data['restaurant_id'] = this.restaurantId;
    data['payment_type'] = this.paymentType;
    data['payment_method'] = this.paymentMethod;
    data['amount'] = this.amount;
    data['money_given'] = this.moneyGiven;
    data['is_partial_paid'] = this.isPartialPaid;
    data['is_full_paid'] = this.isFullPaid;
    data['status'] = this.status;
    data['transaction_id'] = this.transactionId;
    data['payment_details'] = this.paymentDetails;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
