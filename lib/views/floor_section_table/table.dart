import 'package:spos_retail/views/widgets/export.dart';

class FloorSectionTable extends StatefulWidget {
  const FloorSectionTable({Key? key}) : super(key: key);

  @override
  State<FloorSectionTable> createState() => _FloorSectionTableState();
}

class _FloorSectionTableState extends State<FloorSectionTable> {
  // ignore: prefer_typing_uninitialized_variables
  var tableCount,
      sectionId,
      selectedFloorId,
      selectedSectionId,
      statusclick,
      tableId;
  final activetablecontroller = Get.put(ActiveTableController());
  final floorController = Get.put(FloorController());
  final tableTransferController = Get.put(TableTransferController());

  @override
  void initState() {
    super.initState();
    sectionController.fetchSection();
    sectionId = 0;
    final sections = floorController.floorSectionList[sectionId].sections;
    selectedFloorId = floorController.dropdownFloorSectionList.isEmpty
        ? null
        : floorController.dropdownFloorSectionList[0]["id"];
    selectedSectionId = floorController.floorSectionList.isNotEmpty
        ? sections.isNotEmpty
            ? floorController.floorSectionList[sectionId].sections[0].id
            : null
        : null;
    tableCount = floorController.floorSectionList.isNotEmpty
        ? floorController.floorSectionList[sectionId].sections.isNotEmpty
            ? floorController
                .floorSectionList[sectionId].sections[0].tablesCount
            : null
        : null;
    activetablecontroller.fetchActiveTable();
    sectionId;
    _statusbool();
    setState(() {});
  }

  Future<void> _statusbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    statusclick = prefs.getBool("CustomerDetailsBool");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    floorController.count.value = 0;
    floorController.fetchExistingFloor();
    String? selectedItem;
    String? selectedSection;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBar(context, "Floor", ""),
      body: Column(
        children: [
          selectedFloorId == null
              ? customText("No Floor Found")
              : Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border:
                          Border.all(color: Theme.of(context).highlightColor)),
                  padding: const EdgeInsets.only(left: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      value: selectedItem ??
                          (floorController.dropdownFloorSectionList.isNotEmpty
                              ? floorController
                                  .dropdownFloorSectionList.first["floorName"]
                              : null),
                      items: floorController.dropdownFloorSectionList
                          .asMap()
                          .entries
                          .map((entry) => DropdownMenuItem(
                                child: customText(entry.value["floorName"],
                                    color: Theme.of(context).highlightColor),
                                value: entry.value["floorName"],
                                onTap: () {
                                  setState(() {
                                    sectionId = entry.value["index"];
                                    selectedFloorId = entry.value["id"];

                                    ///heeeeeeeeeeeeeeeee
                                    tableCount = floorController
                                        .floorSectionList[sectionId]
                                        .sections[0]
                                        .tablesCount;
                                  });
                                },
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value.toString();
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Select Floor',
                          labelStyle: TextStyle(
                              color: Theme.of(context).highlightColor)),
                    ),
                  ),
                ),
          GetBuilder<FloorController>(builder: (c) {
            return c.floorSectionList.isNotEmpty
                ? c.floorSectionList[sectionId].sections.isEmpty
                    ? SizedBox(
                        height: screenHeight(context, dividedBy: 2),
                        child: Center(
                            child: customText("No Sections Found",
                                color: Theme.of(context).highlightColor,
                                font: 20.0,
                                weight: FontWeight.w500)))
                    : Container(
                        margin: const EdgeInsets.all(10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              c.floorSectionList[sectionId].sections.length,
                          itemBuilder: (context, index) {
                            final section =
                                c.floorSectionList[sectionId].sections[index];
                            return c.floorSectionList[sectionId].sections
                                    .isEmpty
                                ? customText("Please add Setions to continue",
                                    color: Theme.of(context).highlightColor)
                                : Card(
                                    color: c.floorSectionList[sectionId]
                                                .sections[index].id ==
                                            selectedSectionId
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).focusColor,
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          selectedSectionId = section.id;
                                          tableCount =
                                              int.parse(section.tablesCount);
                                        });
                                      },
                                      title: customText(section.name,
                                          color: c.floorSectionList[sectionId]
                                                      .sections[index].id ==
                                                  selectedSectionId
                                              ? Theme.of(context)
                                                  .scaffoldBackgroundColor
                                              : Theme.of(context)
                                                  .highlightColor),
                                      subtitle: customText(
                                          "Tables: ${section.tablesCount}",
                                          color: c.floorSectionList[sectionId]
                                                      .sections[index].id ==
                                                  selectedSectionId
                                              ? Theme.of(context)
                                                  .scaffoldBackgroundColor
                                              : Theme.of(context)
                                                  .highlightColor),
                                    ),
                                  );
                          },
                        ),
                      )
                : customText("No Section Found",
                    color: Theme.of(context).highlightColor,
                    font: 20.0,
                    weight: FontWeight.w500);
          }),
          floorController.floorSectionList.isNotEmpty
              ? floorController.floorSectionList[sectionId].sections.isEmpty
                  ? const SizedBox.shrink()
                  : GetBuilder<ActiveTableController>(
                      builder: (ActiveTableController controller) {
                      return Expanded(
                        child: GridView.builder(
                          itemCount: int.parse(tableCount.toString()),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 150,
                          ),
                          itemBuilder: (context, index) {
                            int tablenumber = index + 1;
                            String? time = activetablecontroller.checkbooked(
                                tablenumber,
                                int.parse(selectedSectionId.toString()),
                                int.parse(selectedFloorId.toString()));
                            return GestureDetector(onLongPress: () {
                              for (int indexs = 0;
                                  indexs <
                                      activetablecontroller
                                          .activeTableList.length;
                                  indexs++) {
                                final active = activetablecontroller
                                    .activeTableList[indexs];
                                if (active.tableNumber == tablenumber &&
                                    active.sectionId ==
                                        int.parse(
                                            selectedSectionId.toString()) &&
                                    active.floorId ==
                                        int.parse(selectedFloorId.toString())) {
                                  // Set to true if a match is found
                                  for (int activetable = 0;
                                      activetable < active.tableData!.length;
                                      activetable++) {
                                    Get.to(ShowOngoingOrder(
                                      ordertype: "Dine-In",
                                      floor: int.parse(
                                          selectedFloorId), //int.parse(widget.floor),
                                      table: tablenumber,
                                      tableId: active
                                          .tableData![activetable].tableId
                                          .toString(),
                                      items: const [],
                                    ));
                                  }
                                  break;
                                }
                              }
                            }, child: StatefulBuilder(builder:
                                (BuildContext context,
                                    void Function(void Function()) setState) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        // tableTransferController.tableTranfer();
                                        if (activetablecontroller
                                            .activeTableList.isEmpty) {
                                          _statusbool().whenComplete(() async {
                                            if (statusclick == true) {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setInt(
                                                  'SelectedFloorID',
                                                  int.parse(selectedFloorId
                                                      .toString()));
                                              prefs.setInt(
                                                  "TableNumber", tablenumber);
                                              prefs.setString("SectionId",
                                                  selectedSectionId.toString());
                                              Get.to(() =>
                                                  const DineInCustomerDetails());
                                            } else {
                                              Get.to(OrderBookingScreen(
                                                floor: int.parse(
                                                    selectedFloorId.toString()),
                                                table: tablenumber,
                                                ordertype: "Dine",
                                                section_id: selectedSectionId
                                                    .toString(),
                                              ));
                                            }
                                          });
                                          return; // Return to prevent further execution
                                        }

                                        bool foundMatch = false;
                                        for (final activeTable
                                            in activetablecontroller
                                                .activeTableList) {
                                          if (activeTable.tableNumber ==
                                                  tablenumber &&
                                              activeTable.sectionId ==
                                                  int.parse(selectedSectionId
                                                      .toString()) &&
                                              activeTable.floorId ==
                                                  int.parse(selectedFloorId
                                                      .toString())) {
                                            // Set to true if a match is found
                                            foundMatch = true;
                                            for (final tableData
                                                in activeTable.tableData!) {
                                              setState(() {
                                                tableId = tableData.tableId
                                                    .toString();
                                              });
                                              Get.to(OrderBookingScreen(
                                                floor:
                                                    int.parse(selectedFloorId),
                                                table: tablenumber,
                                                ordertype: "Dine",
                                                table_id: tableData.tableId,
                                                section_id: selectedSectionId
                                                    .toString(),
                                              ));
                                            }
                                            break; // Exit the loop once a match is found
                                          }
                                        }

                                        // Check if no match was found
                                        if (!foundMatch) {
                                          _statusbool().whenComplete(() async {
                                            if (statusclick == true) {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setInt(
                                                  'SelectedFloorID',
                                                  int.parse(selectedFloorId
                                                      .toString()));
                                              prefs.setInt(
                                                  "TableNumber", tablenumber);
                                              prefs.setString("SectionId",
                                                  selectedSectionId.toString());
                                              Get.to(() =>
                                                  const DineInCustomerDetails());
                                            } else {
                                              Get.to(OrderBookingScreen(
                                                floor: int.parse(
                                                    selectedFloorId.toString()),
                                                table: tablenumber,
                                                ordertype: "Dine",
                                                section_id: selectedSectionId
                                                    .toString(),
                                              ));
                                            }
                                          });
                                        }
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: time == null
                                                      ? Theme.of(context)
                                                          .scaffoldBackgroundColor
                                                      : Theme.of(context)
                                                          .primaryColor),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    Images.bgTable,
                                                  ),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(06),
                                              ),
                                              color:
                                                  Theme.of(context).focusColor),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 5),

                                              Align(
                                                alignment: Alignment.topRight,
                                                child:
                                                    //time != null ?
                                                    IconButton(
                                                        onPressed: () {
                                                          print(
                                                              activetablecontroller
                                                                  .activeTableList[
                                                                      index]
                                                                  .tableNumber
                                                              //.tableData?[0].
                                                              );
                                                          // .tableId);

                                                          showOptionsPopup(
                                                              context,
                                                              selectedItem,
                                                              selectedSection,
                                                              activetablecontroller
                                                                          .activeTableList[
                                                                              index]
                                                                          .tableData !=
                                                                      null
                                                                  ? activetablecontroller
                                                                      .activeTableList[
                                                                          index]
                                                                      .tableData![
                                                                          0]
                                                                      .tableId
                                                                  : 0,

                                                              // activetablecontroller
                                                              //     .activeTableList[
                                                              //         index]
                                                              //     .tableData![0]
                                                              //     .tableId ?? 0,
                                                              tablenumber
                                                                  .toString());
                                                        },
                                                        icon: const Icon(
                                                            Icons.more_vert)),
                                                //: null,
                                                // child: Icon)
                                              ),
                                              Center(
                                                  child: customText(
                                                      tablenumber.toString(),
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      font: 25.0,
                                                      weight: FontWeight.bold)),
                                              // ),
                                              time == null
                                                  ? const SizedBox.shrink()
                                                  : GetBuilder<
                                                          UtcTimeController>(
                                                      builder:
                                                          (utcTimeController) {
                                                      return customText(
                                                          calculateTimeDifferenceFromString(
                                                                  time,
                                                                  utcTimeController
                                                                      .utcTime)
                                                              .toString(),
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor);
                                                    }),
                                            ],
                                          )),
                                    ),
                                  ),
                                  // time == null
                                  //     ? Icon(Icons.compare_arrows,
                                  //         color: Theme.of(context)
                                  //             .scaffoldBackgroundColor)
                                  //     : GestureDetector(
                                  //         onTap: () {
                                  //           showAlertDialogForm(
                                  //               context: context,
                                  //               selectedItem: selectedItem,
                                  //               selectedSection:
                                  //                   selectedSection,
                                  //               tableId: activetablecontroller
                                  //                   .activeTableList[index]
                                  //                   .tableData?[0]
                                  //                   .tableId);
                                  //         },
                                  //         child:
                                  //             const Icon(Icons.compare_arrows))
                                ],
                              );
                            }));
                          },
                        ),
                      );
                    })
              : const SizedBox.shrink()
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  void showAlertDialogForm(
      {required BuildContext context,
      required selectedItem,
      required selectedSection,
      required tableId,
      required dynamic tableCount,
      required number}) {
    showDialog(
      context: context,
      builder: (ctx) {
        String? selectedTable;

        return AlertDialog(
          title: Text("Transfer Table $number"),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      value: selectedItem ??
                          (floorController.dropdownFloorSectionList.isNotEmpty
                              ? floorController
                                  .dropdownFloorSectionList.first["floorName"]
                              : null),
                      items: floorController.dropdownFloorSectionList
                          .asMap()
                          .entries
                          .map((entry) => DropdownMenuItem(
                                child: customText(
                                  entry.value["floorName"],
                                  //color: Theme.of(context).highlightColor
                                ),
                                value: entry.value["floorName"],
                                onTap: () {
                                  setState(() {
                                    sectionId = entry.value["index"];
                                    selectedFloorId = entry.value["id"];
                                  });
                                },
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value.toString();
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Floor',
                      ),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      value: selectedSection,
                      items: sectionController.dropdownSectionList
                          .asMap()
                          .entries
                          .map((entry) => DropdownMenuItem(
                                child: customText(entry.value["sectionName"]),
                                value: entry.value["sectionName"],
                                onTap: () {
                                  selectedSectionId = entry.value["id"];

                                  setState(() {});
                                },
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSection = value.toString();
                        });
                      },
                      decoration:
                          const InputDecoration(labelText: 'Select Section'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      value: selectedTable,
                      items: List.generate(
                        int.parse(tableCount),
                        (index) => DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text((index + 1).toString()),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedTable = value.toString();
                        });
                      },
                      decoration:
                          const InputDecoration(labelText: 'Select Table'),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     const Text('Table :- '),
                  //     const SizedBox(width: 10),
                  //     Expanded(
                  //       child: TextFormField(
                  //         controller: tableNumberController,
                  //         keyboardType: TextInputType.number,
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(),
                  //           labelText: 'Enter Table number',
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Dismiss'),
            ),
            ElevatedButton(
              onPressed: () {
                print(selectedSectionId + selectedFloorId + selectedTable);
                tableTransferController.tableTranfer(
                    tableId, selectedFloorId, selectedSectionId, selectedTable);

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Tranfer'),
            ),
          ],
        );
      },
    );
  }

  void showOptionsPopup(
      BuildContext context, selectedItem, selectedSection, tableId, number) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            listTile("Transfer", Icons.merge, onpress: () {
              showAlertDialogForm(
                  context: context,
                  selectedItem: selectedItem,
                  selectedSection: selectedSection,
                  tableId: tableId,
                  tableCount: tableCount.toString(),
                  number: number);
            }),
            // listTile("Split", Icons.merge, onpress: () {
            //   Navigator.of(context).pop();
            // }),
            // listTile("Merge", Icons.merge, onpress: () {
            //   Navigator.of(context).pop();
            // }),
          ],
        );
      },
    );
  }

  Widget listTile(title, IconData icon, {onpress}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onpress,
    );
  }
}
