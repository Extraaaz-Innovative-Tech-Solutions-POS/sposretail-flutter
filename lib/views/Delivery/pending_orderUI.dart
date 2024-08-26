import 'package:spos_retail/views/widgets/export.dart';

class PendingOrderUI extends StatefulWidget {
  bool? advance;
  bool? catering;
  PendingOrderUI({super.key, required this.advance, required this.catering});

  @override
  State<PendingOrderUI> createState() => _PendingOrderUIState();
}

class _PendingOrderUIState extends State<PendingOrderUI>
    with TickerProviderStateMixin {
  final pendingOrderController = Get.put(DeliveryController());
  late TabController _tabController;
  @override
  void initState() {
    super.initState();

    pendingOrderController.pendingOrder();
    pendingOrderController.advancedPendingOrder();
    pendingOrderController.outforDelivery();
    pendingOrderController.getDeliveryCompletedOrders();
    _tabController = TabController(length: 3, vsync: this);
    // setState(() {});
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            appBar: AppBar(
              iconTheme: IconThemeData(color: Theme.of(context).highlightColor),
              backgroundColor: Colors.transparent,
              title: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "Pending Order", style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              bottom: TabBar(
                labelColor: Theme.of(context).primaryColor,
                indicatorColor: Theme.of(context).primaryColor,
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(
                    text: "Orders",
                  ),
                  Tab(
                    text: "Dispatched",
                  ),
                  Tab(
                    text: "Delivered",
                  ),
                ],
              ),
            ),
            body: TabBarView(controller: _tabController, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<DeliveryController>(
                      builder: (DeliveryController controller) {
                    return controller.pendingOrderList.isEmpty
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
                              itemCount: widget.advance!
                                  ? controller.pendingAdvanceOrderList.length
                                  : widget.catering!
                                      ? controller
                                          .cateringAdvanceOrderList.length
                                      : controller.pendingOrderList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ShowOngoingOrder(
                                      totalGivenAmount: controller.pendingAdvanceOrderList[index].totalGivenAmount.toString()??"0",
                                  remainingAmount: controller.pendingAdvanceOrderList[index].remainingMoney.toString()??"0",
                                  totalAmount: controller.pendingAdvanceOrderList[index].total.toString()??"0",
                                          customerId: controller
                                              .pendingOrderList[index]
                                              .customerId,
                                          ordertype: widget.advance!
                                              ? "Advance"
                                              : widget.catering!
                                                  ? "Catering"
                                                  : "Delivery",
                                          tableId: widget.advance!
                                              ? controller
                                                  .pendingAdvanceOrderList[
                                                      index]
                                                  .tableId
                                                  .toString()
                                              : widget.catering!
                                                  ? controller
                                                      .cateringAdvanceOrderList[
                                                          index]
                                                      .tableId
                                                      .toString()
                                                  : controller
                                                      .pendingOrderList[index]
                                                      .tableId
                                                      .toString(),
                                          items: const [],
                                          //  orderData: orders.toJson(),
                                        ));
                                  },
                                  child: Container(
                                    // height: 120.0,
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).focusColor,
                                      border: Border.all(
                                          color:
                                              Theme.of(context).highlightColor),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 18.0),
                                          child: Text(
                                            widget.advance!
                                                ? controller
                                                    .pendingAdvanceOrderList[
                                                        index]
                                                    .status
                                                    .toString()
                                                : widget.catering!
                                                    ? controller
                                                        .cateringAdvanceOrderList[
                                                            index]
                                                        .status
                                                        .toString()
                                                    : controller
                                                        .pendingOrderList[index]
                                                        .status
                                                        .toString()
                                                        .toUpperCase(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "CustomerID:- ${controller.pendingOrderList[index].customerId!}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              widget.advance!
                                                  ? "Order Type:- ${controller.pendingAdvanceOrderList[index].orderType!}"
                                                  : widget.catering!
                                                      ? controller
                                                          .cateringAdvanceOrderList[
                                                              index]
                                                          .orderType!
                                                      : "Order Type:- ${controller.pendingOrderList[index].orderType!}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              widget.advance!
                                                  ? "Total:- ₹${controller.pendingAdvanceOrderList[index].total!}"
                                                  : widget.catering!
                                                      ? controller
                                                          .cateringAdvanceOrderList[
                                                              index]
                                                          .total
                                                          .toString()
                                                      : "Total:- ₹${controller.pendingOrderList[index].total!}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              widget.advance!
                                                  ? "Item:- ${controller.pendingAdvanceOrderList[index].items!.length}"
                                                  : widget.catering!
                                                      ? controller
                                                          .cateringAdvanceOrderList[
                                                              index]
                                                          .items!
                                                          .length
                                                          .toString()
                                                      : "Item:- ${controller.pendingOrderList[index].items!.length}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<DeliveryController>(
                      builder: (DeliveryController controller) {
                    return controller.outForDeliveryList.isEmpty
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
                              itemCount: controller.outForDeliveryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    //height: 120.0,
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).focusColor,
                                      border: Border.all(
                                          color:
                                              Theme.of(context).highlightColor),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 18.0),
                                          child: Text(
                                            controller.outForDeliveryList[index]
                                                .status
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "Order Type:- ${controller.outForDeliveryList[index].orderType!}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "Name:- ${controller.outForDeliveryList[index].customer!.name.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "Address:- ${controller.outForDeliveryList[index].customer!.address.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "Total:- ₹${controller.outForDeliveryList[index].total!}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              controller.updateStatusOfDelivery(
                                                  controller
                                                      .outForDeliveryList[index]
                                                      .tableId
                                                      .toString());
                                            },
                                            child: const Text(
                                              "Mark Delivered",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 8, 241, 16),
                                                  fontSize: 16.0,
                                                  letterSpacing: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ))
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<DeliveryController>(
                      builder: (DeliveryController controller) {
                    return controller.completedDeliveryOrdersList.isEmpty
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
                              itemCount:
                                  controller.completedDeliveryOrdersList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    //height: 120.0,
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).focusColor,
                                      border: Border.all(
                                          color:
                                              Theme.of(context).highlightColor),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 18.0),
                                          child: Text(
                                            controller
                                                .completedDeliveryOrdersList[
                                                    index]
                                                .status
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "Order Type:- ${controller.completedDeliveryOrdersList[index].orderType!}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "Name:- ${controller.completedDeliveryOrdersList[index].customer!.name.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "Address:- ${controller.completedDeliveryOrdersList[index].customer!.address.toString()}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 18.0),
                                            child: Text(
                                              "Total:- ₹${controller.completedDeliveryOrdersList[index].total!}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
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
            ]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  widget.advance!
                      ? Get.to(const AdvanceOrder())
                      : widget.catering!
                          ? Get.to(() => const CateringAdvance(
                                ordertype: "Advance",
                              )) ////////////////////////cattttttttttttttttttttttttttttttttttttttttttt
                          : Get.to(const CustomerDeliveryDetails());
                },
                label: const Text("New Order"))));
  }
}
