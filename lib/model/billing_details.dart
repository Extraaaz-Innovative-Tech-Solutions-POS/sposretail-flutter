import 'dart:convert';

class BillingDetail {
  String invoiceId;
  dynamic customerId;
  dynamic restaurantId;
  String productTotal;
  String totalDiscount;
  String subtotal;
  String restrotaxtotal;
  dynamic othertaxtotal;
  String total;
  String createdAt;
  String updatedAt;
  dynamic id;
  dynamic ispaid;
  dynamic tableNumber;
  dynamic floorNumber;
  String orderType;
  String billingDetailInvoiceId;
  dynamic resturantsId;
  List<ProductItem> product;
  List<TaxItem> restroTax;
  List<OtherTaxItem> otherTax;

  BillingDetail({
    required this.invoiceId,
    required this.customerId,
    required this.restaurantId,
    required this.productTotal,
    required this.totalDiscount,
    required this.subtotal,
    required this.restrotaxtotal,
    required this.othertaxtotal,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.ispaid,
    required this.tableNumber,
    required this.floorNumber,
    required this.orderType,
    required this.billingDetailInvoiceId,
    required this.resturantsId,
    required this.product,
    required this.restroTax,
    required this.otherTax,
  });

  factory BillingDetail.fromJson(Map<String, dynamic> json) {
    return BillingDetail(
      invoiceId: json['invoiceId'],
      customerId: json['customer_id'],
      restaurantId: json['restaurant_id'],
      productTotal: json['product_total'],
      totalDiscount: json['total_discount'],
      subtotal: json['subtotal'],
      restrotaxtotal: json['restrotaxtotal'],
      othertaxtotal: json['othertaxtotal'],
      total: json['total'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      id: json['id'],
      ispaid: json['ispaid'],
      tableNumber: json['table_number'],
      floorNumber: json['floor_number'],
      orderType: json['order_type'],
      billingDetailInvoiceId: json['invoice_id'],
      resturantsId: json['resturants_id'],
      product: List<ProductItem>.from(jsonDecode(json['product']).map((x) => ProductItem.fromJson(x))),
      restroTax: List<TaxItem>.from(jsonDecode(json['restro_tax']).map((x) => TaxItem.fromJson(x))),
      otherTax: List<OtherTaxItem>.from(jsonDecode(json['other_tax']).map((x) => OtherTaxItem.fromJson(x))),
    );
  }
}

class ProductItem {
  dynamic itemId;
  String itemName;
  dynamic quantity;
  String price;
  String discount;
  dynamic taxPercentage;
  dynamic subtotal;
  dynamic totalTax;
  dynamic totalDiscount;
  dynamic totalWithoutTax;

  ProductItem({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.taxPercentage,
    required this.subtotal,
    required this.totalTax,
    required this.totalDiscount,
    required this.totalWithoutTax,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      itemId: json['item_id'],
      itemName: json['item_name'],
      quantity: json['quantity'],
      price: json['price'],
      discount: json['discount'],
      taxPercentage: json['tax_percentage'],
      subtotal: json['subtotal'],
      totalTax: json['totaltax'],
      totalDiscount: json['totaldiscount'],
      totalWithoutTax: json['totalwithouttax'],
    );
  }
}

class TaxItem {
  String tax;
  dynamic percentage;
  dynamic total;

  TaxItem({
    required this.tax,
    required this.percentage,
    required this.total,
  });

  factory TaxItem.fromJson(Map<String, dynamic> json) {
    return TaxItem(
      tax: json['tax'],
      percentage: json['percentage'],
      total: json['total'],
    );
  }
}

class OtherTaxItem {
  dynamic itemId;
  String itemName;
  dynamic quantity;
  String discount;
  String price;
  dynamic taxPercentage;
  dynamic totalTax;

  OtherTaxItem({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.discount,
    required this.price,
    required this.taxPercentage,
    required this.totalTax,
  });

  factory OtherTaxItem.fromJson(Map<String, dynamic> json) {
    return OtherTaxItem(
      itemId: json['item_id'],
      itemName: json['item_name'],
      quantity: json['quantity'],
      discount: json['discount'],
      price: json['price'],
      taxPercentage: json['tax_percentage'],
      totalTax: json['totaltax'],
    );
  }
}
