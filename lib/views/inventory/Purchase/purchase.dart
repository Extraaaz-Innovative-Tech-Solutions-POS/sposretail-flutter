
import 'package:spos_retail/controllers/Inventory_Controller/purchase.dart';
import 'package:spos_retail/views/widgets/custom_data.dart';

import '../../widgets/export.dart';


class PurchaseUI extends StatelessWidget {
  final purchaseController = Get.put(PurchaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Purchase", ""),
      body: SingleChildScrollView(
        child: Column(
          children: [
            search(
              context,
              onchange: (value) {
                //setState(() {});
              },
            ),
            orderedItemsListWidget(context),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      //purchaseController.getPurchase();
                      //purchaseController.createPurchase();
                      Get.to(() => const AddPurchaseUI());
                    },
                    child: customText('Add Purchase',
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget orderedItemsListWidget(BuildContext context) {
    return GetBuilder<PurchaseController>(builder: (c) {
      return DataTable(
          columnSpacing: 15.0,
          border: TableBorder(
              horizontalInside:
                  BorderSide(color: Theme.of(context).highlightColor)),
          columns: [
            dataColumn(context, "Srno.", true),
            dataColumn(context, "Name", false),
            dataColumn(context, "Date", true),
            dataColumn(context, "Invoice", true),
            dataColumn(context, "Action", true),
          ],
          rows: List<DataRow>.generate(
            c.purchadseListdata.length,
            (index) => DataRow(
              cells: [
                dataCell(context, c.purchadseListdata[index].id.toString()),
                dataCell(
                    context, c.purchadseListdata[index].productName.toString()),
                dataCell(context, c.purchadseListdata[index].id.toString()),
                dataCell(
                    context, c.purchadseListdata[index].productName.toString()),
                DataCell(Icon(
                  Icons.delete,
                  color: Theme.of(context).hoverColor,
                ))
              ],
            ),
          ));
    });
  }
}
