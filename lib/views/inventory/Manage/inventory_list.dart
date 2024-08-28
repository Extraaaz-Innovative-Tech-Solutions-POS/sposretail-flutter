import 'package:spos_retail/views/widgets/export.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Inventory History", ""),
      //
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [            
            // Expanded(
            //  // child: 
            //  child: orderedItemsListWidget(context)
            //   ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                        Get.to(() => AddSupplier());
                    },
                    child: customText('Add Supplier',
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget orderedItemsListWidget(BuildContext context) {
    return GetBuilder<RecipeController>(builder: (c) {
      return DataTable(
         // showCheckboxColumn: true,
          columnSpacing: 14.0,
          border: TableBorder(
              horizontalInside:
                  BorderSide(color: Theme.of(context).highlightColor)),
          columns: [
            dataColumn(context, "Sr.No.", false),
            dataColumn(context,"Product", false),
            dataColumn(context,"Current Sto.", true),
            dataColumn(context,"Unit", true),
            dataColumn(context,"Action.", true),
          ],


          rows: List<DataRow>.generate(
            2,
         // c.ingredientDataList.length,
          (index) {
           // final ingredientData = c.ingredientDataList[index];
            

            return DataRow(
              cells: [
                dataCell(context,"ingredientData.id"),
                dataCell(context,"ingredientData.name"),
                dataCell(context,"ingredientData.quantity"),
                dataCell(context,"ingredientData.unit"),
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
          );
    });
  }
}
