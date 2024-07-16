import '../widgets/export.dart';

class StaffSettings extends StatefulWidget {
  const StaffSettings({super.key});

  @override
  State<StaffSettings> createState() => _StaffSettingsState();
}

class _StaffSettingsState extends State<StaffSettings> {
  final StaffController controller = Get.put(StaffController());
  bool deleteStaff = false;
  @override
  void initState() {
    super.initState();
    controller.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Staff Settings", ""),
        body:
            GetBuilder<StaffController>(builder: (StaffController controller) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: controller.users.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Updatestaff()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.3),
                                child: Container(
                                  decoration: cardBorder(context),
                                 // elevation: deleteStaff ? 10.0 : 0.0,
                                  child: ListTile(
                                    onTap: () {
                                      // deleteStaff = false;
                                      // setState(() {});
                                      Get.to(Addstaff(
                                        staffid: controller.users[index].id
                                            .toString(),
                                        onclick: false,
                                        name: controller.users[index].name,
                                        phone: controller.users[index].phone,
                                        email: controller.users[index].email,
                                            role: controller.users[index].role,
                                      ));
                                    },
                                    onLongPress: () {
                                      //deleteStaff = true;
                                      showAlertdialog(
                                          controller.users[index].name
                                              .toString(),
                                          controller,
                                          controller.users[index].id.toString(),
                                          index);
                                      setState(() {});
                                    },
                                    title: Text(
                                        '${controller.users[index].name} -  ${controller.users[index].phone ?? ""}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .highlightColor)),
                                    subtitle: customText(
                                        '${controller.users[index].role}'
                                            .toUpperCase(),
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ));
                        })),
                const SizedBox(height: 10),
                Center(
                  child: Text('Add Staff',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).highlightColor)),
                ),
                Center(
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Addstaff(staffid: '', onclick: true)));
                      },
                      icon: const Icon(Icons.add),
                      iconSize: 40,
                      color: Theme.of(context).primaryColor),
                )
              ]);
        }));
  }

  Future<dynamic> showAlertdialog(
    String itemname,
    StaffController controller,
    String item_id,
    int index,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10.0,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
            title: customText(
              "Are You Sure You Want To Delete $itemname",
                  font: 15.0, color: Theme.of(context).highlightColor,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    controller.deleteUser(controller.users[index].id!);
                    Get.back();
                    //  Get.to(BottomNav());
                    setState(() {});
                  },
                  child: customText(
                    "Yes",color: Theme.of(context).primaryColor,
                  )),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: customText("No",color: Theme.of(context).hoverColor)),
            ],
          );
        });
  }
}
