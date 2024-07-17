import 'package:intl/intl.dart';
import 'package:spos_retail/controllers/Inventory_Controller/supplier.dart';
import 'package:spos_retail/model/Inventory/get_inventory.dart';
import 'package:spos_retail/views/inventory/Supplier/add_supplier.dart';
import 'package:spos_retail/views/widgets/export.dart';

class SupplierUI extends StatefulWidget {
  const SupplierUI({super.key});

  @override
  State<SupplierUI> createState() => _SupplierUIState();
}

class _SupplierUIState extends State<SupplierUI> {
  SupplierController supplierController = Get.put(SupplierController());
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
  void initState() {
    super.initState();
    supplierController.getSupplier();
    print("Enter in the Supplier------------>");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Supplier", ""),
      body: GetBuilder<SupplierController>(
          builder: (SupplierController controller) {
        return Column(
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
            orderedItemsListWidget(supplierController.getInventory, context),
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
        );
      }),
    );
  }

  Widget orderedItemsListWidget(
      List<GetSupplierInventory> orders, BuildContext context) {
    return DataTable(
        showCheckboxColumn: true,
        columnSpacing: 29.0,
        border: TableBorder(
            horizontalInside:
                BorderSide(color: Theme.of(context).highlightColor)),
        columns: [
          dataColumn("Srno.", true),
          dataColumn("Name", true),
          dataColumn("Mob", true),
          dataColumn("Action", true),
        ],
        rows: orders.asMap().entries.map<DataRow>((entry) {
          final item = entry.value;
          final value = entry.key + 1;
          return DataRow(
            onLongPress: () {
                  supplierController.deleteSuppliers(item.id);
                },
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
              dataCell(item.name),
              dataCell(item.mobile),
              dataCell("View"),
            ],
          );
        }).toList());
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
    );
  }
}
