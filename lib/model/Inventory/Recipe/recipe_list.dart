class RecipeListData {
    String recipeName;
    String recipePosId;
    dynamic ingredients;
    
    RecipeListData({
        required this.recipeName,
        required this.recipePosId,
        required this.ingredients,
    });
    factory RecipeListData.fromJson(Map<String, dynamic> json) {
    return RecipeListData(
      recipeName: json["recipe_name"],
      recipePosId: json['recipe_pos_id'].toString(),
      ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
    );
  }
}

class Ingredient {
    dynamic ingredientId;
    dynamic productName;
    dynamic recipeIngredientQuantity;
    dynamic unit;

    Ingredient({
        required this.ingredientId,
        required this.productName,
        required this.recipeIngredientQuantity,
        required this.unit,
    });

    factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        ingredientId: json["ingredient_id"],
        productName: json["product_name"],
        recipeIngredientQuantity: json["recipe_ingredient_quantity"],
        unit: json["unit"],
    );

}

