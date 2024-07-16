import '../../widgets/export.dart';

class CateringCustomerDetails extends StatefulWidget {
  String tableId;
  List items;
  String customerId;

  CateringCustomerDetails(
      {super.key,
      required this.tableId,
      required this.items,
      required this.customerId});

  @override
  State<CateringCustomerDetails> createState() =>
      _CateringCustomerDetailsState();
}

class _CateringCustomerDetailsState extends State<CateringCustomerDetails> {
  String searchQuery = '';

  Future<dynamic> showAlertdialog(
      DeleteCustomerController controller, String id, String name) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10.0,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
            title: Text(
              "Are You Sure You Want To Delete  Customer $name",
              style: TextStyle(
                  fontSize: 15.0, color: Theme.of(context).highlightColor),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    controller.deleteCustomer(id);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBar(context, "Customer Details", ""),
      body: Column(children: [
        search(context, onchange: (value) {
          setState(() {
            searchQuery = value;
            print("QUERY IS THIS $searchQuery");
          });
        }),
        Expanded(child: GetBuilder<CustomerlistController>(
            builder: (CustomerlistController c) {
          if (c.customer.isEmpty) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            final customerlist = searchQuery.isEmpty
                ? c.customer
                : c.customer
                    .where((e) => e.name!
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();

            if (customerlist.isEmpty) {
              return const Center(
                child: Text('Customer details not found'),
              );
            } else {
              return ListView.builder(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: customerlist.length,
                  // 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).focusColor,
                          border: Border.all(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: ListTile(
                            onLongPress: () {
                              showAlertdialog(
                                  deleteCustomercontroller,
                                  customerlist[index].id.toString(),
                                  customerlist[index].name.toString());
                            },
                            onTap: () {
                              Get.to(CateringAdvanceCustomerDetails(
                                name: c.customer[index].name.toString(),
                                phone: c.customer[index].phone.toString(),
                                address: c.customer[index].address.toString(),
                                tableId: widget.tableId,
                                items: widget.items,
                                customerId: c.customer[index].id.toString(),
                              ));
                            },
                            title: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Customer',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).highlightColor),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(children: [
                                  Text('Name:',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .highlightColor)),
                                  const SizedBox(width: 8),
                                  Text(customerlist[index].name.toString(),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .highlightColor)),
                                ]),
                                Row(
                                  children: [
                                    Text('Phone:',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor)),
                                    const SizedBox(width: 8),
                                    Text(customerlist[index].phone.toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Address:',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor)),
                                    const SizedBox(width: 8),
                                    Text(customerlist[index].address.toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor))
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  });
            }
          }
        })),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            // RoundedRectangleBorder(
            //     borderRadius: BorderRadius.zero,
            //     ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: Text(
            'Add Customer',
            style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateCustomer(
                          customerId: '',
                          click: false,
                        )));
          },
        ),
      ]),
    );
  }
}
