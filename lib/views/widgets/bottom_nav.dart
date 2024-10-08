import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:spos_retail/views/widgets/export.dart';

class BottomNav extends StatelessWidget {
  int? pageindex;
  BottomNav({
    super.key,
    this.pageindex,
  });

  final advanceController = Get.put(DeliveryController());

  //int _bottomNavIndex = 1;
  final usercontroller = Get.put(UserController());
  final List<IconData> iconList = [
    Icons.grid_view,
    Icons.home_outlined,
    Icons.insights_outlined,
    Icons.timelapse,
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryController>(
        builder: (controller) {
      final pages = [
        settingsController.role == "manager" ? AddCategory() : null,
        Dashboard(),
        settingsController.role == "manager" ? const Reports() : null,
        settingsController.role == "manager"
            ? OngoingOrder(
                businessType: settingsController.businessType == "catering"
                    ? true
                    : false)
            : null,
      ];
      return GetBuilder<SettingsController>(
        builder: (c) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            drawer: drawer(context),
            appBar: commonAppBar(
              context,
              c.name,
              "(${c.role})",
            ),
            body: pages[c.bottomNavIndex ?? 1],
            bottomNavigationBar: buildBottomNav(context),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.store,
                color: Theme.of(context).focusColor,
              ),
              onPressed: () async {
                if (c.clientInfo) {
                  Get.to(() => const TakeAwayCustomerDetails());
                } else {
                  Get.to(() => OrderBookingScreen(
                        ordertype: "Take Away",
                        restaurantId: c.restaurantId.toString(),
                      ));
                }
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        }
      );
    });
  }

  Widget buildBottomNav(context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        return Icon(iconList[index],
            size: 24,
            color: isActive
                ? Theme.of(context).primaryColor
                : Theme.of(context).highlightColor);
      },
      activeIndex: settingsController.bottomNavIndex ?? 1,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (i) => settingsController.toggleBottomNavIndex(i),
    );
  }
}
