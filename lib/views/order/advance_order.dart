import 'package:spos_retail/views/widgets/export.dart';

class AdvanceOrder extends StatefulWidget {
  const AdvanceOrder({super.key});

  @override
  State<AdvanceOrder> createState() => _AdvanceOrderState();
}

class _AdvanceOrderState extends State<AdvanceOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Customer Details", ""),
        body: CustomerList(update: false, orderType: "Advance"));
  }
}
