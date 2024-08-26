import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spos_retail/constants/constant.dart';
import 'package:spos_retail/controllers/modifier_controller/add_Modifier_controller.dart';
import 'package:spos_retail/controllers/modifier_controller/update_modifiers_controller.dart';
import 'package:spos_retail/views/widgets/app_bar.dart';

class AddModifierUI extends StatefulWidget {
  String? modifierId;
  String? modifierName;
  String? modifierprice;
  String? modifierDescription;
  bool click;

  AddModifierUI({
    Key? key,
    this.modifierId,
    required this.click,
    this.modifierName,
    this.modifierDescription,
    this.modifierprice,
  });
  // const AddModifierUI({super.key});

  @override
  State<AddModifierUI> createState() => _AddModifierUIState();
}

class _AddModifierUIState extends State<AddModifierUI> {
  // late int _selectedIndex;
  // late List<String> _buttonTitles;
  bool modifierRestrict = false;
  bool itemRestrict = false;
  late TextEditingController _titleController;
  // final _modifierGroupController = TextEditingController();
  late TextEditingController _priceController;
  late final TextEditingController _descriptionController;
  final addModifierController = Get.put(AddModifierContoller());
  final _updateModifierController = Get.put(UpdateModifier());
  @override
  void initState() {
    super.initState();
    // getcustomercontroller.getcustomerlist();
    // getcustomercontroller.getcustomerlist(widget.customerId);

    _titleController =
        TextEditingController(text: widget.click ? widget.modifierName : "");
    _priceController =
        TextEditingController(text: widget.click ? widget.modifierprice : "");
    _descriptionController = TextEditingController(
        text: widget.click ? widget.modifierDescription : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(
            context, widget.click ? "Update Sub Items" : "Add Sub Items", ""),
        body: Column(
          children: [
            Expanded(child: basicinfo(context)),
          ],
        ));
  }

  textwhite() {
    return TextStyle(color: Theme.of(context).highlightColor);
  }

  Widget basicinfo(context) {
    //return Container();
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 50,
          alignment: Alignment.centerLeft,
          child: customText(
            "Modifiers",
            font: 16.0,
            color: Theme.of(context).highlightColor,
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
         buildTextFieldWithHeading("Title", context, _titleController, "Title"),
         const SizedBox(height: 5),
         buildTextFieldWithHeading("Price", context, _priceController, "Price"),
        const SizedBox(height: 5),
         description(
             "Description", context, _descriptionController, "Description"),
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Container(
              height: 40,
              width: 100,
              //  alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5.0),
                //color: Theme.of(context).primaryColor,
              ),
              child: TextButton(
                child: Center(
                  child: customText(
                    widget.click ? 'Update' : 'Add',
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _priceController.text.isNotEmpty) {
                    widget.click
                        ? _updateModifierController.updateModifier(
                            widget.modifierId??"1",
                            _titleController.text,
                            _priceController.text,
                            _descriptionController.text)
                        : addModifierController.addModifierpost(
                            _titleController.text,
                            _descriptionController.text,
                            _priceController.text);
                  } else {
                    snackBarBottom(
                        "Error", "Please enter the required field", context);
                  }
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildTextFieldWithHeading(String heading, BuildContext context,
      TextEditingController controller, String hinttext) {
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    hintText: "Enter $hinttext",
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
            )),
      ],
    );
  }

  Widget description(
      String heading, BuildContext context, controller, String hinttext) {
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
            height: 100,
            width: 378,
            decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                border: Border.all(color: Theme.of(context).highlightColor),
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              style: TextStyle(color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter $hinttext",
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
