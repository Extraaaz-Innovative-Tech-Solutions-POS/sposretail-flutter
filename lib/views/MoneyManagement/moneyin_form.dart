import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spos_retail/controllers/moneyManagement/moneyinlist_controller.dart';
import 'package:spos_retail/controllers/moneyManagement/moneyoutlist_controller.dart';

import 'package:spos_retail/views/widgets/app_bar.dart';

class MoneyInOutForm extends StatelessWidget {
  const MoneyInOutForm({super.key});

  @override
  Widget build(BuildContext context) {
    final MoneyinlistController moneyinlistController = Get.put(MoneyinlistController());
    final MoneyoutlistController moneyoutlistController = Get.put(MoneyoutlistController());

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
              onChanged: (value) => moneyinlistController.receiptNo.value = value,
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
                      "${pickedDate.toLocal()}".split(' ')[0]; // format date as needed
                      moneyinlistController.update();

                      print('moneyin date :${moneyinlistController.moneyInDate.value}');
                }
              },
              child: AbsorbPointer(
                child: GetBuilder<MoneyinlistController>(
                  builder: (mc) {
                    return TextField(
                      decoration: InputDecoration(
                        // labelText: 'Money In Date',
                        border: OutlineInputBorder(),
                        hintText: mc.moneyInDate.value.isEmpty
                            ? 'Select Date'
                            : mc.moneyInDate.value,
                      ),
                    );
                  }
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Customer',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => moneyinlistController.customer.value = value,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount Received',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => moneyinlistController.amountReceived.value = double.tryParse(value) ?? 0.0,
            ),

            
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle UPI payment
                  },
                  child: const Text('UPI'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle Cash payment
                  },
                  child: const Text('Cash'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle Cheque payment
                  },
                  child: const Text('Cheque'),
                ),
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

              if(moneyinlistController.isDeposit.value){
                moneyinlistController.postMoneyIn();
              }else{
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
