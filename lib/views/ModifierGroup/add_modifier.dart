import '../widgets/export.dart';

class AddModifierGroupUI extends StatefulWidget {
  const AddModifierGroupUI({super.key});

  @override
  State<AddModifierGroupUI> createState() => _AddModifierGroupUIState();
}

class _AddModifierGroupUIState extends State<AddModifierGroupUI> {
  String? selectedoption = 'Add On';
  final TextEditingController _titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final controller = Get.put(AddModifierGroupController());
  final sectionController = Get.put(SectionController());
  String dropdownvalue = 'Varients';
  String? _selectedItem;
  var selectedSectionId;
  var items = ['Varients', 'Addons'];

  @override
  void initState() {
    super.initState();
    sectionController.fetchSection();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Add Modifier", ""),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          buildTextFieldWithHeading("Title", _titleController),
          const SizedBox(height: 5),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text(
              "Modifier Type",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                border: Border.all(color: Theme.of(context).highlightColor)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).highlightColor,
                  ),
                ),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items.padLeft(10),
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                  // print(dropdownvalue);
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text(
              "Select Section",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
            ),
          ),
          GetBuilder<SectionController>(
              builder: (SectionController controller) {
            return Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).highlightColor)),
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.all(10),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  value: _selectedItem,
                  items: sectionController.dropdownSectionList
                      .asMap()
                      .entries
                      .map((entry) => DropdownMenuItem(
                            child: customText(entry.value["sectionName"],
                                color: Theme.of(context).highlightColor),
                            value: entry.value["sectionName"],
                            onTap: () {
                              selectedSectionId = entry.value["id"];

                              setState(() {});
                            },
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value.toString();
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Select Section',
                      labelStyle:
                          TextStyle(color: Theme.of(context).highlightColor)),
                ),
              ),
            );
          }),
          
          const SizedBox(height: 10),
          description("Description", context, descriptionController),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 100,
                  //  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: TextButton(
                    child: customText(
                      'Save',
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onPressed: () {
                      if (_titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        if (dropdownvalue == "Addons") {
                          controller.addModifierGroupPost(
                              _titleController.text,
                              descriptionController.text,
                              1,
                              int.parse(selectedSectionId.toString()));
                        } else {
                          controller.addModifierGroupPost(
                              _titleController.text,
                              descriptionController.text,
                              2,
                              int.parse(selectedSectionId.toString()));
                        }
                      } else {
                        snackBarBottom("Error",
                            "Please Enter the Required Field", context);
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Editmodifier()));
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 100,
                  //  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5.0),
                    //  color: Theme.of(context).primaryColor,
                  ),
                  child: TextButton(
                    child: customText(
                      'Cancel',
                      color: Theme.of(context).highlightColor,
                    ),
                    onPressed: () {
                      Get.back();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Editmodifier()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ])));
  }

  Widget buildTextFieldWithHeading(
      String heading, TextEditingController controller) {
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
                keyboardType: TextInputType.text,
                controller: controller,
                style: TextStyle(color: Theme.of(context).highlightColor),
                decoration: InputDecoration(
                  hintText: "Enter $heading...",
                  hintStyle: TextStyle(color: Theme.of(context).highlightColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

Widget description(String heading, BuildContext context,
    TextEditingController descriptionController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          heading,
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 100,
          width: 378,
          decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              border: Border.all(color: Theme.of(context).highlightColor),
              borderRadius: BorderRadius.circular(5)),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(color: Theme.of(context).highlightColor),
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: "Enter $heading...",
              hintStyle: TextStyle(color: Theme.of(context).highlightColor),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            ),
          ),
        ),
      ),
    ],
  );
}
