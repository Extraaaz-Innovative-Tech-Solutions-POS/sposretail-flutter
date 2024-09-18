
import 'package:spos_retail/model/Inventory/view_statement.dart';
import 'package:spos_retail/views/widgets/export.dart';
class ViewStatement extends StatelessWidget {
  ViewStatement({super.key});
  final suppliercontroller = Get.put(SupplierController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "View Statement", ""),
      body: suppliercontroller.viewStatementList.isEmpty ?
          const Center(child: Text("No Details Found"),):
          orderedItemsListWidget(suppliercontroller.viewStatementList, context),
    );
  }

  Widget orderedItemsListWidget(
      List<ViewStatementData> orders, BuildContext context) {
    return DataTable(
        showCheckboxColumn: true,
        columnSpacing: 29.0,
        border: TableBorder(
            horizontalInside:
                BorderSide(color: Theme.of(context).highlightColor)),
        columns: [
          dataColumn(context, "Name", true),
          dataColumn(context, "Rate", false),
          dataColumn(context, "Amount", true),
          dataColumn(context, "Quantity", true),
        ],
        rows: orders.asMap().entries.map<DataRow>((entry) {
          final item = entry.value;
          return 

          DataRow(
            cells: 
            
            [
              
              dataCell(context, item.productName),
              dataCell(context, item.rate),
              dataCell(context, item.amount),
              dataCell(context, item.quantity),
            ],
          );
        }).toList());
  }
}
