import 'package:intl/intl.dart';
import 'package:spos_retail/views/widgets/export.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

DashboardController dashboardController = Get.put(DashboardController());
final PaymentController paymentController = Get.put(PaymentController());

class _DashboardState extends State<Dashboard> {
  DashboardController dashboardController = Get.put(DashboardController());
  final PaymentController paymentControllerP = Get.put(PaymentController());
  final UserController usercontroller = Get.put(UserController());
  final TopSellingDashboardController topsellingDashboardController =
      Get.put(TopSellingDashboardController());
  final graphController = Get.put(GraphController());
  final CategoryController categoryController = Get.put(CategoryController());
  final DeliveryController advanceController = Get.put(DeliveryController());
  String query = '';
  bool checkadvance = false;
  var dismissClick;

  @override
  void initState() {
    super.initState();
    dashboardController.fetchDashboard();
    topsellingDashboardController.fetchDashboard();
    paymentController.onlinePayment();
    paymentController.cashPayment();
    // advanceController.advancedPendingOrder();

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

    graphController.getGraph(formattedStartDate, formattedEndDate, "");

    // dismiss();
    // checkfordavance();
  }

 

  // Future<void> dismiss() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   dismissClick = prefs.getBool("Dismiss");
  //   if (dismissClick == null) {
  //     dismissClick = true;

  //     SchedulerBinding.instance
  //         .addPostFrameCallback((_) => advanceOrderCheckDate());

  //     setState(() {});
  //   }
  //   //setState(() {});
  // }

  // Future<void> advanceOrderCheckDate() async {
  //   dismissClick
  //       ? showAdvanceNotify(
  //           context: context,
  //           orderdata: advanceController.pendingAdvanceOrderList)
  //       : null;
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.keyD): DineIntent(),
            LogicalKeySet(LogicalKeyboardKey.keyT): TakeAwayIntent(),
            LogicalKeySet(LogicalKeyboardKey.keyA): AdvanceIntent(),
          },
          child: Actions(
            actions: {             
              AdvanceIntent: CallbackAction<AdvanceIntent>(
                  onInvoke: ((intent) => Get.to(() => PendingAdvanceOrder())))
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    usercontroller.user!.role == "manager"
                        ? headingTitle(context, "dashboard".tr)
                        : const SizedBox.shrink(),
                    //* Dashboard Graphs ------------->
                    commondashboardGraphs(context, usercontroller,
                        graphController, dashboardController),
                    //* Mode Of Payments------------->
                    modeofPayments(context, usercontroller, paymentController),

                    headingTitle(
                      context,
                      "top_selling_products".tr,
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
            ),
          ),
        ),
      ),
    );
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
              color: Theme.of(context).primaryColor,
              fontSize: 16.0,
            ),
          )),
    ));
  }
}

class DineIntent extends Intent {}

class TakeAwayIntent extends Intent {}

class AdvanceIntent extends Intent {}
