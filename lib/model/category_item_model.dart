class CategoryModel {
  int? categoryId;
  String? categoryName;
  int? restaurantId;
  String? description;
  List<ItemModel>? items;

  CategoryModel(
      {this.categoryId,
      this.categoryName,
      this.restaurantId,
      this.description,
      this.items});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id '];
    categoryName = json['category_name'];
    restaurantId = json['restaurant_id '];
    description = json['description'];
    if (json['items'] != null) {
      items = <ItemModel>[];
      json['items'].forEach((v) {
        items!.add(ItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category_id '] = categoryId;
    data['category_name'] = categoryName;
    data['restaurant_id '] = restaurantId;
    data['description'] = description;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemModel {
  int? id;
  String? name;
  var price;
  String? discount;
  int? categoryId;
  var categoryName;
  int? restaurantId;
  var foodType;
  var associatedItem;
  var taxPercentage;
  var sectionWisePricing;     //"sectionWisePricings"
  List<ModifierGroups>? modifierGroups;
  var shortCode;

  ItemModel(
      {this.id,
      this.name,
      this.price,
      this.discount,
      this.categoryId,
      this.categoryName,
      this.restaurantId,
      this.foodType,
      this.associatedItem,
      this.taxPercentage,
      this.sectionWisePricing,
      this.modifierGroups,
      this.shortCode});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    restaurantId = json['restaurant_id'];
    foodType = json['food_type'];
    associatedItem = json['associated_item'];
    taxPercentage = json['tax_percentage'];
    sectionWisePricing = json["sectionWisePricings"];
    if (json['modifierGroups'] != null) {
      modifierGroups = <ModifierGroups>[];
      json['modifierGroups'].forEach((v) {
        modifierGroups!.add(new ModifierGroups.fromJson(v));
      });
    }
    shortCode = json['short_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['discount'] = discount;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['restaurant_id'] = restaurantId;
    data['food_type'] = foodType;
    data['associated_item'] = associatedItem;
    data['tax_percentage'] = taxPercentage;
    if (modifierGroups != null) {
      data['modifierGroups'] =
          modifierGroups!.map((v) => v.toJson()).toList();
    }
    data['short_code'] = shortCode;
    return data;
  }
}

class SectionWisePricings {
    String id;
    String itemId;
    String itemName;
    String sectionId;
    dynamic sectionName;
    String sectionPrice;
    String userId;
    String userName;
    String restaurantId;

    SectionWisePricings({
        required this.id,
        required this.itemId,
        required this.itemName,
        required this.sectionId,
        required this.sectionName,
        required this.sectionPrice,
        required this.userId,
        required this.userName,
        required this.restaurantId,
    });

    factory SectionWisePricings.fromJson(Map<String, dynamic> json) => SectionWisePricings(
        id: json["id"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        sectionId: json["section_id"],
        sectionName: json["section_name"],
        sectionPrice: json["section_price"],
        userId: json["user_id"],
        userName: json["user_name"],
        restaurantId: json["restaurant_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_name": itemName,
        "section_id": sectionId,
        "section_name": sectionName,
        "section_price": sectionPrice,
        "user_id": userId,
        "user_name": userName,
        "restaurant_id": restaurantId,
    };
}

class ModifierGroups {
  int? id;
  int? userId;
  String? userName;
  String? name;
  String? description;
  var type;
  int? restaurantId;
  int? itemsCount;
  int? modifiersCount;
  String? createdAt;
  String? updatedAt;
  List<Modifiers>? modifiers;

  ModifierGroups(
      {this.id,
      this.userId,
      this.userName,
      this.name,
      this.description,
      this.type,
      this.restaurantId,
      this.itemsCount,
      this.modifiersCount,
      this.createdAt,
      this.updatedAt,
      this.modifiers});

  ModifierGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    restaurantId = json['restaurant_id'];
    itemsCount = json['items_count'];
    modifiersCount = json['modifiers_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['modifiers'] != null) {
      modifiers = <Modifiers>[];
      json['modifiers'].forEach((v) {
        modifiers!.add(new Modifiers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['restaurant_id'] = this.restaurantId;
    data['items_count'] = this.itemsCount;
    data['modifiers_count'] = this.modifiersCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.modifiers != null) {
      data['modifiers'] = this.modifiers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modifiers {
  int? id;
  int? userId;
  String? name;
  var shortName;
  String? description;
  String? price;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  Modifiers(
      {this.id,
      this.userId,
      this.name,
      this.shortName,
      this.description,
      this.price,
      this.restaurantId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Modifiers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    shortName = json['short_name'];
    description = json['description'];
    price = json['price'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['description'] = this.description;
    data['price'] = this.price;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
