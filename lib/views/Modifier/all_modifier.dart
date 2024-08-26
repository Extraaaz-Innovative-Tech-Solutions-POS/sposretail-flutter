import 'package:spos_retail/views/widgets/export.dart';

class AllModifierUI extends StatefulWidget {
  const AllModifierUI({super.key});

  @override
  State<AllModifierUI> createState() => _AllModifierUIState();
}

class _AllModifierUIState extends State<AllModifierUI> {
  final AllModifierListController allModifierListController =
      Get.put(AllModifierListController());
  final DeleteModifierController deleteModifierController =
      Get.put(DeleteModifierController());
  @override
  void initState() {
    super.initState();
    allModifierListController.getAllModifierList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBar(context, "Sub Items", ""),
      body: GetBuilder<AllModifierListController>(
          // stream: null,
          builder: (contexts) {
        return Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: allModifierListController.modifierAllItemsList.length,
              itemBuilder: (BuildContext context, int index) {
                return allModifierListController.modifierAllItemsList.isEmpty
                    ? Center(
                        child: customText("No Items found",
                            color: Theme.of(context).highlightColor),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(AddModifierUI(
                                modifierId: allModifierListController
                                    .modifierAllItemsList[index].id
                                    .toString(),
                                modifierName: allModifierListController
                                    .modifierAllItemsList[index].name,
                                modifierprice: allModifierListController
                                    .modifierAllItemsList[index].price,
                                modifierDescription: allModifierListController
                                    .modifierAllItemsList[index].description,
                                click: true,
                              ));
                            },
                            onLongPress: () {
                              showAlertdialog(
                                  allModifierListController
                                      .modifierAllItemsList[index]
                                      .name!
                                      .capitalizeFirst!,
                                  deleteModifierController,
                                  allModifierListController
                                      .modifierAllItemsList[index].id!
                                      .toString());
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15.00),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Center(
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        allModifierListController
                                            .modifierAllItemsList[index]
                                            .name!
                                            .capitalizeFirst!,
                                        // .padLeft(20),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16.0),
                                      ),
                                    )),
                                    Flexible(
                                        child: Text(
                                      allModifierListController
                                          .modifierAllItemsList[index].price
                                          .toString()
                                          .padRight(20),
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontSize: 16.0),
                                    ))
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Theme.of(context).highlightColor,
                          )
                        ],
                      );
              },
            )),
            Container(
              height: 40,
              width: 200,
              //  alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5.0),
                //  color: Theme.of(context).primaryColor,
              ),
              child: TextButton(
                child: Text(
                  'Add Modifier',
                  style: TextStyle(color: Theme.of(context).highlightColor),
                ),
                onPressed: () {
                  Get.to(AddModifierUI(
                    modifierName: "",
                    modifierDescription: "",
                    modifierprice: "",
                    modifierId: '',
                    click: false,
                  ));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Editmodifier()));
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<dynamic> showAlertdialog(
      String itemname, DeleteModifierController controller, String itemId) {
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
