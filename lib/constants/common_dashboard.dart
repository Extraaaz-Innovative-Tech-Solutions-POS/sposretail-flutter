import 'package:intl/intl.dart';
import 'package:spos_retail/constants/app_constant.dart';
import 'package:spos_retail/views/widgets/export.dart';

//* CommonDashboard Graphs ----------------------->
Widget commondashboardGraphs(
    BuildContext context,
    UserController usercontroller,
    graphController,
    DashboardController dashboardController) {
  return usercontroller.user!.role == "manager"
      ? Container(
          margin: const EdgeInsets.only(top: 12.0),
          //color: Theme.of(context).focusColor,
          height: screenHeight(context, dividedBy: 3.0),
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            border: Border.all(
              color: Theme.of(context)
                  .highlightColor, // Set your desired border color here.
              width: 1.0, // Set the width of the border.
            ),
          ),
          child: GestureDetector(
            onTap: () {
              //dashboardController.fetchDashboard();
              showModalBottomSheet(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                context: context,
                builder: (BuildContext context) {
                  return bottomSheetAnalysis(context, dashboardController);
                },
              );
            },
            child: GetBuilder<GraphController>(builder: (c) {
              return SfCartesianChart(
                series: [
                  //  for (var graphdata in graphController.graphList)
                  ColumnSeries<SalesData, String>(
                    dataSource: List.generate(graphController.graphList.length,
                        (index) {
                      final date =
                          graphController.graphList[index].date as DateTime;
                      final formattedDate = DateFormat('dd').format(date);

                      return SalesData(
                          formattedDate,
                          double.parse(graphController
                              .graphList[index].totalPayment
                              .toString()));
                    }),
                    width: 0.5,
                    // trackBorderWidth: 0,
                    //borderColor: ,
                    borderWidth: 0.3,
                    // trackBorderWidth: 0.0,
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle:
                            TextStyle(color: Theme.of(context).highlightColor)),
                    gradient: LinearGradient(
                        end: Alignment.topCenter, // Start gradient from top
                        begin: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).highlightColor,
                          Theme.of(context).primaryColor,
                        ]),
                  ),
                ],
                primaryXAxis: CategoryAxis(
                  majorGridLines: MajorGridLines(
                      color: Theme.of(context)
                          .focusColor), // Set the color of the x-axis lines
                  majorTickLines:
                      MajorTickLines(color: Theme.of(context).focusColor),
                ),
                primaryYAxis: NumericAxis(
                    majorGridLines: MajorGridLines(
                        color: Theme.of(context)
                            .focusColor), // Set the color of the x-axis lines
                    majorTickLines:
                        MajorTickLines(color: Theme.of(context).focusColor)),
              );
            }),
          ),
        )
      : const SizedBox.shrink();
}

//* Bottom Sheet Analysis-------------------->
Widget bottomSheetAnalysis(context, DashboardController dashboardController) {
  return Container(
    height: screenHeight(context, dividedBy: 1.7),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      gradient: LinearGradient(
          end: Alignment.topLeft, // Start gradient from top
          begin: Alignment.bottomRight,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).focusColor,
          ]),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Analysis',
                style: TextStyle(color: Theme.of(context).highlightColor),
              )),
          spacer(10),
          Expanded(
            child: GridView.builder(
              itemCount: dashboardController
                  .keyValueList.length, // Total number of items
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items in each row
                crossAxisSpacing:
                    10.0, // Spacing between each item horizontally
                mainAxisSpacing: 9.0, // Spacing between each item vertically
                childAspectRatio: 2.45,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (dashboardController.keyValueList[index].key == "success") {
                  return const SizedBox.shrink();
                }
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    color: Theme.of(context).focusColor,
                    borderRadius: const BorderRadius.all(Radius.circular(06)),
                  ),
                  child: Center(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                      title: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        "${dashboardController.keyValueList[index].key}",
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).highlightColor),
                      ),
                      subtitle: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        dashboardController.keyValueList[index].value
                            .toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class SalesData {
  final String year;
  final double sales;

  SalesData(this.year, this.sales);
}

//* Mode of payment------------------>
Widget modeofPayments(BuildContext context, UserController usercontroller,
    PaymentController paymentController) {
  return usercontroller.user!.role == "manager"
      ? Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            children: [
              GetBuilder<PaymentController>(builder: (c) {
                return paymentOptions(context, "Online Payment",
                    paymentController.onlinePaymentAmount.value.toString());
              }),
              const SizedBox(width: 12),
              GetBuilder<PaymentController>(builder: (c) {
                return paymentOptions(context, "Cash Payment",
                    paymentController.cashPaymentAmount.value.toString());
              }),
            ],
          ),
        )
      : const SizedBox.shrink();
}

Widget paymentOptions(context, title, amount) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        border: Border.all(
          color: Theme.of(context)
              .highlightColor, // Set your desired border color here.
          width: 1.0, // Set the width of the border.
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).highlightColor),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.account_balance_wallet,
                color: Theme.of(context).primaryColor.withOpacity(0.2)),
            Text(
              "₹ $amount",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    ),
  );
}

//* Top Selling Product -------------------->
Widget topSellingProduct(BuildContext context, String query) {
  return SizedBox(
    // height: screenHeight(context),
    // child: SingleChildScrollView(child:
    child: GetBuilder<TopSellingDashboardController>(
        builder: (TopSellingDashboardController controller) {
      if (controller.topsellingList.isEmpty) {
        return const Center(
          child: Text("No Top Selling Found"),
        );
      } else {
        final allTopSelling = query.isEmpty
            ? controller.topsellingList
            : controller.topsellingList
                .where(
                    (e) => e.name!.toLowerCase().contains(query.toLowerCase()))
                .toList();

        if (allTopSelling.isEmpty) {
          return Center(
            child: customText("No Search Result Found",
                color: Theme.of(context).highlightColor),
          );
        } else {
          final allTopSelling = query.isEmpty
              ? controller.topsellingList
              : controller.topsellingList
                  .where((e) =>
                      e.name!.toLowerCase().contains(query.toLowerCase()))
                  .toList();

          if (allTopSelling.isEmpty) {
            return Center(
              child: customText("No Search Result Found",
                  color: Theme.of(context).highlightColor),
            );
          }

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allTopSelling.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme.of(context).focusColor,
                  child: ListTile(
                      title: customText(allTopSelling[index].name.toString(),
                          color: Theme.of(context).highlightColor, font: 16.0),
                      subtitle: customText(
                          "${AppConstant.currency} ${allTopSelling[index].price}",
                          color: Theme.of(context).highlightColor,
                          font: 16.0),
                      trailing: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          customText(" ${allTopSelling[index].quantity}",
                              color: Theme.of(context).hintColor, font: 16.0),
                          customText(
                              "${AppConstant.currency} ${int.parse(allTopSelling[index].quantity.toString()) * double.parse(allTopSelling[index].price.toString())}",
                              color: Theme.of(context).primaryColor,
                              font: 16.0),
                        ],
                      )
                      //subtitle: customText(allTopSelling[index].itemId.toString(), color: Theme.of(context).highlightColor.withOpacity(0.7))
                      ),
                );
              });
        }
      }
    }),
    // spacer(20)
  );
}
