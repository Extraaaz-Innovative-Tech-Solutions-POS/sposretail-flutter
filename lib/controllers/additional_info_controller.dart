import 'package:spos_retail/views/widgets/export.dart';

class AdditionalInfoController extends GetxController {

  RxString notes = "".obs;


   getAdditionalInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    notes.value = pref.getString("AddNote").toString();
    update();
  }

  saveNotes(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("AddNote", notes.value).whenComplete(
      () {
        snackBarBottom("Sucess", "Note Saved Sucessfully", context);
        getAdditionalInfo();
        update();
      },
    );
  }
}