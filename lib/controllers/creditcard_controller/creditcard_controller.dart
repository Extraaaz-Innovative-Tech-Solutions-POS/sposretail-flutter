

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:spos_retail/views/widgets/export.dart';

class CreditCardController extends GetxController {
  RxDouble creditAmount = 0.0.obs;
  RxBool isCreditCard = false.obs;
  RxString outStanding = ''.obs;

  RxInt restaurantId = 0.obs;

  //  CreditModel creditModel;




  creditCardPost(int? customerId) async {
    // final CartController controller = Get.put(CartController());
    try {

       SharedPreferences pref = await SharedPreferences.getInstance();
       if(restaurantId.value==0){
        restaurantId.value = 1;
        update();
          print("res id :##### ${restaurantId.value}");
       }else{
         restaurantId.value =pref.getInt("RestaurantId")!;
           update();
          print("res id :##### ${restaurantId.value}");
       }
       


      print(" credit started :");
      final response =
          await DioServices.postRequest("pay-outstanding/${customerId}", {
        "customer_id": customerId, //4,
        "paid_amount": 0,
        "restaurant_id": restaurantId.value,
      });
      print("after respone");

      if (response.statusCode == 200) {
        print("credit response :${response.data}");

        print("Response data: ${response.data}");

        if (response.data != null &&
            response.data['outstanding_balance'] != null) {
          outStanding.value = response.data['outstanding_balance'];
           update();
           print("oustd amount : ${outStanding.value}");

          
        } else {
          print("outstanding_balance not found in response.");
        }

        // creditModel.clear();
        // creditModel.add(credit);
        // outStanding.value = credit.orderPayment.outstandingBalance;
        // isCreditCard.value = false;

       

        print("outstd :${outStanding.value}");
      } else {
        snackBar("Error", "Order Failed to Complete");
        print("checking credit error : ${response}");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
