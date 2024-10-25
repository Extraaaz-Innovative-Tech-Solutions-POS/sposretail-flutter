import 'package:spos_retail/views/widgets/export.dart';


class MoneyInList extends StatelessWidget {
  const MoneyInList({super.key});


  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: commonAppBar(context, "MoneyIn List", ''),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // GetBuilder<MoneyinlistController>(builder: (mc) {
                //   return CustomDropdown(
                //     currentValue: mc.selectedTimePeriod.value,
                //     items: <String>[
                //       'Today',
                //       'Last Week',
                //       'Last Month',
                //       'Last Year',
                //     ],
                //     onChanged: (String? newValue) {
                //       if (newValue != null) {
                //         mc.changeTimePeriod(newValue);
                //       }
                //     },
                //   );
                // }),
            
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customText("From".padRight(6),
                            color: Theme.of(context).highlightColor),
                        GetBuilder<MoneyinlistController>(builder: (rc) {
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
                        GetBuilder<MoneyinlistController>(builder: (rc) {
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
              margin: const EdgeInsets.only(right: 8,left: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10)
              ),
              padding: const EdgeInsets.all(8), // Optional padding
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                children: [
                  const Text("Amount"),
                  const SizedBox(height: 2,),
                  GetBuilder<MoneyinlistController>(
                    builder: (mc) {
                      return Text("₹ ${mc.totalDeposit.value}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w100));
                    }
                  ),
                ],
              ),
            ),
                  ),
                  Expanded(
            flex: 4, // 40% of the total width
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(8), // Optional padding
               decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                 borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Count"),
                  const SizedBox(height: 2,),
                  GetBuilder<MoneyinlistController>(
                    builder: (mc) {
                      return Text("${mc.moneyDepositModelList.length}", style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w100));
                    }
                  ),
                ],
              ),
            ),
                  ),
                 
                ],
              ),
            ),
            
            
            const SizedBox(height: 20,),
            
            
                GetBuilder<MoneyinlistController>(builder: (mc) {
                  return CustomDropdown(
                    currentValue: mc.selectedFilter.value,
                    items: const <String>[
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
          
          
                GetBuilder<MoneyinlistController>(
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
                  Get.to(const MoneyInOutForm());
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
                      "Add Money In",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ))),
          ),
        )
        );
  }
}
