import '../../widgets/export.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  final recipeController = Get.put(RecipeController());
  final purchaseController = Get.put(PurchaseController());
  final quantityController = TextEditingController();
  final idController = TextEditingController();
  String? _selectedIngredient;
  var selectedId, posId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Create Recipe", ""),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: customText("Recipe Pos Id",
                  color: Theme.of(context).highlightColor),
            ),
          ),
          const SizedBox(height: 10),

          Container(
              padding: const EdgeInsets.only(right: 10, left: 10),
              height: 40.0,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              // margin: const EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  border: Border.all(color: Theme.of(context).highlightColor)),
              child: TextField(
                controller: idController,
                style: TextStyle(color: Theme.of(context).highlightColor),
                keyboardType: TextInputType.number,
                // onSubmitted: (value) {
                //   posId = value;
                //   setState(() {});
                // },
              )),

          // Container(
          //   decoration: BoxDecoration(
          //       color: Theme.of(context).focusColor,
          //       borderRadius: const BorderRadius.all(Radius.circular(10)),
          //       border: Border.all(color: Theme.of(context).highlightColor)),
          //   padding: const EdgeInsets.only(left: 10),
          //   margin: const EdgeInsets.all(10),
          //   child: DropdownButtonHideUnderline(
          //     child: DropdownButtonFormField(
          //       dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          //       value: _selectedPosId,
          //       items: recipeController.dropdownPosId
          //           .asMap()
          //           .entries
          //           .map((entry) => DropdownMenuItem(
          //                 child: customText(entry.value["recipe_name"],
          //                     color: Theme.of(context).highlightColor),
          //                 value: entry.value["recipe_name"],
          //                 onTap: () {
          //                   posId = entry.value["recipe_pos_id"];

          //                   setState(() {});
          //                 },
          //               ))
          //           .toList(),
          //       onChanged: (value) {
          //         setState(() {
          //           _selectedPosId = value.toString();
          //         });
          //       },
          //       decoration: InputDecoration(
          //           border: InputBorder.none,
          //           labelText: 'Select Recipe',
          //           labelStyle:
          //               TextStyle(color: Theme.of(context).highlightColor)),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Theme.of(context).highlightColor)),
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.all(10),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                value: _selectedIngredient,
                items: recipeController.dropdownIngredientList
                    .asMap()
                    .entries
                    .map((entry) => DropdownMenuItem(
                          child: customText(entry.value["product_name"],
                              color: Theme.of(context).highlightColor),
                          value: entry.value["product_name"],
                          onTap: () {
                            selectedId = entry.value["id"];
                            // selectedSectionId = entry.value["id"];
                            setState(() {});
                          },
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIngredient = value.toString();
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Select Ingredient',
                    labelStyle:
                        TextStyle(color: Theme.of(context).highlightColor)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: customText("Quantity",
                  color: Theme.of(context).highlightColor),
            ),
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.only(right: 10, left: 10),
              height: 40.0,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              // margin: const EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  border: Border.all(color: Theme.of(context).highlightColor)),
              child: TextField(
                controller: quantityController,
                style: TextStyle(color: Theme.of(context).highlightColor),
                keyboardType: TextInputType.number,
                // onSubmitted: (value) {
                //   posId = value;
                //   setState(() {});
                // },
              )),
          const SizedBox(height: 20),
          GetBuilder<PurchaseController>(builder: (c) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      recipeController.getIngredientList();
                      print("INGREDIENT ID : -----------");
                      print(selectedId);

                      recipeController.createRecipe(
                          quantityController.text,
                          selectedId,
                          //c.restaurantId.value,
                          idController.text);
                    },
                    child: const Text("Create Recipe")),
              ),
            );
          }),
        ],
      ),
    );
  }
}
