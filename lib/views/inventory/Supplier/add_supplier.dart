import 'package:spos_retail/controllers/Inventory_Controller/supplier.dart';
import 'package:spos_retail/views/widgets/export.dart';

class AddSupplier extends StatefulWidget {
  bool update;
  
  String? name, number, email, address, gstin, cnumber, cname, id;

  AddSupplier({super.key, required this.update, this.name, number, email, this.address, this.gstin, this.cnumber, this.cname, this.id});

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  late TextEditingController namecontroller = TextEditingController();
  late TextEditingController emailcontroller = TextEditingController();
  late TextEditingController contactPersoncontroller = TextEditingController();
  late TextEditingController contactNumbercontroller = TextEditingController();
  late TextEditingController phonecontroller = TextEditingController();
  late TextEditingController gstController = TextEditingController();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _gstkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactpersonKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactNumberKey = GlobalKey<FormState>();
  final supplierController = Get.put(SupplierController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller = TextEditingController(text: widget.update? widget.name.toString() : "");
    phonecontroller = TextEditingController(text: widget.update? widget.number.toString() : "");
    emailcontroller = TextEditingController(text: widget.update? widget.email.toString() : "");
    gstController = TextEditingController(text: widget.update? widget.gstin.toString() : "");
    contactNumbercontroller = TextEditingController(text: widget.update? widget.cnumber: "");
    contactPersoncontroller = TextEditingController(text: widget.update? widget.cname.toString() : "");
  }

  SupplierController suppliercontroller = Get.put(SupplierController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, widget.update? "Update Supplier" : "Add Supplier", ""),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),

            
            _buildTextFieldWithHeading(_nameKey, "Supplier Name", context,
                namecontroller, "Supplier Name", TextInputType.name),
            const SizedBox(height: 5),

            _buildTextFieldWithHeading(_phoneKey, "Mobile Number", context,
                phonecontroller, "Mobilenumber", TextInputType.number),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(_emailKey, "Address", context,
                emailcontroller, "Address", TextInputType.text),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(_gstkey, "GSTIN No.", context,
                gstController, "GSTIN No.", TextInputType.text),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(
                _contactpersonKey,
                "Contact Person",
                context,
                contactPersoncontroller,
                "Contact Person",
                TextInputType.text),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(
                _contactNumberKey,
                "Contact Number",
                context,
                contactNumbercontroller,
                "Contact Number",
                TextInputType.number),

            //  const SizedBox(height: 5),

            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {

                      if(widget.update) {

                         if (namecontroller.text.isNotEmpty &&
                          emailcontroller.text.isNotEmpty &&
                          phonecontroller.text.isNotEmpty &&
                          contactNumbercontroller.text.isNotEmpty &&
                          contactPersoncontroller.text.isNotEmpty &&
                          gstController.text.isNotEmpty) {
                        suppliercontroller.updateSupplier(
                            namecontroller.text,
                            phonecontroller.text,
                            gstController.text,
                            contactPersoncontroller.text,
                            contactNumbercontroller.text, widget.id.toString());
                      } else {
                        snackBarBottom(
                            "Error", "Enter the required field", context);
                      }

                      } else {

                        if (namecontroller.text.isNotEmpty &&
                          emailcontroller.text.isNotEmpty &&
                          phonecontroller.text.isNotEmpty &&
                          contactNumbercontroller.text.isNotEmpty &&
                          contactPersoncontroller.text.isNotEmpty &&
                          gstController.text.isNotEmpty) {
                        suppliercontroller.addSupplier(
                            namecontroller.text,
                            phonecontroller.text,
                            gstController.text,
                            contactPersoncontroller.text,
                            contactNumbercontroller.text);
                      } else {
                        snackBarBottom(
                            "Error", "Enter the required field", context);
                      }


                      }



                       
                    },
                    child: customText(widget.update ? "Update Supplier" : 'Add Supplier',
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ))
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
