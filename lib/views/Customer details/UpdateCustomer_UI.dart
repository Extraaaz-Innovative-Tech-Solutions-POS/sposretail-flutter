import 'package:spos_retail/controllers/customer_details_controller/updatecustomer_controller.dart';
import 'package:spos_retail/views/widgets/custom_textfield.dart';
import 'package:spos_retail/views/widgets/export.dart';

class UpdateCustomer extends StatefulWidget {
  String customerId;
  String? name;
  String? phone;
  String? address;
  bool click;

  UpdateCustomer(
      {Key? key,
      required this.customerId,
      required this.click,
      this.name,
      this.address,
      this.phone});

  @override
  State<UpdateCustomer> createState() => _UpdatecustomerState();
}

class _UpdatecustomerState extends State<UpdateCustomer> {
  final updateCustomercontroller = Get.put(UpdateCustomerController());
  final newcustomer = Get.put(AddCustomerController());

  late final TextEditingController nameController;

  late final TextEditingController phoneController;

  late final TextEditingController addressController;

   String _newCustomerAddress ='';

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // getcustomercontroller.getcustomerlist();
    // getcustomercontroller.getcustomerlist(widget.customerId);

    nameController =
        TextEditingController(text: widget.click ? widget.name : "");
    phoneController =
        TextEditingController(text: widget.click ? widget.phone : "");
    addressController =
        TextEditingController(text: widget.click ? widget.address : "");
  }

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Customer Details", ""),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          itemForms(context, "name".tr, widget.click ?widget.name :"Enter Name", false, nameController,
              key: _nameKey),
          itemForms(
            context,
            "phone".tr,
            widget.phone,
            true,
            phoneController,
            key: _phoneKey,
          ),
          // itemForms(
          //     context, "Address", widget.click ? widget.address :"Enter Address", false, addressController,
          //     key: _addressKey,),


              textFieldWithHeading(
                "Address", context, "Enter Address",TextInputType.name ,
                key: _addressKey,
                onchanged: (v){
                   newcustomer.newCustomerAddress.value = v;
                  //  _newCustomerAddress = newcustomer.newCustomerAddress as String;
                  print("Address : ${ newcustomer.newCustomerAddress}");
                }
                ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 157,
                  //  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
                      child: customText(
                        widget.click ? "Update" : "Add",color: Theme.of(context).highlightColor,
                      ),
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            phoneController.text.isNotEmpty
                            // addressController.text.isNotEmpty
                            ) {
                          final bool phone = RegExp(r'^[0-9]{10}$')
                              .hasMatch(phoneController.text);
                          if (phone == true) {
                            //              addCustomer addNewCustomer =
                            // addCustomer(name: nameController.text, address: addressController.text, phone: phoneController.text);
                            widget.click
                                ? updateCustomercontroller.updatecustomer(
                                    widget.customerId,
                                    nameController.text,
                                    phoneController.text,
                                    addressController.text)
                                : newcustomer.postcustomer(
                                    nameController.text,
                                    // addressController.text,
                                    phoneController.text
                                    );
                          } else {
                            snackBarBottom("Error", "Phone Number is not Valid", context);
                          };
                        }
                        else{
                          snackBarBottom("Error", "Fill the required fields", context);
                        }
                      }),
                ),
              ],
            ),
          ),
        ])));
  }

  Widget buildTextFieldWithHeading(
      String heading, hint, BuildContext context, controller) {
    // TextEditingController controller =TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            heading,
            style:
                TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              color: Theme.of(context).focusColor,
              child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Theme.of(context).highlightColor),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).highlightColor),
                      ),
                      hintText: hint,
                      //widget.click ? controller.text : '$heading...',
                      hintStyle: const TextStyle(color: Colors.grey))),
            )),
      ],
    );
  }

  Widget description(String heading, hint, BuildContext context, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            heading,
            style:
                TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 80,
            width: 378,
            decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                border: Border.all(color: Theme.of(context).highlightColor),
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  hintText: hint,
                  //widget.click ? : 'Enter $heading...',
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
        ),
      ],
    );
  }
}
