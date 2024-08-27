import 'package:spos_retail/views/inventory/RecipeManagement/create_recipe.dart';

import '../../widgets/export.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String formattedStartDate = "";
  String formattedEndDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, "Recipe List", ""),
        body: Column(
          children: [
            orderedItemsListWidget(context),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => const CreateRecipe());
          },
          label: const Text('Create Recipe'),
        ));
  }

  Widget orderedItemsListWidget(BuildContext context) {
    return GetBuilder<RecipeController>(builder: (c) {
     
      return DataTable(
          columnSpacing: 15.0,
          border: TableBorder(
              horizontalInside:
                  BorderSide(color: Theme.of(context).highlightColor)),
          columns: [
            dataColumn("Recipe Name", true),
            dataColumn("Recipe Code", true),
            dataColumn("Ingredients", false),
            dataColumn("Action", true),
          ],

          rows: List<DataRow>.generate(
          c.recipePosId.length,
          (index) {
            String ingredientsString = c.recipePosId[index].ingredients
                .map((ingredient) => ingredient.productName)
                .join(', ');

            return DataRow(
              cells: [
                dataCell(c.recipePosId[index].recipeName.toString()),
                dataCell(c.recipePosId[index].recipePosId.toString()),
                dataCell(ingredientsString),
                DataCell(
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).hoverColor,
                  ),
                ),
              ],
            );
          },
        ),



//           rows: List<DataRow>.generate(
//             c.recipePosId.length,

//             (index) => DataRow(
//  cells: [
                
//                 dataCell(c.recipePosId[index].recipeName.toString()),
//                 dataCell(c.recipePosId[index].recipePosId.toString()),
//                 dataCell(c.recipePosId[index].ingredients.first.productName.toString()??""),
//                 DataCell(Icon(
//                   Icons.delete,
//                   color: Theme.of(context).hoverColor,
//                 ))
//               ],
//             ),
//           )
          
          );
    });
  }

  DataCell dataCell(text) {
    return DataCell(
        Text(text, style: TextStyle(color: Theme.of(context).highlightColor, fontSize: 16.0, overflow: TextOverflow.ellipsis)));
  }

  DataColumn dataColumn(title, bool numeric) {
    return DataColumn(
        label: Center(
          child: customText(title,
              color: Theme.of(context).highlightColor, font: 16.0),
        ),
        numeric: numeric);
  }
}
