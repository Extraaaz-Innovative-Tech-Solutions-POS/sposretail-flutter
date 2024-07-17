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
  var name, role, dissmisscheck, businessType;
  final advanceController = Get.put(DeliveryController());
  final floorController = Get.put(FloorController());
  final sectionController = Get.put(SectionController());
  final usercontroller = Get.put(UserController());

  final customerController = Get.put(CustomerlistController());

  @override
  void initState() {
    super.initState();
    sharedPrefrence();
    advanceController.advancedPendingOrder();
    sectionController.fetchSection();
  }

  sharedPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('name');
    role = pref.getString('role');
    businessType = pref.getString("BusinessType");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    sectionController.fetchSection();
    return GetBuilder<DeliveryController>(
        builder: (DeliveryController controller) {
      final pages = [
        role == "manager" ? AddCategory() : null,
        businessType == "catering"
            ? const CateringDashboard()
            : Dashboard(), // Dashboard(),
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
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: ListView(
                children: [
                  SizedBox(
                    height: 120,
                    child: DrawerHeader(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                      ),
                      child: Image.asset(Images.logoAsset),
                    ),
                  ),
                  usercontroller.user!.role == 'manager'
                      ? listTile(context, 'Staff',
                          leading: Icon(
                            Icons.group,
                            color: Theme.of(context).primaryColor,
                          ), onpress: () {
                          Get.to(const StaffSettings());
                        })
                      : const SizedBox.shrink(),
                  // businessType == "catering"
                  //     ? const SizedBox.shrink()
                  //     : usercontroller.user!.role == 'manager'
                  //         ? listTile(context, 'Floor',
                  //             leading: Icon(Icons.apartment,
                  //                 color: Theme.of(context).primaryColor),
                  //             onpress: () {
                  //             floorController.fetchAllFloor(true);
                  //             sectionController.fetchSection();
                  //           })
                  //         : const SizedBox.shrink(),
                  // businessType == "catering"
                  //     ? const SizedBox.shrink()
                  //     : usercontroller.user!.role == 'manager'
                  //         ? listTile(context, "Add Floors",
                  //             leading: Icon(Icons.six_ft_apart,
                  //                 color: Theme.of(context).primaryColor),
                  //             onpress: () {
                  //             Get.to(AddFloor());
                  //           })
                  //         : const SizedBox.shrink(),
                  // businessType == "catering"
                  //     ? const SizedBox.shrink()
                  //     : usercontroller.user!.role == 'manager'
                  //         ? listTile(context, 'Delete Floors',
                  //             leading: Icon(
                  //               Icons.delete,
                  //               color: Theme.of(context).primaryColor,
                  //             ), onpress: () {
                  //             Get.to(const DeleteFloor());
                  //           })
                  //         : const SizedBox.shrink(),
                  // businessType == "catering"
                  //     ? const SizedBox.shrink()
                  //     : usercontroller.user!.role == 'manager'
                  //         ? listTile(context, "Add Section",
                  //             leading: Icon(Icons.backup_table,
                  //                 color: Theme.of(context).primaryColor),
                  //             onpress: () {
                  //             Get.to(SectionItem());
                  //           })
                  //         : const SizedBox.shrink(),
                  // businessType == "catering"
                  //     ? const SizedBox.shrink()
                  //     : usercontroller.user!.role == 'manager'
                  //         ? listTile(context, "Add Section/Table",
                  //             leading: Icon(Icons.table_bar,
                  //                 color: Theme.of(context).primaryColor),
                  //             onpress: () {
                  //             floorController.fetchAllFloor(false);
                  //           })
                  //         : const SizedBox.shrink(),
                  // usercontroller.user!.role == 'manager'
                  //     ? listTile(context, "Sub Items Groups",
                  //         leading: Icon(Icons.fastfood,
                  //             color: Theme.of(context).primaryColor),
                  //         onpress: () {
                  //         Get.to(const AllModifierGroupUI());
                  //       })
                  //     : const SizedBox.shrink(),
                  // usercontroller.user!.role == 'manager'
                  //     ? listTile(context, "Sub Items",
                  //         leading: Icon(Icons.food_bank,
                  //             color: Theme.of(context).primaryColor),
                  //         onpress: () {
                  //         Get.to(const AllModifierUI());
                  //       })
                  //     : const SizedBox.shrink(),
                  listTile(context, "Printer Setup",
                      leading: Icon(Icons.local_printshop,
                          color: Theme.of(context).primaryColor), onpress: () {
                    //Get.to();
                    //Get.to(AddTable());
                    //Get.to(PrinterSettings());
                    Get.to(const ExtraaazPosUtlityUI());
                  }),
                  listTile(context, "Customer Details",
                      leading: Icon(Icons.person,
                          color: Theme.of(context).primaryColor), onpress: () {
                    Get.to(const Customerdetails());
                    customerController.getcustomerlist();
                  }),
                  listTile(context, "Restaurant Update",
                      leading: Icon(Icons.apartment,
                          color: Theme.of(context).primaryColor), onpress: () {
                    Get.to(const RestaurantUpdate());
                    customerController.getcustomerlist();
                  }),
                  listTile(context, "Taxes Setup",
                      leading: Icon(Icons.currency_rupee,
                          color: Theme.of(context).primaryColor), onpress: () {
                    Get.to(const AddTaxes());
                    //
                  }),
                  ExpansionTile(
                    title: listTile(context, "Inventory"),
                    leading: Icon(Icons.inventory,
                        color: Theme.of(context).primaryColor),
                    trailing: Icon(Icons.arrow_drop_down,
                        color: Theme.of(context).primaryColor),
                    children: [
                      listTile(context, "Dashboard", onpress: () {
                        Get.to(const InventoryDashboard());
                      }),
                      listTile(context, 'Manage', onpress: () {
                        Get.to(const InventoryList());
                      }),
                      listTile(context, 'Create Supplier', onpress: () {}),
                      listTile(context, 'Supplier list', onpress: () {
                        Get.to(const SupplierUI());
                      }),
                      listTile(context, 'Purchase', onpress: () {
                        Get.to(const PurchaseUI());
                      }),
                    ],
                  ),
                  listTile(
                    context,
                    "Logout",
                    leading: Icon(Icons.arrow_back,
                        color: Theme.of(context).primaryColor),
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
            // GestureDetector(
            //   onTap: () {
            //     showAdvanceNotify(
            //         context: context,
            //         orderdata: controller.pendingAdvanceOrderList);
            //   },
            //   child: StatefulBuilder(builder: (BuildContext context,
            //       void Function(void Function()) setState) {
            //     return Icon(
            //       Icons.notifications,
            //       color: controller.checkadvance.isTrue
            //           ? Theme.of(context).hoverColor
            //           : Theme.of(context).highlightColor,
            //     );
            //   }),
            // ),

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
        body: pages[widget.pageindex ?? 1],
        bottomNavigationBar: buildBottomNav(context),
      );
    });
  }

  Widget buildBottomNav(context) {
    return Container(
      height: 71,
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          role == 'manager'
              ? bottomIcon(
                  Icons.grid_view,
                  widget.pageindex == 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).highlightColor,
                  "Menu",
                  0, onpressed: () {
                  setState(() {
                    widget.pageindex = 0;
                  });
                })
              : const SizedBox.shrink(),
          bottomIcon(
              Icons.home_outlined,
              widget.pageindex == 1
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).highlightColor,
              "Home",
              1, onpressed: () {
            setState(() {
              widget.pageindex = 1;
            });
          }),
          role == 'manager'
              ? bottomIcon(
                  Icons.insights_outlined,
                  widget.pageindex == 2
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).highlightColor,
                  "Reports",
                  2, onpressed: () {
                  setState(() {
                    widget.pageindex = 2;
                  });
                })
              : const SizedBox.shrink(),
          role == 'manager'
              ? bottomIcon(
                  Icons.timelapse,
                  widget.pageindex == 3
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).highlightColor,
                  "Ongoing",
                  3, onpressed: () {
                  setState(() {
                    widget.pageindex = 3;
                  });
                })
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget listTile(context, title, {onpress, Widget? leading}) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
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
