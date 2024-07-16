import 'package:spos_retail/model/billing_details.dart';
import 'package:spos_retail/views/widgets/export.dart';

class InvoiceController extends GetxController {
  List<BillingDetail> allInvoiceList = [];

  void allInvoices() async {
    try {
      final response = await DioServices.get(AppConstant.invoices);

      if (response.statusCode == 200) {
        print("im on sucess ${response.data}");
        allInvoiceList = response.data['billingDetails']
            .map<BillingDetail>((json) => BillingDetail.fromJson(json))
            .toList();
        //print("my length is ${allInvoiceList.length.toString()}");
        update();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    }
  }
}
