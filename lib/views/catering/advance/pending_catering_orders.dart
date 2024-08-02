import 'package:spos_retail/views/widgets/export.dart';

class CateringPendingOrderList extends StatefulWidget {
  const CateringPendingOrderList({super.key});

  @override
  State<CateringPendingOrderList> createState() => _CateringPendingOrderState();
}

class _CateringPendingOrderState extends State<CateringPendingOrderList> {
  final DeliveryController advanceController = Get.put(DeliveryController());
  final customerController = Get.put(CustomerlistController());
  @override
  void initState() {
    super.initState();
    advanceController.cateringAdvancedPendingOrder();
    customerController.getcustomerlist();
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
                return controller.cateringAdvanceOrderList.isEmpty
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
                          itemCount: controller.cateringAdvanceOrderList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ShowOngoingOrder(
                                  totalGivenAmount: controller.cateringAdvanceOrderList[index].totalGivenAmount.toString()??"0",
                                  remainingAmount: controller.cateringAdvanceOrderList[index].remainingMoney.toString()??"0",
                                  totalAmount: controller.cateringAdvanceOrderList[index].total.toString()??"0",
                                      ordertype: "Catering",
                                      tableId: controller
                                          .cateringAdvanceOrderList[index]
                                          .tableId
                                          .toString(),
                                      price: controller
                                          .cateringAdvanceOrderList[index]
                                          .remainingMoney,
                                      paymentcount: controller
                                              .cateringAdvanceOrderList[index]
                                              .payments
                                              ?.length ??
                                          0,
                                      items: [],
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
                                    cardDetails(
                                        "Order Type:- ${controller.cateringAdvanceOrderList[index].orderType!}"),
                                    cardDetails(
                                        "Remaning Amount:- ₹${controller.cateringAdvanceOrderList[index].remainingMoney!}"),
                                    cardDetails(
                                        "Total:- ₹${controller.cateringAdvanceOrderList[index].total}"),
                                    cardDetails(
                                        "Date:- ${controller.cateringAdvanceOrderList[index].order_date}"),
                                    cardDetails(
                                        "Cust Name:- ${controller.cateringAdvanceOrderList[index].customer!.name}"),
                                    cardDetails(
                                        "Invoice Id:- ${controller.cateringAdvanceOrderList[index].id}"),
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
                Get.to(() => const CateringAdvance(
                      ordertype: "Catering",
                    ));

                //Get.to(const AdvanceOrder());////cattttttttttttttttttttttttttttt
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
