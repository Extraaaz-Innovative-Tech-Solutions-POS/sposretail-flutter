import 'package:spos_retail/model/common_model.dart' as cm;
import 'package:spos_retail/views/widgets/export.dart';

class TaxesController extends GetxController {
  var sgst;
  var cgst;
  Future<void> addtaxescontroller(
      String gst, String sGst, String vat, int status) async {
    try {
      cm.AddTaxes taxesdata =
          cm.AddTaxes(gst: gst, sGst: sGst, vat: vat, status: status);
      var response =
          await DioServices.postRequest(AppConstant.taxes, taxesdata.toJson());
      if (response.statusCode == 200) {
        Get.back();
        Fluttertoast.showToast(msg: "Taxes Added Sucessfully");
        print("Taxes Added sucessfully");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> gettaxesController() async {
    try {
      var response = await DioServices.get(AppConstant.gettaxes);
      if (response.statusCode == 200) {
        cgst = response.data['data']['cgst'].toString();
        sgst = response.data['data']['sgst'].toString();
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
