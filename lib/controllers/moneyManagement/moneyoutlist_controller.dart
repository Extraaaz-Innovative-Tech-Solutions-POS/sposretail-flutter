import 'package:intl/intl.dart';
import 'package:spos_retail/controllers/moneyManagement/moneyinlist_controller.dart';
import 'package:spos_retail/model/MoneymanagementModel/money_deposit_model.dart';
import 'package:spos_retail/model/MoneymanagementModel/money_inout_model.dart';
import 'package:spos_retail/views/MoneyManagement/moneyout_list.dart';
import 'package:spos_retail/views/widgets/export.dart';

class MoneyoutlistController extends GetxController {
  var selectedTimePeriod = 'Today'.obs;

  var selectedFilter = 'All'.obs;

  // var receiptNo = ''.obs;
  // var moneyInDate = ''.obs;
  // var customer = ''.obs;
  // var amountReceived = 0.0.obs;

  RxDouble totalDeposit = 0.0.obs;

  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String formattedStartDate = "";
  String formattedEndDate = "";

  RxList<MoneyDepositModel> moneyDepositModelList = <MoneyDepositModel>[].obs;
  final moneyInListController = Get.put(MoneyinlistController());

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

  void saveForm() {
    // Handle form submission logic here
    // print('Receipt No: ${receiptNo.value}');
    // print('Money In Date: ${moneyInDate.value}');
    // print('Customer: ${customer.value}');
    // print('Amount Received: ${amountReceived.value}');
  }

  ///fetch deposits
  withdrawal() async {
    try {
      final response = await DioServices.get(AppConstant.withdrawals);

      if (response.statusCode == 200) {
        moneyDepositModelList.assignAll((response.data['withdrawals'])
            .map<MoneyDepositModel>(
                (json) => MoneyDepositModel.fromJson(json)));

        double newTotal = 0.0;
        for (var deposit in moneyDepositModelList) {
          newTotal += double.parse(deposit.amount);
        }

        totalDeposit.value = newTotal;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }




      Future<void> postMoneyOut() async {
    try {

       MoneyInOutModel moneyInOutModel =
          MoneyInOutModel(receiptNo: moneyInListController.receiptNo.value, amount:moneyInListController. amountReceived.value, paymentMethod: "cash", moneyInDate: moneyInListController.moneyInDate.value, paymentType: "Withdraw");

      final response =
          await DioServices.postRequest(AppConstant.moneyInOut, moneyInOutModel.toJson());

      if (response.statusCode == 200) {
      
        snackBar("Success", "Money In Sucessfully");
  
        Fluttertoast.showToast(msg: "Added Sucessfully");
        withdrawal();
        moneyInListController.isDeposit.value= true;
        Get.to(const MoneyOutList());
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
}
