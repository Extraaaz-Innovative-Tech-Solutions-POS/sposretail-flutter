import 'package:spos_retail/views/widgets/export.dart';

class MoneyInOut extends StatelessWidget {
  const MoneyInOut({super.key});

  @override
  Widget build(BuildContext context) {
   final  moneyinlistController = Get.put(MoneyinlistController());
    final  moneyoutlistController = Get.put(MoneyoutlistController());

        // Create TextEditingControllers and initialize with values from the controller
    final receiptNoController = TextEditingController(text: moneyinlistController.receiptNo.value);
    final amountReceivedController = TextEditingController(text: moneyinlistController.amountReceived.value.toString());
    return Scaffold(
      appBar: commonAppBar(
        context, "Money In", '',
        action: [
          IconButton(
            onPressed: (){},
             icon: Icon(Icons.edit)
             ),

              IconButton(
            onPressed: (){
              moneyinlistController.deleteMoneyInOut(moneyinlistController.moneyInOutId.value);
            },
             icon: Icon(Icons.delete)
             ),
        ]
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: receiptNoController,
              style: TextStyle(color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                labelText: 'Receipt No',
                border: OutlineInputBorder(),
                focusColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,

                                enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).highlightColor, width: 1),

      
    ),
                
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
                        enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).highlightColor, width: 1),
    ),
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
                  border: Border.all(width: 1,color: Theme.of(context).highlightColor),
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
                    child: Text( "${moneyinlistController.customer.value}" ,style: TextStyle(color: Theme.of(context).highlightColor),)
   

                     )
                   ),
               ),

            SizedBox(height: 16.0),
            TextField(
              controller: amountReceivedController,
               style: TextStyle(color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                labelText: 'Amount Received',
                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).highlightColor,width: 1)),
                  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).highlightColor, width: 1),
    ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => moneyinlistController.amountReceived.value =
                  double.tryParse(value) ?? 0.0,
            ),
            SizedBox(height: 20.0),

            // Payment method buttons
            // Payment method buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // UPI Button
                GetBuilder<MoneyinlistController>(builder: (controller) {
                  return ElevatedButton(
                    onPressed: () {
                      controller.selectPayment('UPI');
                    },
                    child: Text('UPI',
                      style: TextStyle(
                        color: controller.selectedPaymentMethod == 'UPI'
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedPaymentMethod == 'UPI'
                          ? Theme.of(context).primaryColor // Active color for selected
                          : Theme.of(context).highlightColor, // Default color for unselected
                    ),
                  );
                }),
                const SizedBox(width: 10),
                // Cash Button
                GetBuilder<MoneyinlistController>(builder: (controller) {
                  return ElevatedButton(
                    onPressed: () {
                      controller.selectPayment('Cash');
                    },
                    child: Text('Cash',
                      style: TextStyle(
                        color: controller.selectedPaymentMethod == 'Cash'
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedPaymentMethod == 'Cash'
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).highlightColor,
                    ),
                  );
                }),
                const SizedBox(width: 10),
                // Cheque Button
                GetBuilder<MoneyinlistController>(builder: (controller) {
                  return ElevatedButton(
                    onPressed: () {
                      controller.selectPayment('Cheque');
                    },
                    child: Text('Cheque',
                      style: TextStyle(
                        color: controller.selectedPaymentMethod == 'Cheque'
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedPaymentMethod == 'Cheque'
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).highlightColor,
                    ),
                  );
                }),
              ],
            ),
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
              // if (moneyinlistController.isDeposit.value) {
              //   moneyinlistController.postMoneyIn();
              // } else {
              //   moneyoutlistController.postMoneyOut();
              // }

              moneyinlistController.updateMoneyInOut(
                moneyinlistController.amountReceived.value.toString(),
                  moneyinlistController.selectedPaymentMethod.value,
                  moneyinlistController.moneyInDate.value,
                   moneyinlistController.receiptNo.value, 
                   moneyinlistController.moneyInOutId.value,
                    moneyinlistController.paymentType.value
                );

                print("checking on tap of updtae ....");

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
                "Update",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
