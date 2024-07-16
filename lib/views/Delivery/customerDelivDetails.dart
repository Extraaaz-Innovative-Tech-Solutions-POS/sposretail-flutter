import 'package:flutter/material.dart';
import 'package:spos_retail/views/Customer%20details/customer_list.dart';
import 'package:spos_retail/views/widgets/app_bar.dart';

class CustomerDeliveryDetails extends StatefulWidget {
  const CustomerDeliveryDetails({super.key});

  @override
  State<CustomerDeliveryDetails> createState() =>
      _CustomerDeliveryDetailsState();
}

class _CustomerDeliveryDetailsState extends State<CustomerDeliveryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Customer Details", ""),
      body: CustomerList(
        update: false,
        orderType: "Delivery",
      ),
    );
  }
}
