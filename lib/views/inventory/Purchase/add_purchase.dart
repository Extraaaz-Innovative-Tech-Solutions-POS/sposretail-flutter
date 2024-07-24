import 'package:spos_retail/controllers/Inventory_Controller/purchase.dart';
import 'package:spos_retail/controllers/Inventory_Controller/supplier.dart';

import '../../widgets/export.dart';

class AddPurchaseUI extends StatefulWidget {
  const AddPurchaseUI({super.key});

  @override
  State<AddPurchaseUI> createState() => _AddPurchaseUIState();
}

class _AddPurchaseUIState extends State<AddPurchaseUI> {
  @override
  Widget build(BuildContext context) {
    TextEditingController productName = TextEditingController();
    TextEditingController cgstController = TextEditingController();
    TextEditingController sgstController = TextEditingController();
    TextEditingController rate = TextEditingController();
    TextEditingController amount = TextEditingController();
    TextEditingController dicount = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController unitController = TextEditingController();
    TextEditingController netrange = TextEditingController();
    final purchaseController = Get.put(PurchaseController());
    final supplierController = Get.put(SupplierController());
    final GlobalKey<FormState> _productName = GlobalKey<FormState>();
    final GlobalKey<FormState> _unit = GlobalKey<FormState>();
    final GlobalKey<FormState> _quantity = GlobalKey<FormState>();
    final GlobalKey<FormState> _rate = GlobalKey<FormState>();
    final GlobalKey<FormState> _amount = GlobalKey<FormState>();
    final GlobalKey<FormState> _sgst = GlobalKey<FormState>();
    final GlobalKey<FormState> _csgst = GlobalKey<FormState>();
    final GlobalKey<FormState> _dicount = GlobalKey<FormState>();
    final GlobalKey<FormState> _netrange = GlobalKey<FormState>();
    var selectedItem, supplierId;
    String? _selectedItem;
    return Scaffold(
        appBar: commonAppBar(context, "Add Purchase", ""),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            _buildTextFieldWithHeading(_productName, "Product Name", context,
                productName, "Product Name", TextInputType.text),
            const SizedBox(height: 10),

            Container(
            // decoration: BoxDecoration(
            //     borderRadius: const BorderRadius.all(Radius.circular(10)),
            //     border: Border.all(color: Theme.of(context).highlightColor)),
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.all(10),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                value: _selectedItem,
                items: supplierController.dropdownSupplierId
                    .asMap()
                    .entries
                    .map((entry) => DropdownMenuItem(
                          child: customText(entry.value["name"],
                              color: Theme.of(context).highlightColor),
                          value: entry.value["name"],
                          onTap: () {
                            selectedItem = entry.value["id"];

                            setState(() {});
                          },
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value.toString();
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Select Supplier',
                    labelStyle:
                        TextStyle(color: Theme.of(context).highlightColor)),
              ),
            ),
          ),

            Row(
              children: [
                Expanded(
                    child: _buildTextFieldWithHeading(_unit, "Unit", context,
                        unitController, "Unit", TextInputType.text)),
                // SizedBox(width: 10),
                Expanded(
                    child: _buildTextFieldWithHeading(_quantity, "Quantity",
                        context, quantityController, "Quantity", TextInputType.number)),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextFieldWithHeading(
                _rate, "Rate", context, rate, "Rate", TextInputType.text),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: _buildTextFieldWithHeading(_amount, "Amount",
                        context, amount, "Amount", TextInputType.text)),
                // SizedBox(width: 10),
                Expanded(
                    child: _buildTextFieldWithHeading(_dicount, "Discount",
                        context, dicount, "Discount", TextInputType.number)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: _buildTextFieldWithHeading(_csgst, "CGST", context,
                        cgstController, "CGST", TextInputType.text)),
                // SizedBox(width: 10),
                Expanded(
                    child: _buildTextFieldWithHeading(_sgst, "SGST", context,
                        sgstController, "SGST", TextInputType.number)),
              ],
            ),
            _buildTextFieldWithHeading(_netrange, "Net Pay", context, netrange,
                "Net Pay", TextInputType.text),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () {
                      purchaseController.createPurchase();
                     // purchaseController.createPurchase(1, productName.text, "invoiceNumber", int.parse(unitController.text), int.parse(quantityController.text),int.parse(rate.text), int.parse(cgstController.text), int.parse(sgstController.text), 0, 0, discount.text);
                      // purchaseController.addPayment(id, isFullPaid, isPartial, status, amount_paid, payment_type)
                      // addCustomerController.addAddress(
                      //     widget.customerID,
                      //     addressController.text,
                      //     cityController.text,
                      //     stateController.text,
                      //     int.parse(pincodeController.text),
                      //     _selectedItem,
                      //     countryController.text);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  Widget _buildTextFieldWithHeading(
    
      key,
      String heading,
      BuildContext context,
      TextEditingController controller,
      String hinttext,
      TextInputType keyboardtype) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: customText(heading,
                font: 16.0,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),

               
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: SizedBox(
              height: 55,
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardtype,
                style: TextStyle(color: Theme.of(context).highlightColor),
                decoration: InputDecoration(
                  hintText: hinttext,
                  border: const OutlineInputBorder(
                    // Set consistent border for all states
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0), // Set border color and width
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
                validator: (value) {
                  if (value == "") {
                    return 'Please Enter $heading';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
