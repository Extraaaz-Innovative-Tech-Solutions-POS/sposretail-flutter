import 'package:spos_retail/views/widgets/export.dart';

class AddFloorSection extends StatefulWidget {
  AddFloorSection({Key? key}) : super(key: key);

  @override
  State<AddFloorSection> createState() => _AddFloorSectionState();
}

class _AddFloorSectionState extends State<AddFloorSection> {
  var sectionId, selectedFloorId, selectedSectionId;
  final sectionController = Get.put(SectionController());
  List sectionList = [];
  List tableList = [];
  @override
  void initState() {
    super.initState();
    selectedFloorId = 0;
    selectedSectionId = 0;
    sectionId = 0;
    sectionController.fetchSection();
  }

  @override
  Widget build(BuildContext context) {
    // final sectionController = Get.put(SectionController());
    final floorController = Get.put(FloorController());
    floorController.count.value = 0;
    floorController.fetchExistingFloor();
    final countController = TextEditingController();
    final GlobalKey<FormState> _countKey = GlobalKey<FormState>();
    String? _selectedItem;
    // String? _selectedItem;

    // @override
    // void initState() {
    //   super.initState();
    //   sectionController.fetchSection();
    // }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBar(context, "Add Floor/ Section", ""),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Theme.of(context).highlightColor)),
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                //value: _selectedItem,
                value: _selectedItem,
                // ??
                //     (floorController.dropdownFloorSectionList.isNotEmpty
                //         ? floorController
                //             .dropdownFloorSectionList.first["floorName"]
                //         : null),
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

                              sectionList.clear();
                              tableList.clear();

                              for (var section in floorController
                                  .floorSectionList[sectionId].sections) {
                                sectionList.add(section.id);
                                tableList.add(section.tablesCount);
                              }
                            });
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
                    labelText: 'Select Floor',
                    labelStyle:
                        TextStyle(color: Theme.of(context).highlightColor)),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Theme.of(context).highlightColor)),
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.all(10),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                value: _selectedItem,
                items: sectionController.dropdownSectionList
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
          ),
          Container(
            //height: 70.0,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 06),

            child: Form(
              key: _countKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: countController,
                style: TextStyle(color: Theme.of(context).highlightColor),
                textInputAction: TextInputAction.next,
                enableSuggestions: true,
                decoration: InputDecoration(
                  hintText: "Table Count",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    // Set consistent border for all states
                    borderSide: BorderSide(
                        color: Theme.of(context).highlightColor,
                        width: 1.0), // Set border color and width
                  ),
                  hintStyle: TextStyle(
                      color: Theme.of(context).highlightColor.withOpacity(0.6)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    gapPadding: 19,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                ),
                validator: (value) {
                  if (value == "") {
                    return 'Please Enter Table Count';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onPressed: () {
                sectionList.add(selectedSectionId);
                tableList.add(countController.text);
                // Get.back();
                print(
                    "SELECTED FLOOR ID $selectedFloorId + $sectionList + $tableList");

                sectionController.assignSectionTables(
                    selectedFloorId, sectionList, tableList);
              },
              child: customText("Add Sections",
                  color: Theme.of(context).scaffoldBackgroundColor)),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
