import 'package:spos_retail/controllers/Inventory_Controller/recipe_controller.dart';
import 'package:spos_retail/controllers/Inventory_Controller/stock_controller.dart';
import 'package:spos_retail/views/widgets/custom_data.dart';

import '../../widgets/export.dart';

class StockAlert extends StatelessWidget {
  StockAlert({super.key});

  final stockController = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    Widget orderedItemsListWidget(BuildContext context) {
      return GetBuilder<RecipeController>(builder: (c) {
        return DataTable(
          showCheckboxColumn: true,
          columnSpacing: 14.0,
          border: TableBorder(
              horizontalInside:
                  BorderSide(color: Theme.of(context).highlightColor)),
          columns: [
            dataColumn(context, "Sr.No.", false),
            dataColumn(context, "Product", false),
            dataColumn(context, "Stock", true),
            dataColumn(context, "Threshold.", true),
            dataColumn(context, "Set TS", true),
            dataColumn(context, "Action", true),
          ],
          rows: List<DataRow>.generate(
            c.ingredientDataList.length,
            (index) {
              final ingredientData = c.ingredientDataList[index];

              return DataRow(
                cells: [
                  dataCell(context, ingredientData.id),
                  dataCell(context, ingredientData.name),
                  dataCell(context, ingredientData.quantity),
                  dataCell(context, ingredientData.threshold ?? "-"),
                  DataCell(Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).highlightColor),
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (v) {
                        stockController.thresholdValue.value = v;
                      },
                    ),
                  )),
                  DataCell(
                    IconButton(
                      onPressed: () {
                        stockController.setThresholdValue(ingredientData.id);
                      },
                      icon: const Icon(Icons.add_box_outlined),
                      color: Theme.of(context).hoverColor,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      });
    }

    return Scaffold(
        appBar: commonAppBar(context, "Stock Alert", ""),
        body: SingleChildScrollView(
          child: Column(
            children: [orderedItemsListWidget(context)],
          ),
        ));
  }
}
