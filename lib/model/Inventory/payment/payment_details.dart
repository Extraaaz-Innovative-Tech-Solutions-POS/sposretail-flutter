import '../../../views/widgets/export.dart';

enum PaymentDetailsOptions { full, partial }

enum PaymentDetailsMode { full, partial }

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  PaymentDetailsOptions? paymentOptions;
  PaymentDetailsMode? paymentMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Payments & Invoice", ""),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            richText(
                "Net Payable : ", "₹ 150", Theme.of(context).indicatorColor),
            richText("Remaining Money : ", "₹ 0", Theme.of(context).hoverColor),
            const SizedBox(height: 10),
            Container(
              decoration: customCardDecor(context),
              child: ListTile(
                title: customText("Enter Amount : ",
                    color: Theme.of(context).highlightColor.withOpacity(0.6)),
                subtitle: customText("${AppConstant.currency} 140",
                    color: Theme.of(context).highlightColor),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RadioListTile<PaymentDetailsOptions>(
                    value: PaymentDetailsOptions.partial,
                    groupValue: paymentOptions,
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      "Net Payable",
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                    onChanged: (v) {
                      setState(() {
                        paymentOptions = v;
                        print(
                            "Options------------>" + paymentOptions.toString());
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<PaymentDetailsOptions>(
                    value: PaymentDetailsOptions.full,
                    groupValue: paymentOptions,
                    activeColor: Theme.of(context).primaryColor,
                    title: Text("Pay Partial",
                        style:
                            TextStyle(color: Theme.of(context).highlightColor)),
                    onChanged: (v) {
                      setState(() {
                        paymentOptions = v;
                      });
                    },
                  ),
                ),
              ],
            ),
            Divider(color: Theme.of(context).highlightColor),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RadioListTile<PaymentDetailsMode>(
                    value: PaymentDetailsMode.partial,
                    groupValue: paymentMode,
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      "Pay Cash",
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                    onChanged: (v) {
                      setState(() {
                        paymentMode = v;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<PaymentDetailsMode>(
                    value: PaymentDetailsMode.full,
                    groupValue: paymentMode,
                    activeColor: Theme.of(context).primaryColor,
                    title: Text("Pay Online",
                        style:
                            TextStyle(color: Theme.of(context).highlightColor)),
                    onChanged: (v) {
                      setState(() {
                        paymentMode = v;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget richText(text1, text2, color) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: text1.padRight(5), style: const TextStyle(fontSize: 15)),
            TextSpan(
                text: text2,
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
