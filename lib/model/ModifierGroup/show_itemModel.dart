class ShowItemsModifier {
  bool? success;
  String? message;
  List<ShowItemsModifierData>? data;

  ShowItemsModifier({this.success, this.message, this.data});

  ShowItemsModifier.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ShowItemsModifierData>[];
      json['data'].forEach((v) {
        data!.add(new ShowItemsModifierData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowItemsModifierData {
  int? id;
  String? name;
  String? price;
  String? discount;
  int? categoryId;
  var categoryName;
  int? restaurantId;
  String? foodType;
  var associatedItem;
  int? taxPercentage;

  ShowItemsModifierData(
      {this.id,
      this.name,
      this.price,
      this.discount,
      this.categoryId,
      this.categoryName,
      this.restaurantId,
      this.foodType,
      this.associatedItem,
      this.taxPercentage});

  ShowItemsModifierData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    restaurantId = json['restaurant_id '];
    foodType = json['food_type'];
    associatedItem = json['associated_item'];
    taxPercentage = json['tax_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['restaurant_id '] = this.restaurantId;
    data['food_type'] = this.foodType;
    data['associated_item'] = this.associatedItem;
    data['tax_percentage'] = this.taxPercentage;
    return data;
  }
}
