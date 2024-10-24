
import 'package:spos_retail/views/widgets/export.dart';

class MoneyInOutForm extends StatelessWidget {
  final String? customerId;
  final String? customerName;
  const MoneyInOutForm({super.key, this.customerId, this.customerName});

  @override
  Widget build(BuildContext context) {
    final MoneyinlistController moneyinlistController =
        Get.put(MoneyinlistController());
    final MoneyoutlistController moneyoutlistController =
        Get.put(MoneyoutlistController());

    return Scaffold(
      appBar: commonAppBar(context, "Money In", ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Receipt No',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) =>
                  moneyinlistController.receiptNo.value = value,
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  moneyinlistController.moneyInDate.value =
                      "${pickedDate.toLocal()}"
                          .split(' ')[0]; // format date as needed
                  moneyinlistController.update();

                  print(
                      'moneyin date :${moneyinlistController.moneyInDate.value}');
                }
              },
              child: AbsorbPointer(
                child: GetBuilder<MoneyinlistController>(builder: (mc) {
                  return TextField(
                    decoration: InputDecoration(
                      // labelText: 'Money In Date',
                      border: OutlineInputBorder(),
                      hintText: mc.moneyInDate.value.isEmpty
                          ? 'Select Date'
                          : mc.moneyInDate.value,
                    ),
                  );
                }),
              ),
            ),
            // SizedBox(height: 16.0),


            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Customer',
            //     border: OutlineInputBorder(),
            //   ),
            //   onChanged: (value) =>
            //       moneyinlistController.customer.value = value,
            // ),


               SizedBox(height: 16.0),

               Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 10,top: 10,bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(5)
                ),
                 child: TextButton(
                  onPressed: (){
                    // moneyinlistController.changeIsMoneyInout();
                    moneyinlistController.isMoneyInout.value =true;
                    moneyinlistController.update();
                    print("custome m id: ${  moneyinlistController.isMoneyInout.value} ");

                    Get.to(Customerdetails());
                 
                  },
                   child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(customerId != null ? "$customerName" : "Customer",style: TextStyle(color: Theme.of(context).highlightColor),)
   

                     )
                   ),
               ),

            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount Received',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => moneyinlistController.amountReceived.value =
                  double.tryParse(value) ?? 0.0,
            ),
            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetBuilder<MoneyinlistController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: () {
                        controller.selectPayment('UPI');
                        // Handle UPI payment
                      },
                      child: Text('UPI',
                          style:
                              TextStyle(color:controller.selectedPaymentMethod == 'UPI'
                                ? Theme.of(context).focusColor
                                : Theme.of(context).highlightColor,)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            controller.selectedPaymentMethod == 'UPI'
                                ? Theme.of(context).primaryColor
                                : null,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                GetBuilder<MoneyinlistController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: () {
                        controller.selectPayment('Cash');
                        // Handle Cash payment
                      },
                      child: Text('Cash',
                          style:
                              TextStyle(color:controller.selectedPaymentMethod == 'Cash'
                                ? Theme.of(context).focusColor
                                : Theme.of(context).highlightColor,)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            controller.selectedPaymentMethod == 'Cash'
                                ? Theme.of(context).primaryColor
                                : null,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                GetBuilder<MoneyinlistController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: () {
                        controller.selectPayment('Cheque');
                        // Handle Cheque payment
                      },
                      child: Text(
                        'Cheque',
                        style: TextStyle(color:  controller.selectedPaymentMethod == 'Cheque'
                                ? Theme.of(context).focusColor
                                : Theme.of(context).highlightColor,),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            controller.selectedPaymentMethod == 'Cheque'
                                ? Theme.of(context).primaryColor
                                : null,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16, right: 16),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(40),
          child: InkWell(
            onTap: () {
              if (moneyinlistController.isDeposit.value) {
                moneyinlistController.postMoneyIn();
              } else {
                moneyoutlistController.postMoneyOut();
              }

              // Add any additional actions you want to perform on Save
            },
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.center,
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
