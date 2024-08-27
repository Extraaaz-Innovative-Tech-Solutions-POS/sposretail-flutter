import '../../views/widgets/export.dart';

class RecipeController extends GetxController {
 
  RxList<IngredientDetailsData> ingredientDataList =
      <IngredientDetailsData>[].obs;
  RxList<RecipeListData> recipePosId = <RecipeListData>[].obs;
  List<Map<String, dynamic>> dropdownIngredientList = [];
  List<Map<String, dynamic>> dropdownPosId = [];
  List<String> oldIndexId = [];

  Future<void> getIngredientList() async {
    try {
      final response = await DioServices.get(AppConstant.ingredientList);
      if (response.statusCode == 200) {
        print("INGREDIENT LIST ------------------------------------->");
        print(response.data);

        ingredientDataList.assignAll((response.data['success'])
            .map<IngredientDetailsData>(
                (json) => IngredientDetailsData.fromJson(json)));
        update();
        print("Ingredient Data List Below ------------------->");
        print(ingredientDataList);

        dropdownIngredientList.clear();

        for (int indexs = 0; indexs < ingredientDataList.length; indexs++) {
          dropdownIngredientList.add({
            'product_name': ingredientDataList[indexs].name,
            'id': ingredientDataList[indexs].id,
            "index": indexs
          });

          print(ingredientDataList[indexs].name);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRecipe() async {
    try {
      final response = await DioServices.get(AppConstant.recipeList);
      if (response.statusCode == 200) {
        print(response.data);
        recipePosId.assignAll((response.data['success'])
            .map<RecipeListData>((json) => RecipeListData.fromJson(json)));
        update();

        dropdownPosId.clear();

        for (int indexs = 0; indexs < recipePosId.length; indexs++) {
          dropdownPosId.add({
            'recipe_name': recipePosId[indexs].recipeName,
            'recipe_pos_id': recipePosId[indexs].recipePosId,
            "index": indexs
          });
          print(recipePosId[indexs].recipePosId);
          print(recipePosId[indexs].recipeName);
        }

        update();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createRecipe(quantity, id, posId) async {
    try {
      final response = await DioServices.postRequest(AppConstant.createRecipe, {
        "recipe_pos_id": posId,
        "ingredient_id": id, //"1",//restaurat_id of create purchase
        "recipe_ingredient_quantity": quantity
      });
      print(response.statusMessage);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        snackBar("Success", "Recipe Created Successfully");
        getRecipe();
        Get.off(const RecipeList());
      } else {
        snackBar("Failed", response.statusMessage.toString());
      }
    } catch (e) {
      print(e);
    }
  }
}
