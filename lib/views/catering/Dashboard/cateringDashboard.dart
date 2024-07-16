import 'package:intl/intl.dart';
import 'package:spos_retail/constants/common_dashboard.dart';
import 'package:spos_retail/views/Delivery/pending_orderUI.dart';

import '../../../model/Pending orders/catering_pending_order.dart';
import '../../widgets/export.dart';
import '../advance/pending_catering_orders.dart';

class CateringDashboard extends StatefulWidget {
  const CateringDashboard({super.key});

  @override
  State<CateringDashboard> createState() => _CateringDashboardState();
}

class _CateringDashboardState extends State<CateringDashboard> {
  DashboardController dashboardController = Get.put(DashboardController());
  final PaymentController paymentController = Get.put(PaymentController());
  final UserController usercontroller = Get.put(UserController());
  final TopSellingDashboardController topsellingDashboardController =
      Get.put(TopSellingDashboardController());
  final FloorController floorController = Get.put(FloorController());
  final graphController = Get.put(GraphController());
  final CategoryController categoryController = Get.put(CategoryController());
  final DeliveryController advanceController = Get.put(DeliveryController());
  String query = '';
  bool checkadvance = false;
  var statusclick, dismissClick;
  @override
  void initState() {
    super.initState();
    dashboardController.fetchDashboard();
    topsellingDashboardController.fetchDashboard();
    paymentController.onlinePayment();
    paymentController.cashPayment();
    advanceController.advancedPendingOrder();

    DateTime currentDate = DateTime.now();

// Get the first day of the current month
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);

// Get the last day of the current month
    DateTime lastDayOfMonth = DateTime(
      currentDate.year,
      currentDate.month + 1,
      0,
    );

// Format dates in 'yyyy-MM-dd' format
    String formattedStartDate =
        DateFormat('yyyy-MM-dd').format(firstDayOfMonth);
    String formattedEndDate = DateFormat('yyyy-MM-dd').format(lastDayOfMonth);

    graphController.getGraph(formattedStartDate, formattedEndDate, "catering");
    _statusbool();
    // checkfordavance();
    dismiss();
    setState(() {});
  }

  Future<void> _statusbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    statusclick = prefs.getBool("CustomerDetailsBool");

    setState(() {});
  }

  Future<void> dismiss() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dismissClick = prefs.getBool("Dismiss");
    if (dismissClick == null) {
      dismissClick = true;

      SchedulerBinding.instance
          .addPostFrameCallback((_) => advanceOrderCheckDate());

      setState(() {});
    }
    setState(() {});
  }

  Future<void> advanceOrderCheckDate() async {
    dismissClick
        ? showAdvanceNotify(
            context: context,
            orderdata: advanceController.pendingAdvanceOrderList)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        multipleOption(context, "Catering Advanced Order", () {
                          // floorController.fetchFloorTable(true, "Advance");
                          Get.to(() => const CateringPendingOrderList());
                          // PendingOrderUI(advance: false, catering:true));
                          // Get.to(() => const CateringAdvance(
                          //       ordertype: "Advance",
                          //     ));
                        }),
                      ],
                    ),
                    usercontroller.user!.role == "manager"
                        ? headingTitle(context, "Dashboard")
                        : const SizedBox.shrink(),
                    //* Dashboard Graphs ------------->
                    commondashboardGraphs(context, usercontroller,
                        graphController, dashboardController),
                    //* Mode Of Payments------------->
                    modeofPayments(context, usercontroller, paymentController),
                    headingTitle(
                      context,
                      "Top Selling Products",
                    ),
                    //* Search
                    search(
                      context,
                      onchange: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                    ),
                    topSellingProduct(context, query)
                  ],
                ),
              ),
            )));
  }

  Widget headingTitle(context, title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, color: Theme.of(context).highlightColor),
    );
  }

  Widget multipleOption(context, title, onPress) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).highlightColor),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(02), // Set border radius here
              ),
              backgroundColor: Theme.of(context).focusColor),
          onPressed: onPress,
          child: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 16.0),
          )),
    ));
  }
}
