import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:spos_retail/views/inventory/stock/return_stock.dart';
import 'package:spos_retail/views/inventory/stock/stock_alert.dart';
import 'package:spos_retail/views/languages.dart';
import 'package:spos_retail/views/settings/invoices/additional_notes.dart';
import 'package:spos_retail/views/widgets/export.dart';

class BottomNav extends StatefulWidget {
  int? pageindex;
  BottomNav({
    Key? key,
    this.pageindex,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

final UserController usercontroller = Get.put(UserController());

class _BottomNavState extends State<BottomNav> {
  var name, role, dissmisscheck, businessType, statusclick;
  final advanceController = Get.put(DeliveryController());
  final floorController = Get.put(FloorController());
  final sectionController = Get.put(SectionController());
  final usercontroller = Get.put(UserController());
  final purchaseController = Get.put(PurchaseController());
  final recipeController = Get.put(RecipeController());
  final infoController = Get.put(AdditionalInfoController());

  final customerController = Get.put(CustomerlistController());
  var restaurantId;
  int _bottomNavIndex = 1;
  final List<IconData> iconList = [
    Icons.grid_view,
    Icons.home_outlined,
    Icons.insights_outlined,
    Icons.timelapse,
  ];

  @override
  void initState() {
    super.initState();
    sharedPrefrence();
    // advanceController.advancedPendingOrder();
    sectionController.fetchSection();
  }



  sharedPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('name');
    role = pref.getString('role');
    businessType = pref.getString("BusinessType");
    setState(() {
       restaurantId = pref.getInt("RestaurantId");
    });
    print("CUSTOMER RESTAURANT ID -------------------------------- $restaurantId");
  }
   Future<void> _statusbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    statusclick = prefs.getBool("CustomerDetailsBool");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    sectionController.fetchSection();
    return GetBuilder<DeliveryController>(
        builder: (DeliveryController controller) {
      final pages = [
        role == "manager" ? AddCategory() : null,
        Dashboard(), // Dashboard(),
        //businessType == "catering" ? const Reports() : null,
        role == "manager" ? const Reports() : null,
        role == "manager"
            ? OngoingOrder(
                businessType: businessType == "catering" ? true : false)
            : null,
      ];
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: Align(
          alignment: Alignment.topLeft,
          child: Container(
            // height: screenHeight(context, dividedBy: 1.2),
            decoration: BoxDecoration(
              gradient: gradient([
                Theme.of(context).focusColor,
                Theme.of(context).highlightColor,
              ]),
              //  color: Theme.of(context).highlightColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Drawer(
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              child: ListView(
                children: [
                  SizedBox(
                    height: 120,
                    child: DrawerHeader(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Theme.of(context).focusColor,
                      ),
                      child: Image.asset(
                        Images.logoAsset,
                      ),
                    ),
                  ),
                  usercontroller.user!.role == 'manager'
                      ? listTile(context, 'staff'.tr,
                          leading: Icon(
                            Icons.group,
                            color: Theme.of(context).focusColor,
                          ), onpress: () {
                          Get.to(const StaffSettings());
                        })
                      : const SizedBox.shrink(),
                  usercontroller.user!.role == 'manager'
                      ? listTile(context, "Sub Items Groups",
                          leading: Icon(Icons.fastfood,
                              color: Theme.of(context).primaryColor),
                          onpress: () {
                          Get.to(const AllModifierGroupUI());
                        })
                      : const SizedBox.shrink(),
                  usercontroller.user!.role == 'manager'
                      ? listTile(context, "Sub Items",
                          leading: Icon(Icons.food_bank,
                              color: Theme.of(context).primaryColor),
                          onpress: () {
                          Get.to(const AllModifierUI());
                        })
                      : const SizedBox.shrink(),
                  listTile(context, "Printer Setup",
                      leading: Icon(Icons.local_printshop,
                          color: Theme.of(context).focusColor), onpress: () {
                    //Get.to();
                    //Get.to(AddTable());
                    //Get.to(PrinterSettings());
                    Get.to(const ExtraaazPosUtlityUI());
                  }),
                  listTile(context, "Customer Details",
                      leading: Icon(Icons.person,
                          color: Theme.of(context).focusColor), onpress: () {
                    Get.to(const Customerdetails());
                    customerController.getcustomerlist(false);
                  }),
                  listTile(context, "Additional Info",
                      leading: Icon(Icons.note_add_sharp,
                          color: Theme.of(context).focusColor), onpress: () {
                            infoController.getAdditionalInfo();
                             Get.to(() => AdditionalInfo());
                    
                  }),
                  listTile(context, "Retail Update",
                      leading: Icon(Icons.apartment,
                          color: Theme.of(context).focusColor), onpress: () {
                    Get.to(const RestaurantUpdate());
                    customerController.getcustomerlist(false);
                  }),
                  listTile(context, "Taxes Setup",
                      leading: Icon(Icons.currency_rupee,
                          color: Theme.of(context).focusColor), onpress: () {
                    Get.to(const AddTaxes());
                    //
                  }),
                  ExpansionTile(
                    title: listTile(context, "Inventory"),
                    leading: Icon(Icons.inventory,
                        color: Theme.of(context).focusColor),
                    trailing: Icon(Icons.arrow_drop_down,
                        color: Theme.of(context).focusColor),
                    children: [
                      
                      listTile(context, 'Manage', onpress: () {
                        Get.to(const InventoryList());
                      }),
                           listTile(context, 'Stock Alert', onpress: () {
                         recipeController.getIngredientList();
                         Get.to(() => StockAlert());
                      }),
                       listTile(context, "Return Stock", onpress: () {
                        purchaseController.getPurchase();
                        Get.to(() => ReturnStock()); 
                      }),
                      listTile(context, 'Supplier list', onpress: () {
                        Get.to(const SupplierUI());
                      }),
                      listTile(context, 'Purchase', onpress: () {
                        purchaseController.getPurchase();
                        Get.to(PurchaseUI());
                      }),
                      listTile(context, "Recipe Management", onpress: () {
                        Get.to(() => const RecipeList());
                        recipeController.getIngredientList();
                        recipeController.getRecipe(); 
                      })
                    ],
                  ),
                  listTile(context, "Languages",
                      leading: Icon(Icons.apartment,
                          color: Theme.of(context).focusColor), onpress: () {
                    Get.to(const Languages());
                  }),
                  listTile(
                    context,
                    "Logout",
                    leading: Icon(Icons.arrow_back,
                        color: Theme.of(context).focusColor),
                    onpress: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              shape: BeveledRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context).focusColor)),
                              content: customText(
                                  'Are you Sure, you want to Logout?',
                                  color: Theme.of(context).highlightColor),
                              actions: [
                                textButton(
                                  'Yes',
                                  Theme.of(context).hoverColor,
                                  onpress: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.remove("token");
                                    pref.remove("username");
                                    pref.remove("password");
                                    pref.remove("saved");
                                    pref.remove("Dismiss");
                                    pref.reload();

                                    Get.offAll(Login());
                                    Get.back();
                                  },
                                ),
                                textButton('No', Theme.of(context).primaryColor,
                                    onpress: () {
                                  Navigator.of(context).pop();
                                })
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: commonAppBar(
          context,
          name,
          "($role)",
          action: [       
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: GestureDetector(
                    child: const Icon(
                      Icons.toggle_off,
                      size: 40,
                    ),
                    onTapDown: (details) {
                      showPopUpMenu(context, details.globalPosition);
                    })),
          ],
        ),
        body: pages[_bottomNavIndex],
        bottomNavigationBar: buildBottomNav(context),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.store,
            color: Theme.of(context).focusColor,
          ),
          onPressed: () async{

            _statusbool().whenComplete(() {
                                if (statusclick == true) {
                                  Get.to(() => const TakeAwayCustomerDetails());
                                } else {
                                  print("RESTAURANT PASSING $restaurantId");
                                  Get.to(() => OrderBookingScreen(
                                        ordertype: "Take Away",
                                        restaurantId: restaurantId.toString(),
                                      ));
                                }
                              });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => _bottomNavIndex = index),
    );
  }

  Widget listTile(context, title, {onpress, Widget? leading}) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).focusColor, fontSize: 20.0),
      ),
      onTap: onpress,
    );
  }

  Widget bottomIcon(IconData icon, color, text, pageindex, {onpressed}) {
    return Column(
      children: [
        IconButton(
          enableFeedback: false,
          onPressed: onpressed,
          icon: Icon(
            icon,
            color: color,
            size: 25,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: widget.pageindex == pageindex
                ? Theme.of(context).primaryColor
                : Theme.of(context).highlightColor,
          ),
        ),
      ],
    );
  }
}

enum MenuItemType { KOT, CUSTOMER }

getMenuItemString(MenuItemType menuItemType) {
  switch (menuItemType) {
    case MenuItemType.KOT:
      return "Kot";
    case MenuItemType.CUSTOMER:
      return "Customer";
  }
}

// Helper function to show popup menu
Future<void> showPopUpMenu(BuildContext context, Offset offset) async {
  final screenSize = MediaQuery.of(context).size;
  double left = offset.dx;
  double top = offset.dy;
  double right = screenSize.width - offset.dx;
  double bottom = screenSize.height - offset.dy;

  await showMenu<MenuItemType>(
    context: context,
    position: RelativeRect.fromLTRB(left, top, right, bottom),
    items: [
      const PopupMenuItem<MenuItemType>(
          value: MenuItemType.KOT, child: KOTstatus()),
    ],
  );
}
