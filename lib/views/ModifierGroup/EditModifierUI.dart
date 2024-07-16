import 'package:spos_retail/views/widgets/export.dart';

class Editmodifier extends StatefulWidget {
  String id;
  String name;
  String type;

  String? description;
  bool Onclick;

  Editmodifier(
      {Key? key,
      required this.id,
      required this.name,
      required this.type,
      this.description,
      required this.Onclick});

  @override
  State<Editmodifier> createState() => _EditmodifierState();
}

bool modifierRestrict = false;
bool itemRestrict = false;
final updateModifier = Get.put(UpdateModifierGroupController());
final modifierlist = Get.put(GetModifierGroupController());
final sectionController = Get.put(SectionController());

class _EditmodifierState extends State<Editmodifier> {
  late int _selectedIndex;
  late List<String> _buttonTitles;

  late final TextEditingController titleController;
  late final TextEditingController typeController;
  late final TextEditingController descriptionController;
  String searchQuery = "";

  final showItemsModifierGroupController =
      Get.put(ShowModifierAndItemController());
  List<int> listid = [];
  List<int> newDataList = [];

  String? _selectedItem;
  var selectedSectionId;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    modifierRestrict = false;
    itemRestrict = false;
    searchQuery = "";
    // listid.clear();
    _buttonTitles = ['Basic Info', 'Items', 'Modifiers'];
    showItemsModifierGroupController.getshowItemsModifier(widget.id);
    showItemsModifierGroupController.getshowModifiers(widget.id);
    showItemsModifierGroupController.getSelectModifiers(widget.id);
    showItemsModifierGroupController.getSelectItems(widget.id);

    titleController =
        TextEditingController(text: widget.Onclick ? widget.name : "");
    typeController =
        TextEditingController(text: widget.Onclick ? widget.type : "");
    descriptionController =
        TextEditingController(text: widget.Onclick ? widget.description : "");
    sectionController.fetchSection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Edit Sub Items Groups", ""),
        body: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _buttonTitles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120, 40),
                          backgroundColor: _selectedIndex == index
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).focusColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          side: BorderSide(
                            color: _selectedIndex == index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).highlightColor,
                          )),
                      child: Text(
                        _buttonTitles[index],
                        style: TextStyle(
                            color: _selectedIndex == index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).highlightColor),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: _selectedIndex == 0
                  ? basicinfo(context, widget.id)
                  : _selectedIndex == 1
                      ? itemRestrict
                          ? buildwithCheckboxitems(
                              context, showItemsModifierGroupController)
                          : builditems(
                              context, showItemsModifierGroupController)
                      : _selectedIndex == 2
                          ? modifierRestrict
                              ? buildsavemodifier(
                                  context, showItemsModifierGroupController)
                              : buildrestrictmodifier(
                                  context, showItemsModifierGroupController)
                          : const SizedBox(),
            ),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: _selectedIndex == 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      //  alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: TextButton(
                        child: customText(
                          'Save',
                          color: Theme.of(context).highlightColor,
                        ),
                        onPressed: () {
                          // print(titleController.text);
                          // Get.to(AllModifierGroupUI());

                          updateModifier.updatemodifier(
                              widget.id,
                              titleController.text,
                              descriptionController.text,
                              typeController.text,
                              selectedSectionId);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Editmodifier()));
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 40,
                      width: 100,
                      margin: const EdgeInsets.only(top: 10.0, bottom: 20),
                      //  alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5.0),
                        // color: Theme.of(context).primaryColor,
                      ),
                      child: TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Theme.of(context).highlightColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              )
            : _selectedIndex == 1
                ? itemRestrict
                    ? floatingButton(
                        "Save",
                        onpress: () {
                          showItemsModifierGroupController.postSavedItems(
                              widget.id, newDataList);
                          itemRestrict = false;

                          searchQuery = "";
                          // Get.to(AllModifierGroupUI());
                          setState(() {});
                        },
                      )
                    : floatingButton(
                        "Restrict Items",
                        onpress: () {
                          itemRestrict = true;
                          searchQuery = "";
                          // controller.getSelectItems();
                          setState(() {});
                        },
                      )
                : _selectedIndex == 2
                    ? modifierRestrict
                        ? floatingButton("Save", onpress: () {
                            modifierRestrict = false;
                            showItemsModifierGroupController.postSaveModifiers(
                                widget.id, listid);

                            //listid.clear();
                            setState(() {});
                          })
                        : floatingButton("Restrict Modifier", onpress: () {
                            modifierRestrict = true;

                            setState(() {});
                          })
                    : const SizedBox.shrink());
  }

//* Build Save Modifiers(It gives checkbox in the UI and SelectModifier is API Called)
  Widget buildsavemodifier(context, ShowModifierAndItemController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: search(context, onchange: (value) {
                    setState(() {
                      searchQuery = value;
                      print("QUERY IS THIS $searchQuery");
                    });
                  })),
              Expanded(child: SingleChildScrollView(
                child: GetBuilder<ShowModifierAndItemController>(
                    builder: (ShowModifierAndItemController controller) {
                  if (controller.selectModifierList.isEmpty) {
                    return const Center(child: Text("Error"));
                  } else {
                    final modifierList = searchQuery.isEmpty
                        ? controller.selectModifierList
                        : controller.selectModifierList
                            .where((e) => e.name!
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .toList();
                    if (modifierList.isEmpty) {
                      return const Center(child: Text("Error"));
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: DataTable(
                              // dataRowHeight: 80,
                              border: TableBorder.all(
                                  color: Theme.of(context)
                                      .highlightColor
                                      .withOpacity(0.5)),
                              columns: [
                                DataColumn(
                                    label: Text(
                                  'Check',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Item Name',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Price',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                              ],
                              rows: List<DataRow>.generate(modifierList.length,
                                  (index) {
                                List<bool> isCheckedList = List.generate(
                                  modifierList.length,
                                  (index) => controller.listid
                                      .contains(modifierList[index].id),
                                );
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      StatefulBuilder(builder:
                                          (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                        return Checkbox(
                                          value: isCheckedList[index],
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value == true) {
                                                final newId =
                                                    modifierList[index].id;
                                                setState(() {
                                                  listid.add(
                                                      newId); // Add the new ID
                                                  listid.addAll(
                                                      controller.listid.cast<
                                                          int>()); // Convert to int and add all elements from controller.listid
                                                  isCheckedList[index] = true;
                                                });
                                              } else {
                                                final removedId =
                                                    modifierList[index].id;
                                                listid.clear();
                                                setState(() {
                                                  controller.listid.remove(
                                                      removedId); // Remove the ID from the list
                                                  isCheckedList[index] =
                                                      false; // Update isCheckedList to false
                                                  listid.addAll(controller
                                                      .listid
                                                      .cast<int>());
                                                });
                                              }
                                            });
                                          },
                                        );
                                      }),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          modifierList[index].name,
                                          // .padLeft(10),
                                          // textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontSize: 15.0),
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(
                                      modifierList[index]
                                          .price
                                          .toString()
                                          .padRight(15),
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontSize: 15.0),
                                    )),
                                  ],
                                );
                              }),
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    }
                  }
                }),
              )),
            ],
          ),
        )
      ],
    );
  }

//* Build Restrict Modifiers( ShowModifier is API Called Without Checkbox)
  Widget buildrestrictmodifier(
      context, ShowModifierAndItemController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name".padLeft(10),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 17.0),
                  ),
                  Text(
                    "Price".padRight(15),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 17.0),
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              GetBuilder<ShowModifierAndItemController>(
                  builder: (ShowModifierAndItemController controller) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: controller.showModifierList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      controller.showModifierList[index].name,
                                      // .padLeft(15),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontSize: 15.0),
                                    )),
                              ),
                              Flexible(
                                  child: Text(
                                controller.showModifierList[index].price
                                    .toString()
                                    .padRight(15),
                                style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 15.0),
                              ))
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color: Theme.of(context).highlightColor,
                        )
                      ],
                    );
                  },
                ));
              }),
            ],
          ),
        )
      ],
    );
  }

//* Build items With Checkbox----------->
  Widget buildwithCheckboxitems(
      context, ShowModifierAndItemController controller) {
    // String searchQuery = "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10.0, left: 5.0, bottom: 10.0),
          child: customText(
            'All Items',
            font: 20.0,
            color: Theme.of(context).highlightColor,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: search(context, onchange: (value) {
              setState(() {
                searchQuery = value;
                print("QUERY IS THIS $searchQuery");
              });
            })),
        Expanded(
          child: SingleChildScrollView(
            child: GetBuilder<ShowModifierAndItemController>(
                builder: (ShowModifierAndItemController controller) {
              if (controller.selectItemsList.isEmpty) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                final itemlist = searchQuery.isEmpty
                    ? controller.selectItemsList
                    : controller.selectItemsList
                        .where((e) => e.itemName!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                        .toList();
                print("ItemLIST -----${itemlist.length}");
                if (itemlist.isEmpty) {
                  return const Center(
                    child: Text('Customer details not found'),
                  );
                } else {
                  return Center(
                      child: DataTable(
                    border: TableBorder.all(
                        color:
                            Theme.of(context).highlightColor.withOpacity(0.5)),
                    columns: [
                      DataColumn(
                          label: customText(
                        'Check',
                        color: Theme.of(context).primaryColor,
                      )),
                      DataColumn(
                          label: Text(
                        'Item Name',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                      DataColumn(
                          label: Text(
                        'ID',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                    ],
                    rows: List<DataRow>.generate(itemlist.length, (index) {
                      List<bool> isCheckedList = List.generate(
                        itemlist.length,
                        (index) =>
                            controller.itemlistid.contains(itemlist[index].id),
                      );
                      return DataRow(
                        cells: [
                          DataCell(
                            StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return Checkbox(
                                  checkColor: Theme.of(context).highlightColor,
                                  activeColor: Theme.of(context).primaryColor,
                                  value: isCheckedList[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        final newId = itemlist[index].id;
                                        setState(() {
                                          newDataList.add(newId);
                                          newDataList.addAll(controller
                                              .itemlistid
                                              .cast<int>()
                                              .toSet());
                                          isCheckedList[index] = true;
                                        });
                                      } else {
                                        final removedId = itemlist[index].id;
                                        newDataList.clear();
                                        setState(() {
                                          controller.itemlistid
                                              .remove(removedId);
                                          isCheckedList[index] = false;
                                          newDataList.addAll(controller
                                              .itemlistid
                                              .cast<int>()
                                              .toSet());
                                        });
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
                                  itemlist[index].itemName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 15.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              itemlist[index].id.toString(),
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ));
                  // );
                  //   ],
                  // );
                }
              }
            }),
          ),
        )
      ],
    );
  }

//* Build items Without Checkbox--------------->
  Widget builditems(context, ShowModifierAndItemController controller) {
    return Column(
      children: [
        const SizedBox(
          height: 30.0,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name".padLeft(15),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 17.0),
                  ),
                  Text(
                    "Category".padRight(15),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 17.0),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              GetBuilder<ShowModifierAndItemController>(
                  builder: (ShowModifierAndItemController controller) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: controller.showItemModifierList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return controller.showItemModifierList.isEmpty
                        ? Center(
                            child: customText("No Items found",
                                color: Theme.of(context).highlightColor),
                          )
                        : Column(
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        controller
                                            .showItemModifierList[index].name!,
                                        // .padLeft(20),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 15),
                                      )),
                                  Flexible(
                                      child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    controller.showItemModifierList[index].id
                                        .toString()
                                        .padRight(20),
                                    style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: 15),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Divider(
                                thickness: 1.0,
                                color: Theme.of(context).highlightColor,
                              )
                            ],
                          );
                  },
                ));
              }),
            ],
          ),
        )
      ],
    );
  }

  Widget basicinfo(context, modifierId) {
    // TextEditingController descriptionController = TextEditingController();

    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(8),
        height: 50,
        alignment: Alignment.centerLeft,
        child: customText(
          "Modifiers",
          font: 16.0,
          color: Theme.of(context).highlightColor,
        ),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      buildTextFieldWithHeading("Title", widget.name, context, titleController),
      const SizedBox(height: 5),
      buildTextFieldWithHeading(
          "Modifier Group Type", widget.type, context, typeController),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Text(
          "Select Section",
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
      ),
      GetBuilder<SectionController>(builder: (SectionController controller) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Theme.of(context).highlightColor)),
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.all(10),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField(
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              value: _selectedItem,
              items: controller.dropdownSectionList
                  .asMap()
                  .entries
                  .map((entry) => DropdownMenuItem(
                        child: customText(entry.value["sectionName"],
                            color: Theme.of(context).highlightColor),
                        value: entry.value["sectionName"],
                        onTap: () {
                          selectedSectionId = entry.value["id"];

                          setState(() {});
                        },
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value.toString();
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Select Section',
                  labelStyle:
                      TextStyle(color: Theme.of(context).highlightColor)),
            ),
          ),
        );
      }),
      const SizedBox(height: 5),
      description("Description", context, descriptionController),
      const SizedBox(height: 60),
    ]));
  }

  Widget buildTextFieldWithHeading(
      String heading, hint, BuildContext context, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: customText(
            heading,
            font: 16.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.all(16.0),
          color: Theme.of(context).focusColor,
          child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.grey))),
        ),
      ],
    );
  }

  Widget description(String heading, BuildContext context, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            heading,
            style:
                TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 100,
            width: 378,
            decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                border: Border.all(color: Theme.of(context).highlightColor),
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  hintText: 'Enter $heading...',
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
        ),
      ],
    );
  }

  Widget floatingButton(title, {onpress}) {
    return Container(
      height: 40,
      width: 148,
      margin: const EdgeInsets.only(top: 10.0, bottom: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextButton(
          child: customText(
            title,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: onpress),
    );
  }
}
// 