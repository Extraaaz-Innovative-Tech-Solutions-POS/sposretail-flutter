
import '../views/widgets/export.dart';

class PaymentController extends GetxController {
  RxString onlinePaymentAmount = "".obs;
  RxString cashPaymentAmount = "".obs;

  Future<void> onlinePayment() async {
    try {
      final response = await DioServices.get(AppConstant.onlinePayment);
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          print("Your value is null");
        } else {
          onlinePaymentAmount.value = response.data["data"].toString();
          print("Getting value online payment");
        }

        update();
      } else {
        print("Enter in the else loopGetting value online payment");
      }
    } catch (e) {
      print("Enter in the catch loop");
      print(e);
    }
  }

  Future<void> cashPayment() async {
    try {
      final response = await DioServices.get(AppConstant.cashPayment);

      if (response.statusCode == 200) {
        cashPaymentAmount.value = response.data["data"].toString();
        update();
      } else {
        print("Status----------->${response.statusCode}");
      }
    } catch (e) {
      print("Enter in the catch loop");
      print(e);
    }
  }
}
