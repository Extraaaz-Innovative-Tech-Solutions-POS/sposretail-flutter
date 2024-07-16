class CurrentOrders {
  dynamic createdAt;
  String floorNumber;
  String tableNumber;

  CurrentOrders({
    required this.createdAt,
    required this.floorNumber,
    required this.tableNumber,
  });

  factory CurrentOrders.fromJson(Map<String, dynamic> json) {
    return CurrentOrders(
      createdAt: json['created_at'],
      floorNumber: json['floor_number'].toString(),
      tableNumber: json['table_number'].toString(),
    );
  }
}
