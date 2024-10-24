import 'package:spos_retail/views/widgets/export.dart';

Widget drawer(context) {
  final usercontroller = Get.put(UserController());
  final purchaseController = Get.put(PurchaseController());
  final recipeController = Get.put(RecipeController());
  final infoController = Get.put(AdditionalInfoController());
  final customerController = Get.put(CustomerlistController());
  final moneyinController = Get.put(MoneyinlistController());
    final moneyoutController = Get.put(MoneyoutlistController());
  return Align(
          alignment: Alignment.topLeft,
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient([
                Theme.of(context).focusColor,
                Theme.of(context).highlightColor,
              ]),
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
                    Get.to(const ExtraaazPosUtlityUI());
                  }),
                  listTile(context, "Customer Details",
                      leading: Icon(Icons.person,
                          color: Theme.of(context).focusColor), onpress: () {
                    Get.to(const Customerdetails());
                    customerController.getcustomerlist(false);
                    moneyinController.isMoneyInout.value =false;
                    moneyinController.update();
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
                  }),
                  listTile(context, "Unit",
                      leading: Icon(Icons.ac_unit,
                          color: Theme.of(context).focusColor), onpress: () {
                    Get.to(Unit());
                  }),



                   listTile(context, "Money In List",
                      leading: Icon(Icons.ac_unit,
                          color: Theme.of(context).focusColor), onpress: () {
                            moneyinController.deposits();
                            
                    Get.to(MoneyInList());
                     customerController.getcustomerlist(false);
                  }),


                    listTile(context, "Money Out List",
                      leading: Icon(Icons.ac_unit,
                          color: Theme.of(context).focusColor), onpress: () {
                             moneyoutController.withdrawal();
                    Get.to(MoneyOutList());
                     customerController.getcustomerlist(false);
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