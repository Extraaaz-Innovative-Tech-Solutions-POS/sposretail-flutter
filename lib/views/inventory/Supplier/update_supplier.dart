import 'package:spos_retail/views/widgets/custom_textfield.dart';
import 'package:spos_retail/views/widgets/export.dart';

class UpdateSupplier extends StatefulWidget {
  int id;
  UpdateSupplier({super.key, required this.id});

  @override
  State<UpdateSupplier> createState() => _UpdateSupplierState();
}

class _UpdateSupplierState extends State<UpdateSupplier> {
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _gstkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactpersonKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactNumberKey = GlobalKey<FormState>();
  final suppliercontroller = Get.put(SupplierController());
late List<SupplierData> supplierList;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    suppliercontroller.getSupplierById(widget.id as int);

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
            textFieldWithHeading(_nameKey, "Supplier Name", context,
                suppliercontroller.supplierName.value, TextInputType.name, onchanged: (v) {
                suppliercontroller.supplierName.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(_phoneKey, "Mobile Number", context,
                suppliercontroller.supplierMobile.value, TextInputType.number, onchanged: (v) {
              suppliercontroller.supplierMobile.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(
                _emailKey, "Address", context, suppliercontroller.supplierAddress.value, TextInputType.text,
                onchanged: (v) {
              suppliercontroller.supplierAddress.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(
                _gstkey, "GSTIN No.", context, suppliercontroller.supplierMobile.value, TextInputType.text,
                onchanged: (v) {
              suppliercontroller.supplierGstin.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(_contactpersonKey, "Contact Person", context, 
                suppliercontroller.supplierPerson.value , TextInputType.text, onchanged: (v) {
              suppliercontroller.supplierPerson.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(_contactNumberKey, "Contact Number", context,
                suppliercontroller.supplierMobile.value, TextInputType.number, onchanged: (v) {
              suppliercontroller.supplierNumber.value = v;
            }),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      suppliercontroller.updateSupplier(context, widget.id);
                      // suppliercontroller.addSupplier(context);
                    },
                    child: customText('Update Supplier',
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
