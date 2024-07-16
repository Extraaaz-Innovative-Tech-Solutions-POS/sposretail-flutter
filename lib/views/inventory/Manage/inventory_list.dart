import 'package:intl/intl.dart';
import 'package:spos_retail/views/inventory/Manage/edit_inventory.dart';
import 'package:spos_retail/views/widgets/export.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({super.key});

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String formattedStartDate = "";
  String formattedEndDate = "";
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
      appBar: commonAppBar(context, "Supplier", ""),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText("From".padRight(6),
                    color: Theme.of(context).highlightColor),
                datePick(context, false,
                    title: formattedStartDate.isNotEmpty
                        ? formattedStartDate
                        : null,
                    color: Theme.of(context).highlightColor, onpress: () {
                  startDatePicker();
                }),
                const SizedBox(width: 5),
                customText("To".padRight(4),
                    color: Theme.of(context).highlightColor),
                datePick(context, false,
                    title:
                        formattedEndDate.isNotEmpty ? formattedEndDate : null,
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
            orderedItemsListWidget(context),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      //  Get.to(() => AddSupplier());
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
    return DataTable(
        showCheckboxColumn: true,
        columnSpacing: 14.0,
        border: TableBorder(
            horizontalInside:
                BorderSide(color: Theme.of(context).highlightColor)),
        columns: [
          dataColumn("Sr.No.", false),
          dataColumn("Product", true),
          dataColumn("Current Sto.", true),
          dataColumn("Unit", true),
          dataColumn("Action.", true),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "1",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              dataCell("Capsicum"),
              dataCell("4745"),
              dataCell("Litre"),
              DataCell(Center(
                  child: IconButton(
                      onPressed: () {
                        Get.to(const EditInventory());
                      },
                      icon:
                          const Icon(Icons.edit_document, color: Colors.indigo))
                  // customText("text", color: Theme.of(context).highlightColor, font: 16.0),
                  )),
            ],
          )
        ]);
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
