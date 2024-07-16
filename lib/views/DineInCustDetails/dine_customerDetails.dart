import 'package:flutter/material.dart';
import 'package:spos_retail/views/Customer%20details/customer_list.dart';
import 'package:spos_retail/views/widgets/app_bar.dart';

class DineInCustomerDetails extends StatefulWidget {
  const DineInCustomerDetails({super.key});

  @override
  State<DineInCustomerDetails> createState() => _DineInCustomerDetailsState();
}

class _DineInCustomerDetailsState extends State<DineInCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Customer Details", ""),
      body: CustomerList(
        update: false,
        orderType: "Dine",
      ),
    );
  }
}
