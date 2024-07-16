import 'dart:convert';

InventoryList inventoryListFromJson(String str) => InventoryList.fromJson(json.decode(str));

String inventoryListToJson(InventoryList data) => json.encode(data.toJson());

class InventoryList {
    int restaurantId;
    List<PurchaseOrder> purchaseOrders;

    InventoryList({
        required this.restaurantId,
        required this.purchaseOrders,
    });

    factory InventoryList.fromJson(Map<String, dynamic> json) => InventoryList(
        restaurantId: json["restaurant_id"],
        purchaseOrders: List<PurchaseOrder>.from(json["purchase_orders"].map((x) => PurchaseOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "restaurant_id": restaurantId,
        "purchase_orders": List<dynamic>.from(purchaseOrders.map((x) => x.toJson())),
    };
}

class PurchaseOrder {
    int id;
    String productName;
    String quantity;
    String unit;

    PurchaseOrder({
        required this.id,
        required this.productName,
        required this.quantity,
        required this.unit,
    });

    factory PurchaseOrder.fromJson(Map<String, dynamic> json) => PurchaseOrder(
        id: json["id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        unit: json["unit"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "quantity": quantity,
        "unit": unit,
    };
}
