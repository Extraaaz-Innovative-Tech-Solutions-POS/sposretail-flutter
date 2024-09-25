import '../../widgets/export.dart';

class AdditionalInfo extends StatelessWidget {
  final infoController = Get.put(AdditionalInfoController());
  AdditionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final gstNumberController =
        TextEditingController(text: infoController.gstNo.value);
    final fssaiController =
        TextEditingController(text: infoController.fssai.value);

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Additional Info", ""),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFieldWithHeading(
                  "GST", context, "Enter GST Number", TextInputType.name,
                  controller: gstNumberController, onchanged: (i) {
                infoController.gstNo.value = i;
              }),
              textFieldWithHeading(
                  "FSSAI", context, "Enter FSSAI", TextInputType.name,
                  controller: fssaiController, onchanged: (i) {
                infoController.fssai.value = i;
              }),
              textFieldWithHeading(
                  "Add Notes", context, "Enter your Notes", TextInputType.name,
                  onchanged: (i) {
                infoController.notes.value = i;
              }),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    infoController.saveInfo(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side:
                              BorderSide(color: Theme.of(context).primaryColor))),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Your Notes......."),
              ),
              Container(
                height: 60.0,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    border: Border.all(color: Theme.of(context).highlightColor)),
                child: GetBuilder<AdditionalInfoController>(builder: (c) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: customText(
                      c.notes.value,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
