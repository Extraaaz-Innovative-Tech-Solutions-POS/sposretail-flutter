import 'dart:ffi';

import 'package:spos_retail/controllers/additional_info_controller.dart';
import 'package:spos_retail/views/widgets/export.dart';

class OngoingOrder extends StatefulWidget {
  bool businessType;

  OngoingOrder({super.key, required this.businessType});

  @override
  State<OngoingOrder> createState() => _OngoingOrderState();
}

class _OngoingOrderState extends State<OngoingOrder> {
  final allLiveOrderController = Get.put(AllLiveOrderController());
  final infoController = Get.put(AdditionalInfoController());

  @override
  void initState() {
    super.initState();
    allLiveOrderController.fetchallLiveOrder();
    infoController.getAdditionalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<AllLiveOrderController>(
        builder: (AllLiveOrderController controller) {
      return Column(
        children: [
          WillPopScope(
              child: widget.businessType
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: allLiveOrderController.allLiveOrder.length,
                          itemBuilder: (context, index) {
                            if (allLiveOrderController
                                    .allLiveOrder[index].orderType !=
                                "Catering") {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                  border: Border.all(
                                      color: Theme.of(context).highlightColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => ShowOngoingOrder(
                                      gst: infoController.gstNo.value,
                                      fssai: infoController.fssai.value,
                                          price: 100,
                                          paymentcount: 1,
                                          ordertype: allLiveOrderController
                                              .allLiveOrder[index].orderType,
                                          tableId: allLiveOrderController
                                              .allLiveOrder[index].tableId
                                              .toString(),
                                          items: const [],
                                        ));
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          allLiveOrderController
                                              .allLiveOrder[index].status!
                                              .toUpperCase(),
                                          style: TextStyle(
                                              letterSpacing: 3,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(children: [
                                        Text('Order Type:',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .highlightColor)),
                                        const SizedBox(width: 8),
                                        Text(
                                            allLiveOrderController
                                                .allLiveOrder[index].orderType
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .highlightColor)),
                                      ]),
                                      // Row(
                                      //   children: [
                                      //     Text('Item Count:',
                                      //         style: TextStyle(
                                      //             color: Theme.of(context)
                                      //                 .highlightColor)),
                                      //     const SizedBox(width: 8),
                                      //     Text('',
                                      //         style: TextStyle(
                                      //             color: Theme.of(context)
                                      //                 .highlightColor))
                                      //   ],
                                      // ),
                                      Row(
                                        children: [
                                          Text('Total Bill:',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor)),
                                          const SizedBox(width: 8),
                                          Text(
                                              allLiveOrderController
                                                  .allLiveOrder[index].total
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor)),
                                        ],
                                      ),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Advance"
                                          ? Text(
                                              "Amt. Paid: ${allLiveOrderController.allLiveOrder[index].totalGivenAmount.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            )
                                          : const SizedBox.shrink(),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Dine"
                                          ? Text(
                                              "Table: ${allLiveOrderController.allLiveOrder[index].tableNumber.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            )
                                          : const SizedBox.shrink(),

                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Advance"
                                          ? customText(
                                              "Amt. Pending: ${allLiveOrderController.allLiveOrder[index].remainingMoney.toString()}",
                                              color: Theme.of(context)
                                                  .highlightColor,
                                            )
                                          : const SizedBox.shrink(),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Dine"
                                          ? Text(
                                              "Floor: ${allLiveOrderController.allLiveOrder[index].floorNumber.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }))
                  : Expanded(
                      child: ListView.builder(
                          itemCount: allLiveOrderController.allLiveOrder.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                  border: Border.all(
                                      color: Theme.of(context).highlightColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => ShowOngoingOrder(
                                      gst: infoController.gstNo.value,
                                      fssai: infoController.fssai.value,

                                          price: allLiveOrderController
                                              .allLiveOrder[index].total, //100,

                                          paymentcount: 1,
                                          ordertype: allLiveOrderController
                                              .allLiveOrder[index].orderType,
                                          tableId: allLiveOrderController
                                              .allLiveOrder[index].tableId
                                              .toString(),
                                          items: const [],
                                        ));
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          allLiveOrderController
                                              .allLiveOrder[index].status!
                                              .toUpperCase(),
                                          style: TextStyle(
                                              letterSpacing: 3,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(children: [
                                        customText('Order Type:',
                                            color: Theme.of(context)
                                                .highlightColor),
                                        const SizedBox(width: 8),
                                        customText(
                                            allLiveOrderController
                                                .allLiveOrder[index].orderType
                                                .toString()
                                                .toUpperCase(),
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ]),
                                      Row(
                                        children: [
                                          customText('Total Bill:',
                                              color: Theme.of(context)
                                                  .highlightColor),
                                          const SizedBox(width: 8),
                                          customText(
                                              allLiveOrderController
                                                  .allLiveOrder[index].total
                                                  .toString(),
                                              color: Theme.of(context)
                                                  .highlightColor),
                                        ],
                                      ),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Advance"
                                          ? Text(
                                              "Amt. Paid: ${allLiveOrderController.allLiveOrder[index].totalGivenAmount.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            )
                                          : const SizedBox.shrink(),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Advance"
                                          ? Text(
                                              "Amt. Pending: ${allLiveOrderController.allLiveOrder[index].remainingMoney.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            )
                                          : const SizedBox.shrink(),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Advance"
                                          ? Text(
                                              "Customer Name: ${allLiveOrderController.allLiveOrder[index].customer?.name.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            )
                                          : const SizedBox.shrink(),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Advance"
                                          ? Text(
                                              "Customer Address: ${allLiveOrderController.allLiveOrder[index].customer?.address.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            )
                                          : const SizedBox.shrink(),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Dine"
                                          ? Text(
                                              "Table: ${allLiveOrderController.allLiveOrder[index].tableNumber.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            )
                                          : const SizedBox.shrink(),
                                      allLiveOrderController.allLiveOrder[index]
                                                  .orderType ==
                                              "Dine"
                                          ? customText(
                                              "Floor: ${allLiveOrderController.allLiveOrder[index].floorNumber.toString()}",
                                              color: Theme.of(context)
                                                  .highlightColor,
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
              onWillPop: () async {
                Get.to(BottomNav(pageindex: 1));
                return false;
              })
        ],
      );
    }));
  }
}
