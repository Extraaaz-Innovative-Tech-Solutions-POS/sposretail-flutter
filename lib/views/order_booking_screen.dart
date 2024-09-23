// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:developer';

import 'package:spos_retail/views/widgets/export.dart';

class OrderBookingScreen extends StatefulWidget {
  final int floor;
  final int table;
  final String ordertype;
  final int? customerId;
  final String? tablenumber;
  final int? table_divided_by;
  final String? table_id;
  final int? sub_table;
  final String? section_id;
  final String? customerName;
  final String? advanceOrderDateTime;
  final String? restaurantId;

  OrderBookingScreen(
      {Key? key,
      this.floor = 0,
      this.table = 0,
      this.ordertype = "Dine",
      this.tablenumber,
      this.table_divided_by,
      this.sub_table,
      this.table_id,
      this.section_id,
      this.customerName,
      this.advanceOrderDateTime,
      this.restaurantId,
      this.customerId})
      : super(key: key);

  @override
  _OrderBookingScreenState createState() => _OrderBookingScreenState();
}

class _OrderBookingScreenState extends State<OrderBookingScreen> {
  List<String> dropdownValues = [];
  String? openItemName;
  String? openItemPrice;

  final menucontroller = Get.put(AllItemsController());
  final authController = Get.put(AuthController());
  // final user = Get.put(UserController());
  //final cartController = Get.put(CartController());
  final modifierItemsById = Get.put(GetModifierItemById());
  final orderbookingScreen = Get.put(OrderBookingController());
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  late InvoiceManager invoiceManager;
  List<Item> order = [];
  var clickonActionChips,
      editingindex,
      priceIndex,
      varientitemname,
      varientitemprice,
      addonsname,
      addonsprice,
      statusofSwitch,
      kotboolChecking,
      takeAwayIDs,
      deliveryIDS,
      advanceIds,
      data,
      dineTableID,
      identifier,
      iv_code,
      addonsVarientid,
      selectedvarients;

  List<GlobalKey> itemKeys = [];
  Map<int, bool> _isChecked = {};
  double totalPrice = 0;
  bool isQuantityEditing = false;
  bool isPriceEditing = false;
  bool addvairent = false;
  bool orderTap = false;

  final ScrollController scrollController = ScrollController();
  List<String> selectedAddonNames = [];
  bool addons = false;
  DateTime datetime = DateTime.now();
  String query = "";

  double jewellerPrice = 80000.00;
  double newQuantity = 0.0;

  double unitPrice = 8000;

  double newPrice =0.0;



  @override
  void initState() {
    super.initState();
    //print("fffffffffffffffffffffffffffffffffffffffff  ${widget.section_id}");
    menucontroller.fetchMenu(widget.section_id);
    clickonActionChips = "All";
    data = datetime.day;
    isQuantityEditing = false;
    _checkBool();
    dineinTable();

    checkKotStatus();

    setState(() {});
  }

  checkKotStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    kotboolChecking = pref.getBool("KOTBoolStatus");
    setState(() {
    });
  }

//* Generating the table Id. For the Particular Order.
  Future<void> dineinTable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget.table_id != null) {
      //  print("ID is already created");
      return;
    }

    String endpoint;
    String prefKey;

    switch (widget.ordertype) {
      case "Dine":
        endpoint = AppConstant.dineId;
        prefKey = "DineTableID";
        break;
      case "Delivery":
        endpoint = "getTableId/Delivery";
        prefKey = "DeliveryID";
        break;
      case "Advance":
        endpoint = AppConstant.advanced;
        prefKey = "advance_id";
        break;
      default:
        endpoint = AppConstant.takeAwayID;
        prefKey = "TakeAwayTableID";
        break;
    }

    try {
      final response = await DioServices.get(endpoint);
      if (response.statusCode == 200) {
        final id = response.toString();
        prefs.setString(prefKey, id);
        setState(() {
          if (widget.ordertype == "Dine") dineTableID = id;
          if (widget.ordertype == "Delivery") deliveryIDS = id;
          if (widget.ordertype == "Advance") advanceIds = id;
          if (widget.ordertype == "Take Away") takeAwayIDs = id;
        });
        // print("Your $widget.ordertype ID value-------->");
        // print(response.toString());
      }
    } catch (e) {
      print("Failed to fetch table ID: $e");
    }
  }

  Future<void> _checkBool() async {
    statusofSwitch ??= false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    statusofSwitch = prefs.getBool("CustomerDetailsBool");

    prefs.setInt("checkdate", data);
    dineTableID = prefs.getString("DineTableID");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).highlightColor),
        backgroundColor: Colors.transparent,
        title: GestureDetector(
          onTap: () {
            clickonActionChips = "All";
            setState(() {});
          },
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "menu".tr.padRight(5),
                    style: const TextStyle(fontSize: 18)),
                TextSpan(
                    text: "Retail Orders",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).highlightColor.withOpacity(0.7))),
              ],
            ),
          ),
        ),
        actions: [
          widget.ordertype == "Dine"
              ? IconButton(
                  onPressed: () {
                    if (widget.table_id != null) {
                      Get.to(() => ShowOngoingOrder(
                            floor: widget.floor,
                            table: widget.table,
                            ordertype: widget.ordertype,
                            orderData: order,
                            tableId: widget.table_id!,
                            items: const [],
                          ));
                    } else {
                      Fluttertoast.showToast(msg: "Please Order Something");
                    }
                  },
                  icon: const Icon(Icons.receipt_long_rounded),
                  tooltip: "get bill",
                )
              : const Text(""),
          widget.ordertype == "Delivery"
              ? Container(
                  height: 30.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text(
                      widget.customerName.toString(),
                      style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : const Text("")
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min, // Adjust the size to fit the content
        children: [
          order.isNotEmpty
              ? SizedBox(
                  height: 50,
                  width: 200,
                  child: FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: customText(
                      "Order Now",
                      font: 18.0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onPressed: () {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        showModalBottomSheet(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          context: context,
                          builder: (BuildContext context) {
                            return bottomSheetOrder(
                                context, order, openItemName, openItemPrice);
                          },
                        );
                      });
                      isQuantityEditing = false;
                    },
                  ),
                )
              : Container(),

          // Space between buttons
          const SizedBox(height: 10),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: search(context, onchange: (value) {
                    setState(() {
                      query = value;
                    });
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        showOpenItemAlertDialog(context);
                      },
                      child: customText("Add Open Item",
                          color: Theme.of(context).focusColor)),
                )
              ],
            ),
            // search(context, onchange: (value) {
            //   setState(() {
            //     query = value;
            //   });
            // }),
            Expanded(
              flex: 1,
              child: GetBuilder<AllItemsController>(builder: (controller) {
                return ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 15),
                    headingTitle(context, "Categories"),
                    // const SizedBox(height: 15),
                    SizedBox(
                      height: 70,
                      child: _menuCategoriesSelectorWidget(controller.menu),
                    ),
                    ...controller.menu.asMap().entries.map((entry) {
                      String categoryTitle =
                          entry.value.categoryName.toString();

                      int index = entry.key;

                      return clickonActionChips == "All"
                          ? allMenu(entry, categoryTitle, entry.value.items!)
                          : categoryTitle == clickonActionChips
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Visibility(
                                    visible: entry.value.items!.isNotEmpty,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Text(
                                              categoryTitle.toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  letterSpacing: 3,
                                                  //wordSpacing: ,
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            ),
                                          ),
                                        ),
                                        _menuCategoryItemsGrid(
                                            context, entry.value.items!),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                    }).toList(),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void showOpenItemAlertDialog(BuildContext context) {
    TextEditingController firstController = TextEditingController();
    TextEditingController secondController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: customText('Open Item Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: firstController,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                ),
              ),
              TextField(
                controller: secondController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Item Price',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: customText('Submit'),
              onPressed: () {
                setState(() {
                  // openItemName = firstController.text;
                  // openItemPrice = secondController.text;

                   order.add(Item(
        name: firstController.text, // New item name
        price: secondController.text, // New item price
        quantity: 1, // New item quantity
        vairentId: "",
        instruction: "",
        modifiersGroupID: "",
        isCustom: true));
                });
                // print('First Input: $openItemname');
                // print('Second Input: $openItemPrice');

                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget allMenu(entry, categoryTitle, List<ItemModel> items) {
    Size size = MediaQuery.of(context).size;
    int gridCount = size.width > 1000
        ? 4
        : size.width > 500
            ? 3
            : 2;
    final allFilteredItems = query.isEmpty
        ? items
        : items
            .where((e) =>
                e.name!.toLowerCase().contains(query.toLowerCase()) ||
                e.shortCode.toString() == query)
            .toList();
    //    e.shortCode.toString().contains(query))
    // .toList();
    //  print(allFilteredItems.length);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Visibility(
        visible: allFilteredItems.isNotEmpty ? true : false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                categoryTitle.toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 3,
                    //wordSpacing: ,d
                    color: Theme.of(context).highlightColor),
              ),
            ),
            //
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          Theme.of(context).highlightColor.withOpacity(0.7))),
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<AllItemsController>(builder: (controller) {
                if (items.isEmpty) {
                  return const Center(
                    child: Text("No Menu Found"),
                  );
                } else {
                  if (allFilteredItems.isEmpty) {
                    return Center(
                      child: customText("No Search Result Found",
                          color: Theme.of(context).highlightColor),
                    );
                  }

                  return GridView.count(
                    crossAxisCount: gridCount,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.2,
                    children: List.generate(
                      allFilteredItems.length,
                      // items.length,
                      (index) {
                        GlobalKey itemKey =
                            GlobalKey(); // Create a GlobalKey for each item
                        itemKeys.add(itemKey); // Store the GlobalKey in a list
                        return _menuItemWidget(
                          key: itemKey, // Pass the GlobalKey to the item widget
                          itemName: allFilteredItems[index].name!,
                          itemId: allFilteredItems[index].id!,
                          itemPrice: allFilteredItems[index].price!,
                          image: '',
                          menuItem: allFilteredItems[index],
                          categoryId:
                              allFilteredItems[index].categoryId.toString(),
                        );
                      },
                    ),
                  );
                }
              }),
            )
            // _menuCategoryItemsGrid(
            //     context, entry.value.items!),
            //const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _menuCategoryItemsGrid(BuildContext context, List<ItemModel> items) {
    Size size = MediaQuery.of(context).size;
    int gridCount = size.width > 1000
        ? 4
        : size.width > 500
            ? 3
            : 2;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).highlightColor.withOpacity(0.7))),
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<AllItemsController>(builder: (controller) {
        // print(items);
        if (items.isEmpty) {
          return const Center(
            child: Text("No Menu Found"),
          );
        } else {
          final allFilteredItems = query.isEmpty
              ? items
              : items
                  .where((e) =>
                      e.name!.toLowerCase().contains(query.toLowerCase()) ||
                      e.shortCode.toString() == query)
                  .toList();
          //     e.shortCode.toString().contains(query))
          // .toList();
          // print(allFilteredItems);

          if (allFilteredItems.isEmpty) {
            return Center(
              child: customText("No Search Result Found",
                  color: Theme.of(context).highlightColor),
            );
          }

          return GridView.count(
            crossAxisCount: gridCount,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            mainAxisSpacing: 2,
            crossAxisSpacing: 15,
            childAspectRatio: 1.2,
            children: List.generate(
              allFilteredItems.length,
              // items.length,
              (index) {
                GlobalKey itemKey =
                    GlobalKey(); // Create a GlobalKey for each item
                itemKeys.add(itemKey); // Store the GlobalKey in a list
                return _menuItemWidget(
                  key: itemKey, // Pass the GlobalKey to the item widget
                  itemName: allFilteredItems[index].name!,
                  itemId: allFilteredItems[index].id!,
                  itemPrice: allFilteredItems[index].price!,
                  image: '',
                  menuItem: allFilteredItems[index],
                  categoryId: allFilteredItems[index].categoryId.toString(),
                );
              },
            ),
          );
        }
      }),
    );
  }

  Widget _menuItemWidget({
    required GlobalKey<State<StatefulWidget>> key,
    required String itemName,
    required String itemPrice,
    String image = "",
    dynamic menuItem,
    required dynamic categoryId,
    required int itemId,
  }) {
    var existingOrderItemIndex =
        order.indexWhere((element) => element.id == itemId);

    return GestureDetector(
      onLongPress: () {
        removeItemToOrder(existingOrderItemIndex, itemId);
      },
      child: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 3),
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
            ),
            child: GestureDetector(
              onTap: () async {
                processMenuItem(
                    itemId, itemName, double.parse(itemPrice), false);
                // processMenuAddonsItem(
                //     item_id, itemName, double.parse(itemPrice), false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    itemName,
                    maxLines: 2,
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: 16.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  Flexible(
                      flex: 1,
                      child: Text("${AppConstant.currency}$itemPrice",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0,
                          ))),
                ],
              ),
            ),
          ),
          if (existingOrderItemIndex == -1) ...[
            GestureDetector(
              onTap: () {
                processMenuItem(
                    itemId, itemName, double.parse(itemPrice), true);
                // processMenuAddonsItem(
                //     item_id, itemName, double.parse(itemPrice), true);
              },
              child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(color: Theme.of(context).hintColor)),
                  width: double.infinity,
                  child: Center(
                      child: Text("ORDER",
                          style: TextStyle(
                              color: Theme.of(context).highlightColor)))),
            ),
          ],
          if (existingOrderItemIndex != -1) ...[
            Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor)),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        subtractItem(itemId, itemName, double.parse(itemPrice));
                        orderTap = true;
                        Fluttertoast.showToast(msg: "One Item is removed");
                        setState(() {});
                      },
                      child: Icon(
                        Icons.remove,
                        color: Theme.of(context).hoverColor,
                      ),
                    ),
                    customText(
                      order[existingOrderItemIndex].quantity.toString(),
                      weight: FontWeight.w900,
                      font: 14.0,
                      color: Theme.of(context).highlightColor,
                    ),
                    GestureDetector(
                      onTap: () async {
                        processMenuItem(
                            itemId, itemName, double.parse(itemPrice), false);
                        // processMenuAddonsItem(
                        //     item_id, itemName, double.parse(itemPrice), false);
                      },
                      child: Icon(Icons.add,
                          color: Theme.of(context).indicatorColor),
                    )
                  ],
                )),
          ],
        ],
      ),
    );
  }

  dialog(itemName, itemId, bool status, List<Modifiers> modifierList,
      int modifierGroupID, String type,
      {List<Modifiers>? addonsList}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        int? selectedIndex;
        int addonSelectIndex = 0;
        return GetBuilder<GetModifierItemById>(builder: (controller) {
          return Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return PopScope(
                  onPopInvoked: (value) {
                    selectedIndex = 0;
                    addonSelectIndex = 0;
                    _isChecked.clear();
                    // Clear related variables
                    selectedvarients = 0;
                    modifierItemsById.items.clear();
                    varientitemname = '';
                    varientitemprice = 0;
                    addonsVarientid = '';
                    addonsname = '';
                    totalPrice = 0;
                    //  bothvarientId = '';
                    selectedAddonNames.clear();
                    // Reset the state
                    log("All Variable are cleared");
                    setState(() {});
                  },
                  child: Container(
                    height: addonsList == null
                        ? MediaQuery.of(context).size.height / 2.2
                        : MediaQuery.of(context).size.height / 1.5,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: customText("Varients".toUpperCase(),
                                font: 18.0,
                                color: Theme.of(context).highlightColor,
                                weight: FontWeight.w500,
                                spacing: 2.0)),
                        Expanded(
                          child: ListView.builder(
                            itemCount: modifierList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = modifierList[index];

                              return ListTile(
                                title: customText(
                                    "${modifierList[index].name} - ${modifierList[index].price}",
                                    font: 16.0,
                                    color: Theme.of(context).highlightColor),
                                leading: Radio(
                                  value: index,
                                  fillColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  groupValue: selectedIndex,
                                  focusColor: Theme.of(context).primaryColor,
                                  onChanged: (value) {
                                    //   vairantid = item.id;
                                    identifier = item.id;
                                    selectedIndex = index;
                                    selectedvarients = item.price;
                                    varientitemname = item.name;
                                    varientitemprice = item.price;

                                    setState(() {
                                      selectedIndex = value as int;
                                    });
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    identifier = item.id;
                                    selectedIndex = index;
                                    selectedvarients = item.price;
                                    varientitemname = item.name;
                                    varientitemprice = item.price;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        addonsList == null
                            ? const SizedBox.shrink()
                            : Center(
                                child: Text(
                                  "Add Ons".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 2,
                                      color: Theme.of(context).highlightColor),
                                ),
                              ),
                        addonsList == null
                            ? const SizedBox.shrink()
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: addonsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = addonsList[index];
                                    bool isSelected = addonSelectIndex == index;

                                    // setState(() {
                                    addons = true;
                                    // });
                                    return CheckboxListTile(
                                      value: _isChecked[index] ?? false,
                                      onChanged: (val) {
                                        setState(() {
                                          _isChecked[index] = val!;
                                          if (val) {
                                            addonSelectIndex = index;
                                            totalPrice += double.parse(
                                                item.price.toString());
                                            addonsVarientid =
                                                "$addonsVarientid${item.id}"
                                                    .removeAllWhitespace;
                                            selectedAddonNames.add(item.name!);
                                            addonsname =
                                                selectedAddonNames.join(", ");
                                          } else {
                                            addonSelectIndex = -1;
                                            totalPrice -= double.parse(
                                                item.price.toString());
                                            addonsVarientid.substring(
                                                0, addonsVarientid.length - 1);
                                            selectedAddonNames
                                                .remove(item.name);
                                          }
                                          log(totalPrice.toString());
                                        });
                                      },
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${item.name}- ${item.price}",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 2,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    );
                                  },
                                ),
                              ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {
                              if (selectedIndex == null) {
                                Fluttertoast.showToast(
                                    msg: "Please select Variant");
                              } else {
                                if (totalPrice != 0) {
                                  addItemToOrder(
                                      itemId,
                                      1,
                                      "$itemName-$varientitemname-$addonsname",
                                      "${double.parse(varientitemprice.toString()) + double.parse(totalPrice.toString())}",
                                      identifier.toString(),
                                      true,
                                      modifierGroupID.toString());
                                } else {
                                  iv_code = "${itemId}0000$identifier";
                                  log(modifierItemsById.modifiersGroupID
                                      .toString());
                                  addItemToOrder(
                                      itemId,
                                      1,
                                      "$itemName-$varientitemname",
                                      varientitemprice.toString(),
                                      identifier.toString(),
                                      true,
                                      modifierGroupID.toString());
                                }

                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        });
      },
    );
  }

//ACTION CHIP STARTS HERE
  Widget _menuCategoriesSelectorWidget(List<CategoryModel> menu) {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Visibility(
          visible: menu[index].items!.isNotEmpty,
          child: ActionChip(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onPressed: () {
              try {
                clickonActionChips = menu[index].categoryName;
                setState(() {});
              } catch (e) {
                debugPrint("$e");
              }
            },
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).highlightColor,
                // width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 6,
            pressElevation: 6,
            label: Text(
              menu[index].categoryName!,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
      itemCount: menu.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
    );
  }

//* Remove the Item on Long pressed----------------------->
  void removeItemToOrder(int existingOrderItemIndex, int itemId) {
    if (existingOrderItemIndex != -1) {
      setState(() {
        order.removeAt(existingOrderItemIndex);
      });
    }
  }

//* Add Item Order Method-------------------------------->
  void addItemToOrder(int itemId, int quantity, String itemName, String price,
      String vairentID, bool isAddition, String modifierGroup) {
    // Find the index of the item that matches itemId, vairentID, and modifiersGroupID
    int index = order.indexWhere((item) =>
        item.id == itemId &&
        item.vairentId == vairentID &&
        item.modifiersGroupID == modifierGroup);

    // If the item is found in the list
    if (index != -1) {
      // Update the quantity based on whether we're adding or subtracting
      setState(() {
        if (isAddition) {
          order[index].quantity += quantity;
        } else {
          order[index].quantity -= quantity;
          // Remove the item if the quantity becomes zero or less
          if (order[index].quantity <= 0) {
            order.removeAt(index);
          }
        }
      });
    } else {
      // If the item was not found in the list, add a new item
      if (quantity == 1) {
        // print("Enter in the if loop---------->");
        setState(() {
          order.add(
            Item(
              id: itemId,
              name: itemName,
              price: price,
              quantity: quantity,
              vairentId: vairentID,
              instruction: "",
              modifiersGroupID: modifierGroup,
            ),
          );
        });
      }
    }
  }

  Widget bottomSheetOrder(
      context, List<Item> order, openItemName, openItemPrice) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          customText("Order Confirmation",
              color: Theme.of(context).highlightColor),
          order.isEmpty
              ? const SizedBox(
                  width: 200.0,
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: order.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StatefulBuilder(builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return Container(
                          // height: 500.0,
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                end: Alignment
                                    .topLeft, // Start gradient from top
                                begin: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.6),
                                  Theme.of(context).focusColor,
                                ]),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(order[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor
                                                  .withOpacity(0.7),
                                              fontSize: 19.0)),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isPriceEditing = true;
                                              priceIndex = index;
                                            });
                                          },
                                          child: isPriceEditing &&
                                                  priceIndex == index
                                              ? StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      void Function(
                                                              void Function())
                                                          setState) {
                                                  return SizedBox(
                                                      height: 30.0,
                                                      width: 100.0,
                                                      child: TextField(
                                                        controller:
                                                            priceController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .highlightColor),
                                                        onChanged: (value) {
                                                          setState(() {
                                                              order[index].price = value;
                                                            isQuantityEditing =
                                                                false;
                                                          });
                                                        },
                                                      ));
                                                })
                                              : customText(
                                                  "₹ ${order[index].price}",
                                                  color: Theme.of(context)
                                                      .highlightColor
                                                      .withOpacity(0.7),
                                                  weight: FontWeight.bold,
                                                  font: 18.0)),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isQuantityEditing = true;
                                                editingindex = index;
                                              });
                                            },
                                            child: isQuantityEditing &&
                                                    editingindex == index
                                                ? StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        void Function(
                                                                void Function())
                                                            setState) {
                                                    return SizedBox(
                                                        height: 30.0,
                                                        width: 100.0,
                                                        child: TextField(
                                                          controller:
                                                              quantityController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .highlightColor),
                                                                  /////////////////////////
                                                                  
                                                          onChanged: (value) {
                                                            setState(() {
                                                                 newQuantity = double.tryParse(value) ?? order[index].quantity;
                                                            order[index].quantity = newQuantity;
                                                           
                                                            if (double.parse(order[index].price) == 0) {
                                                              if(double.parse(order[index].price) == 0 &&  order[index].quantity==1){
                                                                 newPrice =  unitPrice;
                                                                 order[index].price = newPrice.toString();
                                                              }else{
                                                                newPrice = unitPrice;
                                                                order[index].price = newPrice.toString();
                                                              }
                                                               
                                                            }
                                                            });
                                                          },

                                                          /////////////////////////////
                                                          onSubmitted: (value) {
                                                            setState(() {
                                                                if (double.parse(order[index].price) == 0) {
                                                                   order[index]
                                                                  .quantity = double
                                                                      .tryParse(
                                                                          value) ??
                                                                  order[index]
                                                                      .quantity;
                                                                }else{
                                                                   order[index]
                                                                  .quantity = int
                                                                      .tryParse(
                                                                          value) ??
                                                                  order[index]
                                                                      .quantity;
                                                                }
                                                             
                                                              isQuantityEditing =
                                                                  false;
                                                            });
                                                          },
                                                        ));
                                                  })
                                                : customText(
                                                    "Q: ${order[index].quantity.toString()}",
                                                    //order[index].quantity.toString(),
                                                    color: Theme.of(context)
                                                        .highlightColor
                                                        .withOpacity(0.7),
                                                    font: 18.0),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          isQuantityEditing
                                              ? const SizedBox.shrink()
                                              : Icon(
                                                  Icons.edit,
                                                  size: 20.0,
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                )
                                        ],
                                      ),
                                      widget.restaurantId == "217" ? SizedBox(
                                                        height: 30.0,
                                                        width: 100.0,
                                                        child: TextField(
                                                          controller:
                                                              quantityController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .highlightColor),
                                                                  /////////////////////////
                                                                  
                                                          onChanged: (value) {
                                                            
                                                          },

                                                          /////////////////////////////
                                                          onSubmitted: (value) {
                                                            setState(() {
                                                                
                                                            });
                                                          },
                                                        )) : const SizedBox.shrink()
                                      ///////////////
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      });
                    },
                  ),
                ),
          SizedBox(
            height: 55.0,
            width: 200.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Set border radius here
                    ),
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  // print(widget.customerId);
                  orderbookingScreen.confirmOrderBtnTap(
                    widget.customerId,
                    order,
                    widget.table_id,
                    widget.ordertype,
                    widget.table,
                    widget.floor,
                    widget.section_id,
                    takeAwayIDs,
                    dineTableID,
                    deliveryIDS,
                    advanceIds,
                    kotboolChecking,
                    context,
                    dateTime: widget.advanceOrderDateTime,
                  );
                },
                child: customText(
                  "Confirm Order",
                  font: 17.0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                )),
          )
        ],
      ),
    );
  }

  void processMenuItem(
      int itemId, String itemName, double itemPrice, bool modifierschecker) {
    // Cache to store item_id to menu item and modifiers mapping
    Map<int, ItemModel> itemMap = {};

    // Populate the cache with menu items and modifiers
    for (CategoryModel category in menucontroller.menu) {
      for (ItemModel item in category.items!) {
        itemMap[item.id!] = item;
      }
    }

    // Check if the item_id exists in the cache
    if (itemMap.containsKey(itemId)) {
      ItemModel selectedItem = itemMap[itemId]!;

      // Check if the item has modifier groups
      if (selectedItem.modifierGroups!.isEmpty) {
        addItemToOrder(itemId, 1, itemName, itemPrice.toString(), "$itemId",
            true, "$itemId");
      } else {
        handleModifiers(selectedItem, itemName, itemId, modifierschecker);
      }
    }
  }

  void handleModifiers(ItemModel selectedItem, String itemName, int itemId,
      bool modifierschecker) {
    List<Modifiers> allModifiers = [];
    int modifierGroupID = -1;
    String modifierType = '';
    List<Modifiers> addons = [];

    for (ModifierGroups group in selectedItem.modifierGroups!) {
      modifierGroupID = group.id!;
      modifierType = group.type!;

      if (group.type == "variants") {
        allModifiers.assignAll(group.modifiers!);
        // No need to do anything, variants are already added to allModifiers
      } else if (group.type == "add-ons") {
        addons.assignAll(group.modifiers!);
      }
    }

    dialog(itemName, itemId, modifierschecker, allModifiers, modifierGroupID,
        modifierType,
        addonsList: addons.isNotEmpty ? addons : null);
  }

//! Handling the Subtract Logic---------------------------------->
  // ignore: non_constant_identifier_names
  void subtractItem(int item_id, String itemName, double itemPrice) {
    // Cache to store item_id to menu item mapping
    Map<int, ItemModel> itemMap = {};

    // Populate the cache with menu items and modifiers
    for (CategoryModel category in menucontroller.menu) {
      for (ItemModel item in category.items!) {
        itemMap[item.id!] = item;
      }
    }

    // Check if the item_id exists in the cache
    if (itemMap.containsKey(item_id)) {
      ItemModel selectedItem = itemMap[item_id]!;

      // Check if the item has modifier groups (variants)
      if (selectedItem.modifierGroups!.isEmpty) {
        // No variants, use the default parameters
        addItemToOrder(item_id, 1, itemName, itemPrice.toString(), "$item_id",
            false, "$item_id");
      } else {
        // Handle variants
        handleVariants(selectedItem, itemName, item_id, itemPrice);
      }
    }
  }

  void handleVariants(
      ItemModel selectedItem, String itemName, int item_id, double itemPrice) {
    for (ModifierGroups group in selectedItem.modifierGroups!) {
      for (Modifiers modifier in group.modifiers!) {
        // Add logic here to determine which modifier to remove
        // For example, you can check if the modifier meets certain conditions

        // This is where you can add logic to determine which modifier to remove
        // Based on your application, you might want to pass different parameters
        addItemToOrder(
          item_id,
          1,
          "$itemName-$varientitemname-$addonsname",
          "${double.parse(varientitemprice.toString()) + double.parse(totalPrice.toString())}",
          identifier.toString(),
          false,
          iv_code,
        );
        break;
      }
      break;
    }
  }
}
