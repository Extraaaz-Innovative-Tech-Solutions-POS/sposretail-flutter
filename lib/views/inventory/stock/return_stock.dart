import 'package:spos_retail/controllers/Inventory_Controller/stock_controller.dart';

import '../../widgets/export.dart';


class ReturnStock extends StatelessWidget {
  final purchaseController = Get.put(PurchaseController());
  final stockController = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Return Stock", ""),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            dataColumn(context, "Invoice", true),
            dataColumn(context, "items".tr, false),
            dataColumn(context, "Quantity", true),
            dataColumn(context, "Rate", true),
            dataColumn(context, "Action", true),
          ],
          rows: List<DataRow>.generate(
            c.purchadseListdata.length,         
            (index) => DataRow(            
              cells: [                
                dataCell(context, c.purchadseListdata[index].invoiceNumber.toString()),
                dataCell(
                    context, c.purchadseListdata[index].productName.toString()),
                dataCell(context, c.purchadseListdata[index].quantity.toString()),
                dataCell(
                    context, c.purchadseListdata[index].netPayable.toString()),
                DataCell( 

                  customText("Return", color: Theme.of(context).highlightColor),
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10.0,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
            title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: customText("Return Quantity",
                font: 16.0,
                color: Theme.of(context).highlightColor)),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: SizedBox(
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Theme.of(context).highlightColor),
                decoration: InputDecoration(
                  hintText: "Enter Return Quantity",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0), 
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    //gapPadding: 5.0,
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                ),
                onChanged: (v) {
                  stockController.returnQuantity.value = v;

                },              
              ),
            ),
          ),
        ),
      ],
    ),
               
            actions: [
              Center(child: ElevatedButton(onPressed: () {
                 stockController.returnStock(
                    c.purchadseListdata[index].id,
                    c.purchadseListdata[index].productName, 
                    c.purchadseListdata[index].quantity,
                    c.purchadseListdata[index].reason,
                    c.purchadseListdata[index].supplierId,
                    c.purchadseListdata[index].rate,
                    c.purchadseListdata[index].amount

                  );


              }, child: customText("Confirm")))              
            ],
          );
        });
                }
                )
              ],
            ),
          ));
    });
  }
}
