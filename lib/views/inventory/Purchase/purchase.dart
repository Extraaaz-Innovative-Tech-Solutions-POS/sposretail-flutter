import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:spos_retail/controllers/Inventory_Controller/purchase.dart';
import 'package:spos_retail/model/Inventory/purchaseModel.dart';
import 'package:spos_retail/views/widgets/export.dart';

class PurchaseUI extends StatefulWidget {
  const PurchaseUI({super.key});

  @override
  State<PurchaseUI> createState() => _PurchaseUIState();
}

class _PurchaseUIState extends State<PurchaseUI> {
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String formattedStartDate = "";
  String formattedEndDate = "";
  final purchaseController = Get.put(PurchaseController());
  startDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      // barrierColor: Theme.of(context).highlightColor,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
      lastDate: DateTime.now(),
    );

    setState(() {
      startDate = selectedDate as DateTime;
      formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    });

    return formattedStartDate;
  }

  endDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
      lastDate: DateTime.now(),
    );

    setState(() {
      endDate = selectedDate!;
      formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);
    });

    return endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Purchase", ""),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText("From".padRight(6),
                  color: Theme.of(context).highlightColor),
              datePick(context, false,
                  title:
                      formattedStartDate.isNotEmpty ? formattedStartDate : null,
                  color: Theme.of(context).highlightColor, onpress: () {
                startDatePicker();
              }),
              const SizedBox(width: 5),
              customText("To".padRight(4),
                  color: Theme.of(context).highlightColor),
              datePick(context, false,
                  title: formattedEndDate.isNotEmpty ? formattedEndDate : null,
                  color: Theme.of(context).highlightColor, onpress: () {
                endDatePicker();
              }),
              const SizedBox(width: 5),
            ],
          ),
          search(
            context,
            onchange: (value) {
              setState(() {});
            },
          ),
          orderedItemsListWidget(purchaseController.purchaseList),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    Get.to(() => const AddPurchaseUI());
                  },
                  child: customText('Add Purchase',
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ))
        ],
      ),
    );
  }

  Widget orderedItemsListWidget(List<PurchaseData> orders) {
    
    return DataTable(
        //showCheckboxColumn: true,
        columnSpacing: 15.0,
        border: TableBorder(
            horizontalInside:
                BorderSide(color: Theme.of(context).highlightColor)),
        columns: [
          dataColumn("Srno.", false),
          dataColumn("Name", true),
          dataColumn("Date", true),
          dataColumn("Invoice", true),
          dataColumn("Action", true),
        ],

        rows: orders.asMap().entries.map<DataRow>((entry) {
          final item = entry.value;
          final value = entry.key + 1;
          return DataRow(
            // onLongPress: () {
            //       supplierController.deleteSuppliers(item.id);
            //     },
            cells: [
              DataCell(
                
                Text(
                  value.toString(),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).highlightColor, fontSize: 16.0),
                ),
              ),
              dataCell(item.productName),
              dataCell(item.discount),
               DataCell(TextButton(
                  onPressed: () {
                    Get.to( PaymentInvoice(id: item.id.toString(),));
                  },
                  child: customText(
                    "Click",
                    color: Colors.blue,
                  ))),
              DataCell(IconButton(
                  onPressed: () {
                   
                  },
                  icon: Icon(Icons.edit_document, color: Theme.of(context).highlightColor,),
                  )),
            ],
          );
        }).toList());
      //   rows: [
      //     DataRow(
      //       cells: [
      //         DataCell(
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "1",
      //                 maxLines: 2,
      //                 softWrap: true,
      //                 overflow: TextOverflow.ellipsis,
      //                 style: TextStyle(
      //                     color: Theme.of(context).highlightColor,
      //                     fontSize: 16.0),
      //               ),
      //             ],
      //           ),
      //         ),
      //         dataCell("Jash"),
      //         dataCell("06/04/24"),
      //         DataCell(TextButton(
      //             onPressed: () {
      //               Get.to(const PaymentInvoice());
      //             },
      //             child: customText(
      //               "Click",
      //               color: Colors.blue,
      //             ))),
      //         DataCell(Icon(
      //           Icons.delete,
      //           color: Theme.of(context).hoverColor,
      //         ))
      //       ],
      //     )
      //   ]
        
      //  );
  }

  DataCell dataCell(text) {
    return DataCell(Center(
      child:
          customText(text, color: Theme.of(context).highlightColor, font: 16.0),
    ));
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
