// ignore_for_file: non_constant_identifier_names

import 'package:spos_retail/model/order_request_model.dart';

class AddItem {
  String item_name;
  String price;
  String discount;
  String inventory_status;
  int category_id;
  AddItem({
    required this.item_name,
    required this.price,
    required this.discount,
    required this.inventory_status,
    required this.category_id,
  });
  Map<String, dynamic> toJson() {
    return {
      "item_name": item_name,
      "price": price,
      "discount": discount,
      "inventory_status": inventory_status,
      "category_id": category_id
    };
  }
}

class CompleteOrderModel {
  String table_id;
  int paid;
  String payment_type;
  dynamic moneyGiven;
  dynamic isPartial;
  dynamic isFull;
  dynamic delivery_address_id;
  dynamic discounted_amount;

  CompleteOrderModel(
      {required this.table_id,
      required this.paid,
      required this.payment_type,
      this.moneyGiven,
      this.isPartial,
      this.isFull,
      this.delivery_address_id,
      this.discounted_amount});
  Map<String, dynamic> toJson() {
    return {
      "table_id": table_id,
      "ispaid": paid,
      "payment_type": payment_type,
      "money_given": moneyGiven,
      "is_partial_paid": isPartial,
      "is_full_paid": isFull,
      "delivery_address_id": delivery_address_id,
      "discounted_amount": discounted_amount
    };
  }
}

class CancelItemModel {
  String table_id;
  String reason_cancel;
  CancelItemModel({
    required this.table_id,
    required this.reason_cancel,
  });

  Map<String, dynamic> toJson() {
    return {"table_id": table_id, "cancel_reason": reason_cancel};
  }
}

class AddStaff {
  String name;
  String email;
  String password;
  String phone;
  String role;
  AddStaff({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
  });
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "role": role
    };
  }
}

class AddTables {
  int floor_number;
  int table;
  int section_id;
  AddTables({
    required this.floor_number,
    required this.table,
    required this.section_id,
  });
  Map<String, dynamic> toJson() {
    return {
      // "floor_id": 11,
      "floor_number": floor_number,
      "section_id": section_id,
      "tables": table
    };
  }
}

class AddModifierGroup {
  String name;
  String description;
  int type;
  int sectionId;
  AddModifierGroup(
      {required this.name,
      required this.description,
      required this.type,
      required this.sectionId});
  Map<String, dynamic> toJson() {
    return {
      // "floor_id": 11,
      "name": name,
      "description": description,
      "type": type,
      "section_id": sectionId
    };
  }
}

class SetModifiers {
  List<int> id;
  SetModifiers({
    required this.id,
  });
  Map<String, dynamic> toJson() {
    return {
      // "floor_id": 11,
      "ids": id
    };
  }
}

class AddModifier {
  String name;
  String price;
  String description;
  AddModifier({
    required this.name,
    required this.price,
    required this.description,
  });
  Map<String, dynamic> toJson() {
    return {
      // "floor_id": 11,
      "name": name,
      "description": description,
      "price": price
    };
  }
}

class AddItemOrder {
  final String? tableID;
  final List<Item> items;
  final String orderType;
  final int customerId;
  final advanceDateTime;

  AddItemOrder({
    required this.tableID,
    required this.items,
    required this.orderType,
    required this.customerId,
    this.advanceDateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "table_id": tableID,
      'items': items.map((item) => item.toJson()).toList(),
      'orderType': orderType,
      'customerId': customerId,
      "advance_order_date_time": advanceDateTime,
    };
  }
}

class UpdateRestaurant {
  String restaurant_name;
  String address;
  String state;
  UpdateRestaurant({
    required this.restaurant_name,
    required this.address,
    required this.state,
  });
  Map<String, dynamic> toJson() {
    return {
      "restaurant_name": restaurant_name,
      "restaurant_email": "",
      "restaurant_phone": "",
      "address": address,
      "city": "",
      "state": state,
      "country": "",
      "pincode": "",
      "license_id": "",
      "fssai_id": "",
      "gst_no": ""
    };
  }
}

class CustomerAddress {
  int customer_id;
  String address;
  String city;
  String state;
  int pincode;
  String type;
  String country;
  CustomerAddress(
      {required this.customer_id,
      required this.address,
      required this.city,
      required this.state,
      required this.pincode,
      required this.type,
      required this.country});
  Map<String, dynamic> toJson() {
    return {
      "customer_id": customer_id,
      "type": type,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
      "pincode": pincode
    };
  }
}

class AddTaxes {
  String gst;
  String sGst;
  String vat;
  int status;
  AddTaxes(
      {required this.gst,
      required this.sGst,
      required this.vat,
      required this.status});
  Map<String, dynamic> toJson() {
    return {"cgst": gst, "sgst": sGst, "vat": vat, "status": status};
  }
}

class AddSupplierData {
  String name;
  String mobileNumber;
  String gstin;
  String c_person;
  String c_number;
  AddSupplierData({
    required this.name,
    required this.mobileNumber,
    required this.gstin,
    required this.c_person,
    required this.c_number,
  });
  Map<String, dynamic> toJson() {
    return {
      "mobile": mobileNumber,
      "name": name,
      "gstin": gstin,
      "c_person": c_person,
      "c_number": c_number
    };
  }
}

class AddPurchase {
  int supplierId;
  String productName;
  String invoiceNumber;
  int unit;
  int quantity;
  int rate;
  int cgst;
  int sgst;
  int vat;
  int tax;
  String discount;
  AddPurchase({
    required this.supplierId,
    required this.productName,
    required this.invoiceNumber,
    required this.unit,
    required this.quantity,
    required this.rate,
    required this.cgst,
    required this.sgst,
    required this.vat,
    required this.tax,
    required this.discount,
  });
  Map<String, dynamic> toJson() {
    return {
      "supplier_id": supplierId,
      "product_name": productName,
      "invoice_number": invoiceNumber,
      "unit": unit,
      "quantity": quantity,
      "rate": rate,
      "cgst": cgst,
      "sgst": sgst,
      "vat": vat,
      "tax": true,
      "discount": ""
    };
  }
}

class AddPayment {
  int isFullPaid;
  int isPartial;
  String status;
  int amount_paid;
  String payment_type;
  AddPayment({
    required this.isFullPaid,
    required this.isPartial,
    required this.status,
    required this.amount_paid,
    required this.payment_type,
  });
  Map<String, dynamic> toJson() {
    return {
      "is_full_paid": isFullPaid,
      "is_partial": isPartial,
      "status": status,
      "amount_paid": amount_paid,
      "payment_type": payment_type
    };
  }

}

class UpdateQuantity {
  String tableId;
  String itemId;
  String quantity;
  UpdateQuantity({
    required this.tableId,
    required this.itemId,
    required this.quantity,
  });
  Map<String, dynamic> toJson() {
    return {
       "table_id":tableId,
    "item_id":itemId,
    "quantity":quantity
    };
  }

}
