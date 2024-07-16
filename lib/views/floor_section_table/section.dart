import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spos_retail/controllers/floor_table/section_controller.dart';
import 'package:spos_retail/views/widgets/app_bar.dart';

import '../../constants/widget_constant.dart';

class SectionItem extends StatelessWidget {
  SectionItem({super.key});

  final nameController = TextEditingController();
  final sectionController = Get.put(SectionController());
  final GlobalKey<FormState> _sectionKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Add Section", ""),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            itemForms(
                context, "Section Name", "Enter Section", false, nameController,
                key: _sectionKey),
            ElevatedButton(
                onPressed: () {
                  if (_sectionKey.currentState!.validate()) {
                    sectionController.addSection(nameController.text, "19");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: Text(
                  "Add Section",
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ))
          ],
        ),
      ),
    );
  }
}
