class DashboardTopSellingItems {
  bool? success;
  List<TopSelling>? data;

  DashboardTopSellingItems({this.success, this.data});

  DashboardTopSellingItems.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TopSelling>[];
      json['data'].forEach((v) {
        data!.add(new TopSelling.fromJson(v));
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

class TopSelling {
  int? itemId;
  String? name;
  dynamic price;
  var quantity;

  TopSelling({this.itemId, this.name});

  TopSelling.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    name = json['name'];
    price = json['price'];
    quantity = json['total_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['total_quantity'] = this.quantity;
    return data;
  }
}
