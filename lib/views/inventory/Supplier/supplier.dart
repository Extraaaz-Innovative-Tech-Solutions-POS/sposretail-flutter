import 'package:spos_retail/views/inventory/Supplier/update_supplier.dart';

import '../../widgets/export.dart';

class SupplierUI extends StatefulWidget {
  const SupplierUI({super.key});

  @override
  State<SupplierUI> createState() => _SupplierUIState();
}

class _SupplierUIState extends State<SupplierUI> {
  SupplierController suppliercontroller = Get.put(SupplierController());
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String formattedStartDate = "";
  String formattedEndDate = "";
  


  @override
  void initState() {
    super.initState();
    suppliercontroller.getSupplier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Supplier", ""),
      body: GetBuilder<SupplierController>(
          builder: (SupplierController controller) {
        return Column(
          children: [
            search(
              context,
              onchange: (value) {
                setState(() {});
              },
            ),
            orderedItemsListWidget(suppliercontroller.supplierListdata, context),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      // Get.to(() => AddSupplier());
                      Get.to(UpdateSupplier( updateisClick: false));
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
      List<SupplierData> orders, BuildContext context) {
    return DataTable(
        showCheckboxColumn: true,
        columnSpacing: 29.0,
        border: TableBorder(
            horizontalInside:
                BorderSide(color: Theme.of(context).highlightColor)),
        columns: [
          dataColumn(context,"Srno.", true),
          dataColumn(context,"Name", false),
          dataColumn(context,"Mob", true),
          dataColumn(context,"Action", true),
        ],
        rows: orders.asMap().entries.map<DataRow>((entry) {
          final item = entry.value;
          final value = entry.key + 1;
          return DataRow(
            cells: [
              DataCell(
                Text(
                  value.toString(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).highlightColor, fontSize: 16.0),
                ),
              ),
              dataCell(context,item.name),
                DataCell(
                TextButton(
                  onPressed: () {
                    // Get.to(() => UpdateSupplier(id: item.id!.toInt()));
                                            print("cnumber..${suppliercontroller.supplierNumber.value}");

                      Get.to(() => UpdateSupplier(
                        id: item.id!.toInt(),
                        supplierName: item.name,
                        supplierMobile:  item.mobile ,
                        supplierGstIn: item.gstin ,
                        supplierAddress: item.address ,
                        supplierContactPerson:item.cPerson,
                        supplierContactNumber: item.cNumber ,
                        updateisClick: true,
                        ));
                    
                  },
                  child: const Text("Update")               
                ),
              ),

              DataCell(
                IconButton(
                  onPressed: () {
                    suppliercontroller.supplierName.value = item.name.toString();
                    suppliercontroller.supplierNumber.value = item.name.toString();
                    suppliercontroller.deleteSuppliers(item.id);
                   // suppliercontroller.viewStatement(value);
                  },
                  icon: const Icon(Icons.delete)
                ),
              ),
              // dataCell(context,item.mobile),
              // dataCell(context,"View"),
            ],
          );
        }).toList());
  }
}
