import 'package:spos_retail/views/widgets/export.dart';

class AddTaxes extends StatefulWidget {
  const AddTaxes({super.key});

  @override
  State<AddTaxes> createState() => _AddTaxesState();
}

class _AddTaxesState extends State<AddTaxes> {
  final GlobalKey<FormState> _gstkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _sGstKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _vatKey = GlobalKey<FormState>();
  TextEditingController _gstController = TextEditingController();
  TextEditingController _sGstController = TextEditingController();
  TextEditingController _vatcontroller = TextEditingController();
  final taxesController = Get.put(TaxesController());
  var switchclick;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Taxes Details", ""),
      body: Column(
        children: [
          switchButton("Remove Taxes", switchclick == null ? true : switchclick,
              onChange: (value) {
            setState(() {
              switchclick = value;
            });
          }),
          _buildTextFieldWithHeading(
              _gstkey,
              "GST",
              context,
              _gstController,
              "GST",
              TextInputType.name,
              switchclick == null ? false : switchclick),
          const SizedBox(height: 5),
          _buildTextFieldWithHeading(
              _sGstKey,
              "SGST",
              context,
              _sGstController,
              "SGST",
              TextInputType.name,
              switchclick == null ? false : switchclick),
          const SizedBox(height: 5),
          _buildTextFieldWithHeading(
              _vatKey,
              "VAT",
              context,
              _vatcontroller,
              "VAT",
              TextInputType.name,
              switchclick == null ? false : switchclick),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      if (_gstController.text.isNotEmpty &&
                          _sGstController.text.isNotEmpty) {
                        taxesController.addtaxescontroller(_gstController.text,
                            _sGstController.text, _vatcontroller.text, 1);
                      } else {
                        taxesController.addtaxescontroller("0", "0", '', 0);
                      }
                    },
                    child: switchclick ?? true
                        ? customText('Add Taxes',
                            color: Theme.of(context).scaffoldBackgroundColor)
                        : customText('Remove Taxes',
                            color: Theme.of(context).scaffoldBackgroundColor)),
              ))
        ],
      ),
    );
  }

  Widget _buildTextFieldWithHeading(
      key,
      String heading,
      BuildContext context,
      TextEditingController controller,
      String hinttext,
      TextInputType keyboardtype,
      var taxesstatus) {
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
                readOnly: taxesstatus,
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

  Widget switchButton(title, value, {onChange}) {
    return SwitchListTile(
        activeColor: Theme.of(context).primaryColor,
        value: value,
        onChanged: onChange,
        title: switchTitle(title));
  }

  Widget switchTitle(title) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: customText(title,
              color: Theme.of(context).highlightColor,
              weight: FontWeight.bold,
              font: 15.0),
        )
      ],
    );
  }
}
