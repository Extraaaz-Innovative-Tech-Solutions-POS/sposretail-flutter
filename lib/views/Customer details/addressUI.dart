import 'package:spos_retail/views/widgets/export.dart';

class AddressPage extends StatefulWidget {
  int customerID;
  AddressPage({
    Key? key,
    required this.customerID,
  }) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final countryController = TextEditingController();
  final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _cityKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pincodeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _stateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _countryKey = GlobalKey<FormState>();

  final AddCustomerController addCustomerController =
      Get.put(AddCustomerController());
  String _selectedItem = "HOME";

  var items = ["HOME", "WORK"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, "Add Address", ""),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            _buildTextFieldWithHeading(_addressKey, "Address", context,
                addressController, "Address", TextInputType.text),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: _buildTextFieldWithHeading(_cityKey, "City", context,
                        cityController, "City", TextInputType.text)),
                // SizedBox(width: 10),
                Expanded(
                    child: _buildTextFieldWithHeading(
                        _pincodeKey,
                        "Pincode",
                        context,
                        pincodeController,
                        "Pincode",
                        TextInputType.number)),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextFieldWithHeading(_stateKey, "State", context,
                stateController, "State", TextInputType.text),
            const SizedBox(height: 10),
            _buildTextFieldWithHeading(_countryKey, "Country", context,
                countryController, "Country", TextInputType.text),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: customText("Type",
                    font: 16.0,
                    weight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(height: 10),
            Container(
              //margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 10, right: 10),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: screenWidth(context),
              decoration: highlightBorderDecor(context),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                value: _selectedItem,
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: customText(value,
                        color: Theme.of(context).highlightColor),
                  );
                }).toList(),
              )),
            ),
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
                      addCustomerController.addAddress(
                          widget.customerID,
                          addressController.text,
                          cityController.text,
                          stateController.text,
                          int.parse(pincodeController.text),
                          _selectedItem,
                          countryController.text);
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
