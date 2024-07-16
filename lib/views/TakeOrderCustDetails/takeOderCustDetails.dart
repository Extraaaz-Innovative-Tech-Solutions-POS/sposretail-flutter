import 'package:spos_retail/views/widgets/export.dart';

class TakeAwayCustomerDetails extends StatefulWidget {
  const TakeAwayCustomerDetails({super.key});

  @override
  State<TakeAwayCustomerDetails> createState() =>
      _TakeAwayCustomerDetailsState();
}

class _TakeAwayCustomerDetailsState extends State<TakeAwayCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Customer Details", ""),
      body: CustomerList(
        update: false,
        orderType: "Take Away",
      ),
    );
  }
}
