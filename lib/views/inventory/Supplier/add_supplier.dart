import 'package:spos_retail/views/widgets/custom_textfield.dart';

import '../../widgets/export.dart';

class AddSupplier extends StatelessWidget {
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _gstkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactpersonKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactNumberKey = GlobalKey<FormState>();
  final suppliercontroller = Get.put(SupplierController());

  AddSupplier({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Add Supplier", ""),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            textFieldWithHeading(_nameKey, "Supplier Name", context,
                "Supplier Name", TextInputType.name, onchanged: (v) {
              suppliercontroller.supplierName.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(_phoneKey, "Mobile Number", context,
                "Mobilenumber", TextInputType.number, onchanged: (v) {
              suppliercontroller.supplierMobile.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(
                _emailKey, "Address", context, "Address", TextInputType.text,
                onchanged: (v) {
              suppliercontroller.supplierAddress.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(
                _gstkey, "GSTIN No.", context, "GSTIN No.", TextInputType.text,
                onchanged: (v) {
              suppliercontroller.supplierGstin.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(_contactpersonKey, "Contact Person", context,
                "Contact Person", TextInputType.text, onchanged: (v) {
              suppliercontroller.supplierPerson.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(_contactNumberKey, "Contact Number", context,
                "Contact Number", TextInputType.number, onchanged: (v) {
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
                      suppliercontroller.addSupplier(context);
                    },
                    child: customText('Add Supplier',
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
