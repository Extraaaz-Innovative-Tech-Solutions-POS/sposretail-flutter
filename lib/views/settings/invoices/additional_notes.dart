import 'package:spos_retail/controllers/additional_info_controller.dart';

import '../../widgets/export.dart';


class AdditionalInfo extends StatelessWidget {
  final infoController = Get.put(AdditionalInfoController());
  AdditionalInfo({super.key});
  
  @override
  Widget build(BuildContext context) {


    Widget infoTextField(hint,{onchanged}) {
  return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  color: Theme.of(context).focusColor,
                  child: TextField(
                    onChanged: onchanged,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Theme.of(context).highlightColor),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                        ),
                        hintText: hint,
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ));
 }


    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Additional Notes", ""),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Add Notes",
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor),
              ),
            ),
            infoTextField('Enter Your Note',onchanged: (i) {
                      infoController.notes.value = i;
                    }),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  infoController.saveNotes(context);                
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
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    border:
                        Border.all(color: Theme.of(context).highlightColor)),
                child: GetBuilder<AdditionalInfoController>(
                  builder: (c) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: customText(c.notes.value,
                        color: Theme.of(context).primaryColor, 
                      ),
                    );
                  }
                ),
              ),
          ],
        ));
        
  }

 
}
