class SalesDataModel {
  final bool success;
  final List<ItemSale> itemSales;
  final List<ItemSale> bestSellingItems;
  final List<ItemSale> worstSellingItems;

  SalesDataModel({
    required this.success,
    required this.itemSales,
    required this.bestSellingItems,
    required this.worstSellingItems,
  });

  factory SalesDataModel.fromJson(Map<String, dynamic> json) {
    return SalesDataModel(
      success: json['success'],
      itemSales: (json['item_sales'] as List)
          .map((item) => ItemSale.fromJson(item))
          .toList(),
      bestSellingItems: (json['best_selling_items'] as List)
          .map((item) => ItemSale.fromJson(item))
          .toList(),
      worstSellingItems: (json['worst_selling_items'] as List)
          .map((item) => ItemSale.fromJson(item))
          .toList(),
    );
  }
}

class ItemSale {
  final String itemName;
  final int quantitySold;
  final double totalRevenue;

  ItemSale({
    required this.itemName,
    required this.quantitySold,
    required this.totalRevenue,
  });

  factory ItemSale.fromJson(Map<String, dynamic> json) {
    return ItemSale(
      itemName: json['item_name'],
      quantitySold: json['quantity_sold'],
      totalRevenue: (json['total_revenue'] is int)
          ? json['total_revenue'].toDouble()
          : json['total_revenue'],
    );
  }
}
