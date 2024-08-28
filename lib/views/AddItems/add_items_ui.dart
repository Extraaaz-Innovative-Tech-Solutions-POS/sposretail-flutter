import 'package:spos_retail/views/widgets/export.dart';

class AddItems extends StatefulWidget {
  List<ItemModel> itemsInCategory;
  int categoryID;
  AddItems({
    Key? key,
    required this.itemsInCategory,
    required this.categoryID,
  }) : super(key: key);

  @override
  State<AddItems> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddItems> {
  final ItemController itemsController = Get.put(ItemController());
  @override
  void initState() {
    super.initState();
    //itemsController.fetchItems();
  }

  bool deleteButtonClicked = false;
  var deleteindex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, "Add Items", ""),
        body: GetBuilder<ItemController>(builder: (ItemController controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: headingTitle(context, "Items"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatefulBuilder(builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Wrap(runSpacing: 15, spacing: 10, children: [
                      ...widget.itemsInCategory.asMap().entries.map((category) {
                        final index = category.key;
                        return GestureDetector(
                          onTap: () {
                            deleteButtonClicked = false;
                            deleteindex = -1;
                            Get.to(AddItemsForm(
                              categoryId: widget.categoryID,
                              updateisClick: true,
                              itemId: category.value.id,
                              price: "${category.value.price}",
                              name: category.value.name.toString(),
                              discount: category.value.discount.toString(),
                            ));
                            setState(() {});
                          },
                          onLongPress: () {
                            deleteButtonClicked = true;
                            deleteindex = index;
                            showAlertdialog(category.value.name.toString(),
                                controller, category.value.id.toString());
                          },
                          child: Container(
                            height: 80,
                            width: screenWidth(context, dividedBy: 2.5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: deleteindex == index
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).highlightColor,
                              ),
                              color: Theme.of(context).focusColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    // child: Flexible(
                                      child:
                                    Text(
                                      category.value.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    ),
                                    // )
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Price ₹${category.value.price}".padRight(10),
                                       overflow: TextOverflow.ellipsis,
                                          
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ]);
                  }),
                ),
                // Spacer(),
                SizedBox(
                  width: 200.0,
                  child: deleteButtonClicked
                      ? const SizedBox.shrink()
                      : ElevatedButton(
                          onPressed: () {
                            Get.to(AddItemsForm(
                              categoryId: widget.categoryID,
                              updateisClick: false,
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          child: customText("Add Items",
                              color:
                                  Theme.of(context).scaffoldBackgroundColor)),
                )
              ],
            ),
          );
        }));
  }

  Future<dynamic> showAlertdialog(
      String itemname, ItemController controller, String itemId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10.0,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
            title: Text(
              "Are you sure you want to delete $itemname",
              style: TextStyle(
                  fontSize: 15.0, color: Theme.of(context).highlightColor),
            ),
            actions: [
                  textButton("Yes", Theme.of(context).primaryColor, onpress: () {
                    controller.deleteItem(itemId);
                    Get.back();
                    Get.to(BottomNav());
                    setState(() {});
                  }),
                  textButton("No", Theme.of(context).hoverColor, onpress: () {
                    Get.back();
                  })
            ],
          );
        });
  }
}
