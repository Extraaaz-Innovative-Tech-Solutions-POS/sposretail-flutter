import 'package:spos_retail/views/widgets/export.dart';

class UpdateSupplier extends StatefulWidget {
  int? id;
  bool updateisClick;
  String? supplierName;
  String? supplierMobile;
  String? supplierGstIn;
  String? supplierAddress;
  String? supplierContactPerson;
  String? supplierContactNumber;
  UpdateSupplier(
      {super.key,
      this.id,
      this.supplierName,
      this.supplierMobile,
      this.supplierGstIn,
      this.supplierAddress,
      this.supplierContactPerson,
      this.supplierContactNumber,
      required this.updateisClick});

  @override
  State<UpdateSupplier> createState() => _UpdateSupplierState();
}

class _UpdateSupplierState extends State<UpdateSupplier> {
  late final TextEditingController supplierNameController;
  late final TextEditingController supplierMobileController;
  late final TextEditingController supplierAddressController;
  late final TextEditingController supplierGstInController;
  late final TextEditingController supplierContactPersonController;
  late final TextEditingController supplierContactNumberController;

  late final TextEditingController discountController;

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _gstkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactpersonKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactNumberKey = GlobalKey<FormState>();
  final suppliercontroller = Get.put(SupplierController());
  late List<SupplierData> supplierList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // suppliercontroller.getSupplierById(widget.id as int);
    // suppliercontroller.getSupplierById(widget.id as int);
    supplierNameController = TextEditingController(
        text: widget.updateisClick ? widget.supplierName : "");
    supplierMobileController = TextEditingController(
        text: widget.updateisClick ? widget.supplierMobile : "");
    supplierAddressController = TextEditingController(
        text: widget.updateisClick ? widget.supplierAddress : "");
    supplierGstInController = TextEditingController(
        text: widget.updateisClick ? widget.supplierGstIn : "");
    supplierContactPersonController = TextEditingController(
        text: widget.updateisClick ? widget.supplierContactPerson : "");
    supplierContactNumberController = TextEditingController(
        text: widget.updateisClick ? widget.supplierContactNumber : "");
  }

  @override
  Widget build(BuildContext context) {
    print("checking updatesupplier id ${widget.id}");

    return Scaffold(
      appBar: commonAppBar(context, "Update Supplier", ""),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            // textFieldWithHeading(_nameKey, "Supplier Name", context,
            //     suppliercontroller.supplierName.value, TextInputType.name, onchanged: (v) {
            //     suppliercontroller.supplierName.value = v;
            // }),

            itemForms(
                context,
                "Name",
                widget.updateisClick ? widget.supplierName : "Supplier Name",
                false,
                supplierNameController,
                key: _nameKey, onchanged: (v) {
              suppliercontroller.supplierName.value = v;
            }),

            const SizedBox(height: 5),
            // textFieldWithHeading(_phoneKey, "Mobile Number", context,
            //     suppliercontroller.supplierMobile.value, TextInputType.number, onchanged: (v) {
            //   suppliercontroller.supplierMobile.value = v;
            // }),

            itemForms(
                context,
                "Mobile",
                widget.updateisClick ? widget.supplierMobile : "Mobile Number",
                false,
                supplierMobileController,
                key: _phoneKey, onchanged: (v) {
              suppliercontroller.supplierMobile.value = v;
            }),

            const SizedBox(height: 5),
            itemForms(
                context,
                "Address",
                widget.updateisClick
                    ? widget.supplierAddress
                    : "Supplier Address",
                false,
                supplierAddressController,
                key: _addressKey, onchanged: (v) {
              suppliercontroller.supplierAddress.value = v;
            }),
            const SizedBox(height: 5),
            // textFieldWithHeading(
            //     _gstkey, "GSTIN No.", context, suppliercontroller.supplierMobile.value, TextInputType.text,
            //     onchanged: (v) {
            //   suppliercontroller.supplierGstin.value = v;
            // }),

            itemForms(
                context,
                "GSTIN ",
                widget.updateisClick ? widget.supplierGstIn : "GSTIN No",
                false,
                supplierGstInController,
                key: _gstkey, onchanged: (v) {
              suppliercontroller.supplierGstin.value = v;
            }),
            const SizedBox(height: 5),
            // textFieldWithHeading(_contactpersonKey, "Contact Person", context,
            //     suppliercontroller.supplierPerson.value , TextInputType.text, onchanged: (v) {
            //   suppliercontroller.supplierPerson.value = v;
            // }),

            itemForms(
                context,
                "Contact Person ",
                widget.updateisClick
                    ? widget.supplierContactPerson
                    : "Contact Person",
                false,
                supplierContactPersonController,
                key: _contactpersonKey, onchanged: (v) {
              suppliercontroller.supplierPerson.value = v;
            }),
            const SizedBox(height: 5),
            // textFieldWithHeading(_contactNumberKey, "Contact Number", context,
            //     suppliercontroller.supplierMobile.value, TextInputType.number, onchanged: (v) {
            //   suppliercontroller.supplierNumber.value = v;
            // }),

            itemForms(
                context,
                "Contact ",
                widget.updateisClick
                    ? widget.supplierContactNumber
                    : "Contact Number",
                false,
                supplierContactNumberController,
                key: _contactNumberKey, onchanged: (v) {
              suppliercontroller.supplierNumber.value = v;
            }),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  // child: ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       backgroundColor: Theme.of(context).primaryColor),
                  //   onPressed: () {
                  //     suppliercontroller.updateSupplier(context, widget.id);
                  //     // suppliercontroller.addSupplier(context);
                  //   },
                  //   child: customText('Update Supplier',
                  //       color: Theme.of(context).scaffoldBackgroundColor),
                  // ),

                  child: ElevatedButton(
                      onPressed: () {
                        if (widget.updateisClick == false) {
                          suppliercontroller.addSupplier(context);
                        } else {
                          suppliercontroller.updateSupplier(context, widget.id);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      child: widget.updateisClick
                          ? customText(
                              "Update Supplier",
                              color: Theme.of(context).scaffoldBackgroundColor,
                            )
                          : customText(
                              "Add Supplier",
                              color: Theme.of(context).scaffoldBackgroundColor,
                            )),
                ))
          ],
        ),
      ),
    );
  }
}
