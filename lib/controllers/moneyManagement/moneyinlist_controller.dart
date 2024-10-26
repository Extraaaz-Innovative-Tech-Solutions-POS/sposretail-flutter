import 'package:intl/intl.dart';
import 'package:spos_retail/views/widgets/export.dart';

class MoneyinlistController extends GetxController {
  var selectedTimePeriod = 'Today'.obs;

  var selectedFilter = 'All'.obs;

  var receiptNo = ''.obs;
  var moneyInDate = ''.obs;
  var customer = ''.obs;
  var amountReceived = 0.0.obs;
  var isDeposit = true.obs;
  var selectedPaymentMethod = ''.obs;
  var paymentType=''.obs;
  var moneyInOutId=0.obs; 

   var isMoneyInout = false.obs;

  RxDouble totalDeposit = 0.0.obs;

  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String formattedStartDate = "";
  String formattedEndDate = "";

  RxList<MoneyDepositModel> moneyDepositModelList = <MoneyDepositModel>[].obs;

  startDatePicker(context) async {
    DateTime? selectedDate = await showDatePicker(
      // barrierColor: Theme.of(context).highlightColor,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
      lastDate: DateTime.now(),
    );

    startDate = selectedDate as DateTime;
    formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    update();

    return formattedStartDate;
  }

  endDatePicker(context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
      lastDate: DateTime.now(),
    );

    endDate = selectedDate!;
    formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);
    update();
    return endDate;
  }

  void changeTimePeriod(String newPeriod) {
    selectedTimePeriod.value = newPeriod;
    update();
  }

  void changeFilter(String newPeriod) {
    selectedFilter.value = newPeriod;
    update();
  }


void changeIsMoneyInout(){
  isMoneyInout.value == true;
  update();
}

 void selectPayment(String method) {
    selectedPaymentMethod.value = method;
    update();
  }
  void saveForm() {
    // Handle form submission logic here
    print('Receipt No: ${receiptNo.value}');
    print('Money In Date: ${moneyInDate.value}');
    print('Customer: ${customer.value}');
    print('Amount Received: ${amountReceived.value}');
  }





    
  //se EditForm Data


  void setFormData(String receiptno, String moneyinoutDate,String customerId,double moneyInOutAmount, String paymentMethod, String paymenttype, int moneyinoutid){

    receiptNo.value = receiptno;
    amountReceived.value = moneyInOutAmount;
    moneyInDate.value = moneyinoutDate;
    customer.value = customerId;
    selectedPaymentMethod.value =  paymentMethod;
    paymentType.value = paymenttype;
    moneyInOutId.value = moneyinoutid;

    print("data of minout : id${customer.value}  receipt${receiptNo.value} money${amountReceived.value}, mdate${moneyInDate.value}, mmethd${selectedPaymentMethod.value}");
    update();
  }

  ///fetch deposits
  deposits() async {
    try {
      final response = await DioServices.get(AppConstant.deposits);

      if (response.statusCode == 200) {
        moneyDepositModelList.assignAll((response.data['deposits'])
            .map<MoneyDepositModel>(
                (json) => MoneyDepositModel.fromJson(json)));

        double newTotal = 0.0;
        for (var deposit in moneyDepositModelList) {
          newTotal += double.parse(deposit.amount);
        }

        totalDeposit.value = newTotal;
        update();
      }
    } catch (e) {}
  }



  
    Future<void> postMoneyIn() async {
    try {

       MoneyInOutModel moneyInOutModel =
          MoneyInOutModel(receiptNo: "${receiptNo.value}", amount: amountReceived.value, paymentMethod: selectedPaymentMethod.value, moneyInDate: moneyInDate.value, paymentType: "Deposit");

      final response =
          await DioServices.postRequest(AppConstant.moneyInOut, moneyInOutModel.toJson());

      if (response.statusCode == 200) {
      
        snackBar("Success", "Money In Sucessfully");
  
        Fluttertoast.showToast(msg: "Added Sucessfully");
        deposits();
        Get.to(MoneyInList());
        update();

        // print("New Customer Added");
      } else {
        // print("Unsuccessful");
      }
    } catch (e) {
      snackBar("Error", e.toString());
      print("Error occured");
    }
  }





    //
    Future<void> updateMoneyInOut(
  final String money,
  final String paymentMethod,
  final String date,
  final String receiptNo,
  final int minOutId,
  final String paymentType
  ) async {
    try {
      // isLoading.value = true;
      print("Started.........#########");
      final response = await DioServices.put("${AppConstant.updateTransaction}/${minOutId}", {
        "receipt_no": receiptNo,
        "amount": money,
        "payment_method": paymentMethod,
        "money_in_date": date,
        "payment_type": paymentType,
      });
       print("Started.........#########end");
      if (response.statusCode == 200) {
        update();
        // customerlistcontroller.getcustomerlist();
         Get.back();
        snackBar("Success", "Updated Sucessfully");
      }
    } catch (e) {
         print("Started...error $e");
    } finally {
      // isLoading.value = false;
    }
  }



   Future<void> deleteMoneyInOut(int id,) async {
    try {
      final response = await DioServices.delete("${AppConstant.deleteTransaction}/$id");
      if (response.statusCode == 200) {
        // customerListcontroller.getcustomerlist();
        update();
        snackBar("Success", "Deleted Successfully");
      }
    } catch (e) {
      print('Unsuccessful $e');
    }
  }
}
