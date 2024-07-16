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
    TextEditingController unit = TextEditingController();
    TextEditingController quantity = TextEditingController();
    TextEditingController rate = TextEditingController();
    TextEditingController amount = TextEditingController();
    TextEditingController dicount = TextEditingController();
    TextEditingController netrange = TextEditingController();

    final GlobalKey<FormState> _productName = GlobalKey<FormState>();
    final GlobalKey<FormState> _unit = GlobalKey<FormState>();
    final GlobalKey<FormState> _quantity = GlobalKey<FormState>();
    final GlobalKey<FormState> _rate = GlobalKey<FormState>();
    final GlobalKey<FormState> _amount = GlobalKey<FormState>();
    final GlobalKey<FormState> _sgst = GlobalKey<FormState>();
    final GlobalKey<FormState> _csgst = GlobalKey<FormState>();
    final GlobalKey<FormState> _dicount = GlobalKey<FormState>();
    final GlobalKey<FormState> _netrange = GlobalKey<FormState>();
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
            Row(
              children: [
                Expanded(
                    child: _buildTextFieldWithHeading(_unit, "Unit", context,
                        unit, "Unit", TextInputType.text)),
                // SizedBox(width: 10),
                Expanded(
                    child: _buildTextFieldWithHeading(_quantity, "Quantity",
                        context, quantity, "Quantity", TextInputType.number)),
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
                        unit, "CGST", TextInputType.text)),
                // SizedBox(width: 10),
                Expanded(
                    child: _buildTextFieldWithHeading(_sgst, "SGST", context,
                        quantity, "SGST", TextInputType.number)),
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
