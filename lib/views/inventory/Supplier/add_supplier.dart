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
            textFieldWithHeading("Supplier Name", context,
                "Supplier Name", TextInputType.name, key: _nameKey, onchanged: (v) {
              suppliercontroller.supplierName.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading("Mobile Number", context,
                "Mobilenumber", TextInputType.number, key: _phoneKey, onchanged: (v) {
              suppliercontroller.supplierMobile.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading("Address", context, "Address", TextInputType.text,
                key: _emailKey,
                onchanged: (v) {
              suppliercontroller.supplierAddress.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading(
                "GSTIN No.", context, "GSTIN No.", TextInputType.text,
                key: _gstkey,
                onchanged: (v) {
              suppliercontroller.supplierGstin.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading("Contact Person", context,
                "Contact Person", TextInputType.text, key: _contactpersonKey, onchanged: (v) {
              suppliercontroller.supplierPerson.value = v;
            }),
            const SizedBox(height: 5),
            textFieldWithHeading("Contact Number", context,
                "Contact Number", TextInputType.number, key:_contactNumberKey, onchanged: (v) {
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
