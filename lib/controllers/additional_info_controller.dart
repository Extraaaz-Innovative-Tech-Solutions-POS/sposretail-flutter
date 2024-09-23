import 'package:spos_retail/views/widgets/export.dart';

class AdditionalInfoController extends GetxController {

  RxString notes = "".obs;
  RxString gstNo = "".obs;
  RxString fssai = "".obs;


   getAdditionalInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    notes.value = pref.getString("AddNote").toString();
    gstNo.value = pref.getString("gstNo").toString();
    fssai.value = pref.getString("fssai").toString();
    update();
  }

  saveInfo(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("gstNo", gstNo.value);
    pref.setString("fssai", fssai.value);
    pref.setString("AddNote", notes.value).whenComplete(
      () {
        snackBarBottom("Sucess", "Saved Sucessfully", context);
        getAdditionalInfo();
        update();
      },
    );
  }
}