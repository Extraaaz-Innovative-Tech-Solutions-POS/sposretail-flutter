import 'package:spos_retail/controllers/moneyManagement/moneyinlist_controller.dart';
import 'package:spos_retail/controllers/moneyManagement/moneyoutlist_controller.dart';
import 'package:spos_retail/views/MoneyManagement/moneyin_form.dart';
import 'package:spos_retail/views/MoneyManagement/moneyin_list.dart';
import 'package:spos_retail/views/MoneyManagement/custom_dropdown.dart';
import 'package:spos_retail/views/widgets/export.dart';
import 'package:spos_retail/views/MoneyManagement/money_listItem.dart';

class MoneyOutList extends StatelessWidget {
  const MoneyOutList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, "MoneyOut List", ''),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                GetBuilder<MoneyoutlistController>(builder: (mc) {
                  return CustomDropdown(
                    currentValue: mc.selectedTimePeriod.value,
                    items: <String>[
                      'Today',
                      'Last Week',
                      'Last Month',
                      'Last Year',
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        mc.changeTimePeriod(newValue);
                      }
                    },
                  );
                }),
            
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customText("From".padRight(6),
                            color: Theme.of(context).highlightColor),
                        GetBuilder<MoneyoutlistController>(builder: (rc) {
                          return datePick(context, false,
                              title: rc.formattedEndDate.isNotEmpty
                                  ? rc.formattedEndDate
                                  : null,
                              color: Theme.of(context).highlightColor, onpress: () {
                            rc.endDatePicker(context);
                          });
                        }),
                        const SizedBox(width: 5),
                        customText("To".padRight(4),
                            color: Theme.of(context).highlightColor),
                        GetBuilder<MoneyoutlistController>(builder: (rc) {
                          return datePick(context, false,
                              title: rc.formattedEndDate.isNotEmpty
                                  ? rc.formattedEndDate
                                  : null,
                              color: Theme.of(context).highlightColor, onpress: () {
                            rc.endDatePicker(context);
                          });
                        }),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                ),
            
            
            
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
            flex: 4, // 40% of the total width
            child: Container(
              margin: EdgeInsets.only(right: 8,left: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8), // Optional padding
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                children: [
                  Text("Amount"),
                  SizedBox(height: 2,),
                  GetBuilder<MoneyoutlistController>(
                    builder: (mc) {
                      return Text("₹ ${mc.totalDeposit.value}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100));
                    }
                  ),
                ],
              ),
            ),
                  ),
                  Expanded(
            flex: 4, // 40% of the total width
            child: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(8), // Optional padding
               decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                 borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Count"),
                  SizedBox(height: 2,),
                  GetBuilder<MoneyoutlistController>(
                    builder: (mc) {
                      return Text("${mc.moneyDepositModelList.length}", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100));
                    }
                  ),
                ],
              ),
            ),
                  ),
                  Expanded(
            flex: 2, // 20% of the total width
            child: Container(
                margin: EdgeInsets.only(right: 8),
               decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                 borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8), // Optional padding
              child: IconButton(
                onPressed: () {
                  // Your delete action here
                },
                icon: Icon(Icons.delete, size: 30,),
              ),
            ),
                  ),
                ],
              ),
            ),
            
            
            SizedBox(height: 20,),
            
            
                GetBuilder<MoneyoutlistController>(builder: (mc) {
                  return CustomDropdown(
                    currentValue: mc.selectedFilter.value,
                    items: <String>[
                      'All',
                      'Cash',
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        mc.changeFilter(newValue);
                      }
                    },
                  );
                }),
            
                // Other widgets can go here
          
          
                GetBuilder<MoneyoutlistController>(
                  builder: (mc) {
                    return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mc.moneyDepositModelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("Length of inout :${mc.moneyDepositModelList.length}");
                      return MoneyListItem(customerName: mc.moneyDepositModelList[index].userId.toString(), money: mc.moneyDepositModelList[index].amount, paymentMethod: mc.moneyDepositModelList[index].paymentMethod, date: mc.moneyDepositModelList[index].moneyInDate.toString());
                    });
                  }
                ),
          
          
                
          
          
          
          
          
          
          
          
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin:
              const EdgeInsets.only(bottom: 16, right: 16), // Adjust position
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(40),
            child: InkWell(
                onTap: () {
                  final moneyinController = Get.put(MoneyinlistController());
                  moneyinController.isDeposit.value= false;
                  Get.to(MoneyInOutForm());
                },
                child: Container(
                    width: 150, // Set the width
                    height: 50, // Set the height
                   
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                       color: Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Withdraw Money ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ))),
          ),
        )
        );
  }
}