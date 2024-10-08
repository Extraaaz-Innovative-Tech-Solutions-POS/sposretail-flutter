import 'package:intl/intl.dart';

import '../widgets/export.dart';

class InventoryDashboard extends StatefulWidget {
  const InventoryDashboard({super.key});

  @override
  State<InventoryDashboard> createState() => _InventoryDashboardState();
}

class _InventoryDashboardState extends State<InventoryDashboard> {
  var name, role;
  String query = '';
  String queryAll = '';
  final graphController = Get.put(GraphController());
  final dashboardController = Get.put(DashboardController());
  final usercontroller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        //'hello'.tr,
        name,
        "($role)",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  "Inventory Summary",
                  font: 16.0,
                  color: Theme.of(context).highlightColor,
                ),
                search(
                  context,
                  onchange: (value) {
                    setState(() {
                      queryAll = value;
                    });
                  },
                ),
                customText(
                  "Inventory Activity",
                  font: 16.0,
                  color: Theme.of(context).highlightColor,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  //verticalDirection: VerticalDirection.up,
                  runSpacing: 15, 
                  //spacing: 10, 
                  children: [
                  inventorySummary(
                      "Return", "94", Theme.of(context).hoverColor),
                  inventorySummary(
                      "Return Rate", "49.47 %", Theme.of(context).indicatorColor),
                  inventorySummary(
                      "Sell Rate", "35.87", Colors.blueAccent),
                  inventorySummary(
                      "Value of Stock", "94", Theme.of(context).hoverColor),
                  inventorySummary(
                      "Out of Stock", "10590.00", Theme.of(context).primaryColor),
                  inventorySummary(
                      "No of Suppliers", "0", Colors.cyan),

                ]),
                inventoryGraphs(context, usercontroller, graphController,
                    dashboardController),
                customText(
                  "Product Details",
                  font: 16.0,
                  color: Theme.of(context).highlightColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Card(
                    color: Theme.of(context).focusColor,
                    child: ListTile(
                        title: customText("Low Stock Items",
                            color: Theme.of(context).hoverColor, font: 16.0),
                        subtitle: customText("All items",
                            color: Theme.of(context).highlightColor,
                            font: 16.0),
                        trailing: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            customText("25.00",
                                color: Theme.of(context).hoverColor,
                                font: 16.0),
                            customText("54.0",
                                color: Theme.of(context).highlightColor,
                                font: 16.0),
                          ],
                        )
                        ),
                  ),
                ),
                customText(
                  "top_selling_products".tr,
                  font: 16.0,
                  color: Theme.of(context).highlightColor,
                ),
                search(
                  context,
                  onchange: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                ),
                topSellingProduct(context, query)
              ]),
        ),
      ),
    );
  }

  Widget inventorySummary(title, amount, color) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        border: Border.all(
          color: Theme.of(context).highlightColor,
          width: 1.0,
        ),
      ),
      child: ListTile(
        title: customText(
          title,
          color: Theme.of(context).highlightColor,
        ),
        subtitle: customText(
          amount,
          color: color,
        ),
      ),
    );
  }
}

Widget inventoryGraphs(BuildContext context, UserController usercontroller,
    graphController, DashboardController dashboardController) {
  return usercontroller.user!.role == "manager"
      ? Container(
          margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
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
            onTap: () {},
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
