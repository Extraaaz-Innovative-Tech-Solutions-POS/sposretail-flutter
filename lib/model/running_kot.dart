class RunningKot {
    int id;
    int kotId;
    int itemId;
    int quantity;
    int isCancelled;
    int restaurantId;
    int cartId;
    String createdAt;
    String updatedAt;
    int floorNumber;
    int tableNumber;
    int categoryId;
    String itemName;
    String categoryName;
    String message;
    String status;

    RunningKot({
        required this.id,
        required this.kotId,
        required this.itemId,
        required this.quantity,
        required this.isCancelled,
        required this.restaurantId,
        required this.cartId,
        required this.createdAt,
        required this.updatedAt,
        required this.floorNumber,
        required this.tableNumber,
        required this.categoryId,
        required this.itemName,
        required this.categoryName,
        required this.message,
        required this.status,
    });


    factory RunningKot.fromJson(Map<String, dynamic> json) {
    return RunningKot(
      id:json['id'],
      kotId:json['kot_id'],
      itemId:json['item_id'],
      quantity:json['quantity'],
      isCancelled:json['is_cancelled'],
      restaurantId:json['restaurant_id'],
      cartId:json['cart_id'],
      createdAt:json['created_at'],
      updatedAt:json['updated_at'],
      floorNumber:json['floor_number'],
      tableNumber:json['table_number'],
      categoryId:json['category_id'],
      itemName:json['item_name'],
      categoryName:json['category_name'],
      message:json['message'],
      status:json['status'],
    );
  }

}
