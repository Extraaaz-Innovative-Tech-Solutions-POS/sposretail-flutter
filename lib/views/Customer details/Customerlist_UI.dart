import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spos_retail/controllers/customer_details_controller/deleteCustomer_controller.dart';
import 'package:spos_retail/views/Customer%20details/customer_list.dart';
import 'package:spos_retail/views/widgets/app_bar.dart';

class Customerdetails extends StatefulWidget {
  const Customerdetails({Key? key}) : super(key: key);

  @override
  State<Customerdetails> createState() => _CustomerdetailsState();
}

class _CustomerdetailsState extends State<Customerdetails> {
  String searchQuery = '';
  final DeleteCustomerController deleteCustomercontroller= DeleteCustomerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBar(context, "Customer Details", ""),
      body: CustomerList(update: true, orderType: ""),
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
              "Are You Sure You Want To Delete  Customer ${name}",
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
