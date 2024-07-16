import 'package:spos_retail/views/widgets/export.dart';

class Customerdetails extends StatefulWidget {
  const Customerdetails({Key? key}) : super(key: key);

  @override
  State<Customerdetails> createState() => _CustomerdetailsState();
}

class _CustomerdetailsState extends State<Customerdetails> {
  String searchQuery = '';
  final DeleteCustomerController deleteCustomercontroller =
      DeleteCustomerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBar(context, "Customer Details", ""),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: search(
              context,
              onchange: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: GetBuilder<CustomerlistController>(
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
                              .startsWith(searchQuery.toLowerCase()))
                          .toList();
                  if (customerlist.isEmpty) {
                    return const Center(
                      child: Text('Customer details not found'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: customerlist.length,
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
                                Get.to(() => UpdateCustomer(
                                      click: true,
                                      customerId:
                                          customerlist[index].id.toString(),
                                      name: customerlist[index].name.toString(),
                                      address: customerlist[index]
                                          .address
                                          .toString(),
                                      phone:
                                          customerlist[index].phone.toString(),
                                    ));
                              },
                              title: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: customText('Customer',
                                        color:
                                            Theme.of(context).highlightColor),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  detailField('Name:',
                                      customerlist[index].name.toString()),
                                  detailField('Phone:',
                                      customerlist[index].phone.toString()),
                                  detailField('Address:',
                                      customerlist[index].address.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              side: BorderSide(color: Theme.of(context).primaryColor),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Text(
              'Add Customer',
              style: TextStyle(color: Theme.of(context).highlightColor),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateCustomer(
                    customerId: '',
                    click: false,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget detailField(title, value) {
    return Row(
      children: [
        customText(title, color: Theme.of(context).highlightColor),
        const SizedBox(width: 8),
        customText(value, color: Theme.of(context).highlightColor)
      ],
    );
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
              textButton("Yes", Theme.of(context).primaryColor, onpress: () {
                controller.deleteCustomer(id);
                Get.back();
                setState(() {});
              }),
              textButton("No", Theme.of(context).hoverColor),
            ],
          );
        });
  }
}
