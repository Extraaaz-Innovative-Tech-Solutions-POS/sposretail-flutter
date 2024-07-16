import 'package:spos_retail/views/widgets/export.dart';

class CateringAdvance extends StatefulWidget {
  final String ordertype;
  final String? customerId;
  final String? tablenumber;
  final String? table_id;
  final String? customerName;
  final String? advanceOrderDateTime;

  const CateringAdvance(
      {Key? key,
      this.ordertype = "Advance",
      this.tablenumber,
      this.table_id,
      this.customerName,
      this.advanceOrderDateTime,
      this.customerId})
      : super(key: key);

  @override
  _CateringAdvanceState createState() => _CateringAdvanceState();
}

class _CateringAdvanceState extends State<CateringAdvance> {
  final menucontroller = Get.put(AllItemsController());
  final user = Get.put(UserController());
  final orderbookingScreen = Get.put(OrderBookingController());
  final cateringOrderController = Get.put(CateringOrderController());
  //List<Item> selectedItemList = [];

  late InvoiceManager invoiceManager;
  List<Item> order = [];
  var clickonActionChips, kotboolChecking, advanceIds;

  List<GlobalKey> itemKeys = [];

  final ScrollController scrollController = ScrollController();
  DateTime datetime = DateTime.now();
  String query = "";

  @override
  void initState() {
    super.initState();
    menucontroller.fetchMenu(0);
    clickonActionChips = "All";
    data = datetime.day;
    order.clear();
    checkKotStatus();
    setState(() {});
  }

  //////////////////////////////////////
  //  List<Item> selectedItems = [];

  ///////////////////////////////////////

  checkKotStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    kotboolChecking = pref.getBool("KOTBoolStatus");
    setState(() {});
  }

//* Generating the table Id. For the Particular Order.
  Future<void> generateCateringTableId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await DioServices.get(AppConstant.catering);
    print("Your Catering Advance Id value-------->");
    print(response.toString());
    if (response.statusCode == 200) {
      if (widget.table_id == null) {
        advanceIds = response.toString();
        print(response);
        prefs.setString("advance_id", advanceIds);
        setState(() {});
        // setState(() {

        // });
      }
    }
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
                    text: "Menu".padRight(5),
                    style: const TextStyle(fontSize: 18)),
                TextSpan(
                    text: widget.ordertype,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).highlightColor.withOpacity(0.7))),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min, // Adjust the size to fit the content
        children: [
          SizedBox(
            height: 40,
            width: 200,
            child: FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              label: Text(
                "Order Now",
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
              onPressed: () {
                generateCateringTableId()
                    .whenComplete(() => Get.to(() => CateringOrderConfirmScreen(
                          selectedMenuList: order.toList(),
                          //  tableId: advanceIds, //widget.table_id!,
                          customerId: "7",
                          advanceId: advanceIds, //widget.customerId!,
                        )));
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            search(context, onchange: (value) {
              setState(() {
                query = value;
              });
            }),
            Expanded(
              flex: 1,
              child: GetBuilder<AllItemsController>(builder: (controller) {
                return ListView(
                  controller: scrollController,
                  children: [
                    SizedBox(
                      height: 70,
                      child: _menuCategoriesSelectorWidget(controller.menu),
                    ),
                    ...controller.menu.asMap().entries.map((entry) {
                      String categoryTitle =
                          entry.value.categoryName.toString();

                      return clickonActionChips == "All"
                          ? allMenu(
                              entry, categoryTitle, context, entry.value.items!)
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
                                                  color: Theme.of(context).highlightColor),
                                            ),
                                          ),
                                        ),
                                        //////////////////////

                                        //const SizedBox(height: 20),
                                        _menuCategoryItemsGrid(
                                            context,
                                            entry.value.items!,
                                            "No Search Result Found"),
                                        const SizedBox(height: 20),
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

  Widget _menuCategoryItemsGrid(
      BuildContext context, List<ItemModel> items, empty) {
    cateringOrderController.selectedItemList.clear();
    return GetBuilder<AllItemsController>(builder: (controller) {
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
                    e.shortCode.toString() == query).toList();
                //     e.shortCode.toString().contains(query))
                // .toList();
        List<bool> selectedItems =
            List<bool>.generate(allFilteredItems.length, (index) => false);

        if (allFilteredItems.isEmpty) {
          return Center(
            child: customText(empty, color: Theme.of(context).highlightColor),
          );
        }

        return Center(
            child: DataTable(
          border: TableBorder.all(
              color: Theme.of(context).highlightColor.withOpacity(0.5)),
          columns: [
            DataColumn(
                label: customText(
              'Select',
              color: Theme.of(context).primaryColor,
            )),
            DataColumn(
                label: Text(
              'Item Name',
              style: TextStyle(color: Theme.of(context).primaryColor),
            )),
          ],
          rows: List<DataRow>.generate(allFilteredItems.length, (index) {
            return DataRow(
              cells: [
                DataCell(
                  StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return Checkbox(
                        checkColor: Theme.of(context).highlightColor,
                        activeColor: Theme.of(context).primaryColor,
                        // value: selectedItems[index],
                        value: selectedItems[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedItems[index] = value!;
                            if (value) {
                              order.add(
                                Item(
                                  id: allFilteredItems[index].id!,
                                  name: allFilteredItems[index].name.toString(),
                                  price: "0",
                                  quantity: 0,
                                  vairentId: "0",
                                  instruction: "",
                                  modifiersGroupID: "",
                                 
                                ),
                              );
                            } else {
                              // Find the index of the item to remove
                              int indexOfItemToRemove = order.indexWhere(
                                  (item) =>
                                      item.id == allFilteredItems[index].id);
                              // Remove the item if found
                              if (indexOfItemToRemove != -1) {
                                order.removeAt(indexOfItemToRemove);
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                DataCell(
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Center(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        allFilteredItems[index].name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: 15.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
      }
    });
  }

  Widget allMenu(
      entry, categoryTitle, BuildContext context, List<ItemModel> items) {
    final allFilteredItems = query.isEmpty
        ? items
        : items
            .where((e) =>
                e.name!.toLowerCase().contains(query.toLowerCase()) ||
                e.shortCode.toString() == query).toList();
            //     e.shortCode.toString().contains(query))
            // .toList();
    List<bool> selectedItems =
        List<bool>.generate(allFilteredItems.length, (index) => false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Visibility(
        visible: allFilteredItems.length != 0 ? true : false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                categoryTitle.toUpperCase(),
                style: TextStyle(
                    fontSize: 20, letterSpacing: 3, color: Theme.of(context).highlightColor),
              ),
            ),

            GetBuilder<AllItemsController>(builder: (controller) {
              return Center(
                  child: DataTable(
                border: TableBorder.all(
                    color: Theme.of(context).highlightColor.withOpacity(0.5)),
                columns: [
                  DataColumn(
                      label: customText(
                    'Select',
                    color: Theme.of(context).primaryColor,
                  )),
                  DataColumn(
                      label: Text(
                    'Item Name',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
                ],
                rows: List<DataRow>.generate(allFilteredItems.length, (index) {
                  return DataRow(
                    cells: [
                      DataCell(
                        StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return Checkbox(
                              checkColor: Theme.of(context).highlightColor,
                              activeColor: Theme.of(context).primaryColor,
                              // value: selectedItems[index],
                              value: selectedItems[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedItems[index] = value!;
                                  if (value) {
                                    order.add(
                                      Item(
                                        id: allFilteredItems[index].id!,
                                        name: allFilteredItems[index]
                                            .name
                                            .toString(),
                                        price: "0",
                                        quantity: 0,
                                        vairentId: "0",
                                        instruction: "",
                                        modifiersGroupID: "",
                                      
                                      ),
                                    );
                                  } else {
                                    // Find the index of the item to remove
                                    int indexOfItemToRemove = order.indexWhere(
                                        (item) =>
                                            item.id ==
                                            allFilteredItems[index].id);
                                    // Remove the item if found
                                    if (indexOfItemToRemove != -1) {
                                      order.removeAt(indexOfItemToRemove);
                                    }
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              allFilteredItems[index].name!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ));
            }),

            // _menuCategoryItemsGrid(
            //     context, entry.value.items!, ""),
          ],
        ),
      ),
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

//* Add Item Order Method-------------------------------->
  void addItemToOrder(int itemId, int quantity, String itemName, String price,
      String vairentID, bool isAddition, String iv_code, String modifierGroup) {
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
        print("Enter in the if loop---------->");
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

  void processMenuItem(
      int item_id, String itemName, double itemPrice, bool modifierschecker) {
    // Cache to store item_id to menu item and modifiers mapping
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

      // Check if the item has modifier groups
      if (selectedItem.modifierGroups!.isEmpty) {
        addItemToOrder(item_id, 1, itemName, itemPrice.toString(), "$item_id",
            true, "$item_id", item_id.toString());
      } else {}
    }
  }
}
