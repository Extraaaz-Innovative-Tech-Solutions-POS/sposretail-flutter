class CartResponse {
  bool? success;
  String? message;
  Kot? kot;

  CartResponse({this.success, this.message, this.kot});

  CartResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    kot = json['kot'] != null ? Kot.fromJson(json['kot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (kot != null) {
      data['kot'] = kot!.toJson();
    }
    return data;//1348
  }
}

class Kot {
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
  var message;
  String? status;
  int? isCancelled;
  var cancelledReason;
  var advanceOrderDateTime;
  var deliveryAddress;
  var deliveryStatus;
  int? total;
  var totalDiscount;
  var totalTax;
  var grandTotal;
  String? cgstTax;
  String? sgstTax;
  String? vatTax;
  int? totalGivenAmount;
  var remainingMoney;
  TaxData? taxData;
  List<Items>? items;
  // List<Null>? payments;

  Kot({
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
    this.cgstTax,
    this.sgstTax,
    this.vatTax,
    this.totalGivenAmount,
    this.remainingMoney,
    this.taxData,
    this.items,
    //this.payments
  });

  Kot.fromJson(Map<String, dynamic> json) {
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
    totalDiscount = json['total_discount'];
    totalTax = json['total_tax'];
    grandTotal = json['grand_total'];
    cgstTax = json['cgst_tax'];
    sgstTax = json['sgst_tax'];
    vatTax = json['vat_tax'];
    totalGivenAmount = json['total_given_amount'];
    remainingMoney = json['remaining_money'];
    taxData = json['tax_data'] != null
        ? TaxData.fromJson(json['tax_data'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    // if (json['payments'] != null) {
    //   payments = <Null>[];
    //   json['payments'].forEach((v) {
    //     payments!.add(new Null.fromJson(v));
    //   });
    // }
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
    data['total_discount'] = totalDiscount;
    data['total_tax'] = totalTax;
    data['grand_total'] = grandTotal;
    data['cgst_tax'] = cgstTax;
    data['sgst_tax'] = sgstTax;
    data['vat_tax'] = vatTax;
    data['total_given_amount'] = totalGivenAmount;
    data['remaining_money'] = remainingMoney;
    if (taxData != null) {
      data['tax_data'] = taxData!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    // if (this.payments != null) {
    //   data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    // }
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['phone'] = phone;
    data['restaurant_id'] = restaurantId;
    return data;
  }
}

class TaxData {
  int? id;
  String? restaurantId;
  String? cgst;
  String? sgst;
  Null? vat;
  int? status;
  String? createdAt;
  String? updatedAt;

  TaxData(
      {this.id,
      this.restaurantId,
      this.cgst,
      this.sgst,
      this.vat,
      this.status,
      this.createdAt,
      this.updatedAt});

  TaxData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    vat = json['vat'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['restaurant_id'] = restaurantId;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['vat'] = vat;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  Null? cancelReason;

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
