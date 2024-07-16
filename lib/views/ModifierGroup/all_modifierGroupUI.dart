import 'package:spos_retail/views/widgets/export.dart';

class AllModifierGroupUI extends StatefulWidget {
  const AllModifierGroupUI({super.key});

  @override
  State<AllModifierGroupUI> createState() => _AllModifierGroupUIState();
}

class _AllModifierGroupUIState extends State<AllModifierGroupUI> {
  String query = '';
  final getAllModifierGroupController = Get.put(GetModifierGroupController());
  final DeleteGroupModifierController deletegroupModifier =
      Get.put(DeleteGroupModifierController());
  final modifierlist = Get.put(GetModifierGroupController());
  @override
  void initState() {
    super.initState();
    query = "";
    getAllModifierGroupController.getModifierGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Sub Items Groups", ""),
      body: GetBuilder<GetModifierGroupController>(
          builder: (GetModifierGroupController controller) {
        //controller.getModifierGroup();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor, // Change the color here
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust border radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                              color: Theme.of(context).highlightColor),
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search food',
                            hintStyle: TextStyle(
                                color: Theme.of(context).highlightColor),
                            border: InputBorder.none, // Hide the default border
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<GetModifierGroupController>(builder: (c) {
                if (c.getModifierList.isEmpty) {
                  return const Center(
                    child: Text("No Modifier Group Found"),
                  );
                } else {
                  final allModifierGroup = query.isEmpty
                      ? c.getModifierList
                      : c.getModifierList
                          .where((e) => e.name
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();

                  if (allModifierGroup.isEmpty) {
                    return Center(
                      child: customText("No Search Result Found",
                          color: Theme.of(context).highlightColor),
                    );
                  }

                  return ListView.builder(
                    itemCount: allModifierGroup.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          showAlertdialog(
                              allModifierGroup[index].name.toString(),
                              deletegroupModifier,
                              allModifierGroup[index].id.toString());
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Editmodifier(
                                Onclick: true,
                                id: allModifierGroup[index].id.toString(),
                                name: allModifierGroup[index].name,
                                type: allModifierGroup[index].type.toString(),
                                description:
                                    allModifierGroup[index].description,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              border: Border.all(
                                  color: Theme.of(context).highlightColor),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text('${allModifierGroup[index].name}',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          customText(
                                              'Type- ${allModifierGroup[index].type}',
                                              color: Theme.of(context)
                                                  .highlightColor),
                                          customText(
                                              'Section - ${allModifierGroup[index].sectionname}'
                                                  .toUpperCase(),
                                              color: Theme.of(context)
                                                  .highlightColor),
                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          customText(
                                              'Items - ${controller.getModifierList[index].itemCount}',
                                              color: Theme.of(context)
                                                  .highlightColor),
                                          customText(
                                              'Modifiers - ${controller.getModifierList[index].modifiersCount}',
                                              color: Theme.of(context)
                                                  .highlightColor),
                                        ],
                                      ),

                                      // SizedBox(
                                      //   height: 50,
                                      //   child: VerticalDivider(
                                      //     color: Colors.black,
                                      //     thickness: 1,
                                      //   ),
                                      // ),
                                      //   SizedBox(width: 30),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                //  backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text(
                'New Modifier Group',
                style: TextStyle(color: Theme.of(context).highlightColor),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddModifierGroupUI()));
              },
            ),
          ],
        );
      }),
    );
  }

  Future<dynamic> showAlertdialog(String itemname,
      DeleteGroupModifierController controller, String itemId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10.0,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
            title: Text(
              "Are You Sure You Want To Delete $itemname",
              style: TextStyle(
                  fontSize: 15.0, color: Theme.of(context).highlightColor),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    controller.deleteModifiercontroller(itemId);
                    Get.back();
                    //  Get.to(BottomNav());
                    setState(() {});
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("No",
                      style: TextStyle(color: Theme.of(context).hoverColor))),
            ],
          );
        });
  }
}
