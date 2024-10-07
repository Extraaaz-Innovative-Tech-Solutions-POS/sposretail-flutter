class OrderRequest {
  final String? table;
  final String? floor;
  final String? tableID;
  final List<Item> items;
  final String orderType;
  final int customerId;
  final int section_id;
  final int sub_table;
  final int table_divided_by;
  final String? datetime;

  OrderRequest({
    required this.table,
    required this.floor,
    required this.tableID,
    required this.items,
    required this.orderType,
    required this.customerId,
    required this.section_id,
    required this.sub_table,
    required this.table_divided_by,
    this.datetime,
  });

  Map<String, dynamic> toJson() {
    return {
      "sub_table": sub_table,
      "table_divided_by": table_divided_by,
      "table": table,
      "section_id": section_id,
      "floor": floor,
      "table_id": tableID,
      'items': items.map((item) => item.toJson()).toList(),
      'orderType': orderType,
      'customerId': customerId,
      'advance_order_date_time': datetime
    };
  }
}

class Item {

  int? id;
  String name;
  String price;
  dynamic quantity;
  dynamic boxes;
  dynamic pieces;
  String vairentId;
  String instruction;
  String modifiersGroupID;
  bool? isCustom;

  Item(
      {this.id,
      required this.name,
      required this.price,
      required this.quantity,
      this.boxes,
      this.pieces,
      required this.vairentId,
      required this.instruction,

      required this.modifiersGroupID,
      this.isCustom
      });

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'quantity': quantity,
      'boxes': boxes,
      'pieces': pieces,
      'price': price,
      'name': name,
      'vairentId': vairentId,
      'instruction': instruction,
      "is_custom": isCustom
      
    };
  }
}

class CancelOrder {
  final String tabel_id;
  final int item_id;
  final String reason_cancel;
  CancelOrder({
    required this.tabel_id,
    required this.item_id,
    required this.reason_cancel,
  });

  Map<String, dynamic> toJson() {
    return {
      "table_id": tabel_id,
      "item_id": item_id,
      "cancel_reason": reason_cancel
    };
  }
}
