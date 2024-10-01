import 'package:spos_retail/views/widgets/export.dart';

class CustomerList extends StatefulWidget {
  bool update;
  String orderType;
  CustomerList({
    Key? key,
    required this.update,
    required this.orderType,
  }) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

final DeleteCustomerController deleteCustomercontroller =
    DeleteCustomerController();
final CustomerlistController customerlistController =
    Get.put(CustomerlistController());
final cartController = Get.put(CartController());
final newcustomer = Get.put(AddCustomerController());
final allItemsController = Get.put(AllItemsController());
final orderbookingController = Get.put(OrderBookingController());

class _CustomerListState extends State<CustomerList> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    customerlistController.getcustomerlist(false);
  }

  var sectionId, floorId, tablenumber;
  Future<void> _statusbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    floorId = prefs.getInt("SelectedFloorID");
    sectionId = prefs.getString("SectionId");
    tablenumber = prefs.getInt("TableNumber");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // String searchQuery = '';
    return Column(children: [
      search(context, onchange: (value) {
        setState(() {
          searchQuery = value;
        });
      }),
      Expanded(child: GetBuilder<CustomerlistController>(
          builder: (CustomerlistController c) {
        if (c.customer.isEmpty) {
          return const Center(
            child: Text('Loading'),
          );
        } else {
          final customerlist = searchQuery.isEmpty
              ? c.customer.reversed.toList()
              : c.customer
                  .where((e) => e.phone!
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList().reversed.toList();

          if (customerlist.isEmpty) {
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20.0),
                    Flexible(
                      // child: textField(context, "Enter Name", nameController, Icons.arrow_right, 10.2),
                      child: TextField(
                          onChanged: (value) {
                            newcustomer.newName.value = value;
                          },
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            

                            hintText: "Enter your name",
                            contentPadding:
                                EdgeInsets.only(top: 0.0, bottom: 11.0, left:20.0),

                            //  icon: Icon(icon),
                          )),
                    ),
                    const SizedBox(width: 20.0),

                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'Add Customer',
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      onPressed: () {
                        // newcustomer.postcustomer(newcustomer.newName.value
                        //     , searchQuery);
                        newcustomer.postcustomer(newcustomer.newName.value, searchQuery);
                        print("tes postvale ${ newcustomer.newName.value } ${searchQuery}  newID ${newcustomer.newCustomerID.value}");
                      },
                    ),
                    const SizedBox(width: 20.0),
                  ],
                ),
              ),
            );

            // const Center(
            //   child: Text('Customer details not foundgggggggggg'),
            // );
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
                        border:
                            Border.all(color: Theme.of(context).highlightColor),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ListTile(
                          onLongPress: () {
                            showAlertdialog(
                                deleteCustomercontroller,
                                customerlist[index].id.toString(),
                                customerlist[index].name.toString());
                          },
                          onTap: widget.update
                              ? () {
                                allItemsController.fetchMenu(
                                                          sectionId.toString());
                                  _statusbool();
                                  Get.to(() => UpdateCustomer(
                                        click: true,
                                        customerId:
                                            c.customer[index].id.toString(),
                                        name: c.customer[index].name.toString(),
                                        address: c.customer[index].address
                                            .toString(),
                                        phone:
                                            c.customer[index].phone.toString(),
                                      ));
                                }
                              : widget.orderType == "Delivery"
                                  ? () {
                                      Get.to(OrderBookingScreen(
                                        ordertype: "Delivery",
                                        customerName:
                                            c.customer[index].name.toString(),
                                        customerId: c.customer[index].id,
                                      ));
                                    }
                                  : widget.orderType == "Advance"
                                      ? () {
                                          Get.to(AdvanceCustomerDetails(
                                            id: c.customer[index].id,
                                            name: c.customer[index].name
                                                .toString(),
                                            phone: c.customer[index].phone
                                                .toString(),
                                            address: c.customer[index].address
                                                .toString(),
                                          ));
                                        }
                                      : widget.orderType == "Take Away"
                                          ? () {
                                              cartController.phone.value =
                                                  customerlist[index]
                                                      .phone
                                                      .toString();
                                              print(
                                                  "CartController PHONEddd : ======================== ${cartController.phone.value} ${customerlist[index].name
                                                      .toString()}");


                                            print("customer id take away : ${customerlist[index].id}");

                                            orderbookingController.customerId.value = customerlist[index].id!;                                         
                                            orderbookingController.update();


                                            print("after set:${orderbookingController.customerId.value}");
                                              Get.to(OrderBookingScreen(
                                                  ordertype: "Take Away",
                                                  customerName: customerlist[index].name
                                                      .toString(),
                                                  customerId:customerlist[index].id));
                                            }
                                          : () {
                                              _statusbool().whenComplete(() =>
                                                  Get.to(OrderBookingScreen(
                                                      floor: floorId,
                                                      table: tablenumber,
                                                      ordertype: "Dine",
                                                      sectionId:
                                                          sectionId.toString(),
                                                      customerName: c
                                                          .customer[index].name
                                                          .toString(),
                                                      customerId: c
                                                          .customer[index]
                                                          .id)));
                                            },
                          title: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Customer',
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(children: [
                                Text('Name:',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).highlightColor)),
                                const SizedBox(width: 8),
                                Text(customerlist[index].name.toString(),
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).highlightColor)),
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
                                          color:
                                              Theme.of(context).highlightColor))
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
                                          color:
                                              Theme.of(context).highlightColor))
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
    ]);
  }

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
}
