import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spos_retail/controllers/Delivery/delivery_controller.dart';
import 'package:spos_retail/views/order/show_ongoing_order_screen.dart';
import 'package:spos_retail/views/widgets/app_bar.dart';
import 'package:spos_retail/views/widgets/bottom_nav.dart';

import '../order/advance_order.dart';

class PendingAdvanceOrder extends StatefulWidget {
  const PendingAdvanceOrder({super.key});

  @override
  State<PendingAdvanceOrder> createState() => _PendingAdvanceOrderState();
}

class _PendingAdvanceOrderState extends State<PendingAdvanceOrder> {
  final DeliveryController advanceController = Get.put(DeliveryController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advanceController.advancedPendingOrder();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(BottomNav(
          pageindex: 1,
        ));
        return false;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: commonAppBar(context, "Pending Orders", ""),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<DeliveryController>(
                  builder: (DeliveryController controller) {
                return controller.pendingAdvanceOrderList.isEmpty
                    ? Center(
                        child: Text(
                          "NO Order Found",
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 18.0),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.pendingAdvanceOrderList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final pendingOrder =
                                controller.pendingAdvanceOrderList[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ShowOngoingOrder(
                                      ordertype: "Advance",
                                      tableId: controller
                                          .pendingAdvanceOrderList[index]
                                          .tableId
                                          .toString(),
                                      price: controller
                                          .pendingAdvanceOrderList[index]
                                          .remainingMoney,
                                      paymentcount: controller
                                              .pendingAdvanceOrderList[index]
                                              .payments
                                              ?.length ??
                                          0,
                                      items: [],
                                      //  orderData: orders.toJson(),
                                    ));
                              },
                              child: Container(
                                //  height: .0,
                                margin: const EdgeInsets.only(
                                    top: 10.0,
                                    left: 10.0,
                                    right: 10.0,
                                    bottom: 10.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                  border: Border.all(
                                      color: Theme.of(context).highlightColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 18.0),
                                      child: Text(
                                        pendingOrder.status.toString(),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    cardDetails(
                                        "Order Type:- ${pendingOrder.orderType}"),
                                    cardDetails(
                                        "Remaning Amount:- ${pendingOrder.remainingMoney}"),
                                    cardDetails(
                                        "Total:- ${pendingOrder.grandTotal}"),
                                    cardDetails(
                                        "Discount:- ${pendingOrder.totalDiscount ?? "0"}"),
                                    cardDetails(
                                        "Item:- ${pendingOrder.items!.length}"),
                                    cardDetails(
                                        "Date:- ${pendingOrder.advanceOrderDateTime}"),
                                    cardDetails(
                                        "Customer Name:- ${pendingOrder.customer?.name}"),
                                    cardDetails(
                                        "Customer Address:- ${pendingOrder.customer?.address}"),
                                    const SizedBox(
                                      height: 10.0,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
              }),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: () {
                Get.to(const AdvanceOrder());
              },
              label: Text(
                "New Order",
                style:
                    TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
              ))),
    );
  }

  Widget cardDetails(title) {
    return Padding(
        padding: const EdgeInsets.only(top: 2.0, left: 18.0),
        child: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
        ));
  }
}
