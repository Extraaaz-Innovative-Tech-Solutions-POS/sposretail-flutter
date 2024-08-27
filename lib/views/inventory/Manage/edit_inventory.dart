import '../../widgets/export.dart';

class EditInventory extends StatefulWidget {
  const EditInventory({super.key});

  @override
  State<EditInventory> createState() => _EditInventoryState();
}

class _EditInventoryState extends State<EditInventory> {
  late TextEditingController namecontroller = TextEditingController();
  late TextEditingController emailcontroller = TextEditingController();
  late TextEditingController contactPersoncontroller = TextEditingController();
  late TextEditingController contactNumbercontroller = TextEditingController();
  late TextEditingController phonecontroller = TextEditingController();
  late TextEditingController actualQuantityController = TextEditingController();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _actualQuantitykey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactpersonKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactNumberKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController();
    phonecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    actualQuantityController = TextEditingController();
    contactNumbercontroller = TextEditingController();
    contactPersoncontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Edit Inventory Items", ""),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildTextFieldWithHeading(_nameKey, "Product Name", context,
                namecontroller, "Sugar", TextInputType.name),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(_actualQuantitykey, "Actual Quantity", context,
                actualQuantityController, "0.00", TextInputType.number),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(
                _contactpersonKey,
                "Unit",
                context,
                contactPersoncontroller,
                "Kg",
                TextInputType.text),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(
                _contactNumberKey,
                "Reason",
                context,
                contactNumbercontroller,
                "",
                TextInputType.text),

            //  const SizedBox(height: 5),

            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () {
                          if (namecontroller.text.isNotEmpty &&
                              emailcontroller.text.isNotEmpty &&
                              phonecontroller.text.isNotEmpty) {
                            // final bool emailValid = RegExp(
                            //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            //     .hasMatch(emailcontroller.text);
                            // final bool passwordValid =
                            //     phonecontroller.text.length == 10;
                          } else {
                            snackBarBottom(
                                "Error", "Enter the required field", context);
                          }
                        },
                        child: customText('Add Supplier',
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
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
