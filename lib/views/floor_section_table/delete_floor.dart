import 'package:spos_retail/views/widgets/export.dart';

class DeleteFloor extends StatefulWidget {
  const DeleteFloor({Key? key}) : super(key: key);

  @override
  State<DeleteFloor> createState() => _DeleteFloorState();
}

class _DeleteFloorState extends State<DeleteFloor> {
  final FloorController floorController = Get.put(FloorController());
  final DeleteFloorController deleteFloorController =
      Get.put(DeleteFloorController());

  @override
  void initState() {
    super.initState();
    floorController.fetchAllFloor(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Delete Floor", ""),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Drag the Floor to Delete',
              style: TextStyle(color: Theme.of(context).highlightColor),
            ),
          ),
          GetBuilder<FloorController>(
            builder: (FloorController c) {
              if (c.floorSectionList.isEmpty) {
                print(c.floorSectionList.length);
                return Center(
                    child: (Text(
                  "Error ",
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                  ),
                )));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: c.floorSectionList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                            border: Border.all(
                              color: Theme.of(context).highlightColor,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Dismissible(
                            key: Key(c.floorSectionList[index].id),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              color: Theme.of(context).hoverColor,
                              child: Icon(Icons.delete,
                                  color: Theme.of(context).highlightColor),
                            ),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (Direction) {
                              deleteFloorController
                                  .deleteFloor(c.floorSectionList[index].id);
                              setState(() {
                                c.floorSectionList.removeAt(index);
                              });
                            },
                            child: ListTile(
                              onTap: () {},
                              title: Text(
                                c.floorSectionList[index].floorName,
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                );
              }
            },
          ),
        ])));
  }
}
