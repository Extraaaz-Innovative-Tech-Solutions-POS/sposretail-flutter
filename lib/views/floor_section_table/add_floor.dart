import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spos_retail/views/widgets/app_bar.dart';

import '../../constants/widget_constant.dart';
import '../../controllers/floor_table/floor_controller.dart';

class AddFloor extends StatelessWidget {
  AddFloor({super.key});

  final nameController = TextEditingController();
  final floorController = Get.put(FloorController());
  final GlobalKey<FormState> _floorKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Add Floor", ""),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            itemForms(
                context, "Floor Number", "Enter Floor", true, nameController,
                key: _floorKey),
            ElevatedButton(
                onPressed: () {
                  if (_floorKey.currentState!.validate()) {
                    floorController.addFloor("Floor ${nameController.text}");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: Text(
                  "Add Floor",
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ))
          ],
        ),
      ),
    );
  }
}
