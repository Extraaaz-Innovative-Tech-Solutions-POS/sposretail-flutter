import 'package:spos_retail/controllers/Inventory_Controller/purchase.dart';
import 'package:spos_retail/model/Inventory/payment/payment_details.dart';
import 'package:spos_retail/views/widgets/export.dart';

class PaymentInvoice extends StatefulWidget {
  const PaymentInvoice({super.key});

  @override
  State<PaymentInvoice> createState() => _PaymentInvoiceState();
}

class _PaymentInvoiceState extends State<PaymentInvoice> {
  final PurchaseController purchaseController = Get.put(PurchaseController());
  @override
  void initState() {
    super.initState();
    purchaseController.viewPaymentList();
  }

  @override
  Widget build(BuildContext context) {
    DataCell dataCell(text) {
      return DataCell(Center(
        child: customText(text,
            color: Theme.of(context).highlightColor, font: 16.0),
      ));
    }

    DataColumn dataColumn(title) {
      return DataColumn(
        label: Center(
          child: customText(title,
              color: Theme.of(context).highlightColor.withOpacity(0.6),
              font: 16.0),
        ),
      );
    }

    return Scaffold(
      appBar: commonAppBar(context, "Payments & Invoice", ""),
      body: GetBuilder<PurchaseController>(
          builder: (PurchaseController controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: customCardDecor(context),
                child: ListTile(
                    title: Text(
                      "Payment Status",
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                    subtitle: customText(
                        "All payments have been completed for this order.",
                        color: Theme.of(context).indicatorColor)),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: customCardDecor(context),
                child: ListTile(
                  onTap: () {
                    Get.to(const PaymentDetails());
                  },
                  title: customText("Purchase Order Invoices",
                      color: Theme.of(context).highlightColor),
                  subtitle: DataTable(
                    showCheckboxColumn: true,
                    columnSpacing: 14.0,
                    border: TableBorder(
                        horizontalInside: BorderSide(
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.7))),
                    columns: [
                      dataColumn("Date & Time"),
                      dataColumn("Amount"),
                      dataColumn("Method"),
                      dataColumn("Download"),
                    ],
                    rows: purchaseController.paymentDetails
                        .asMap()
                        .entries
                        .map<DataRow>((entry) {
                      final item = entry.value;

                      return DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    entry.value.createdAt.toString(),
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          dataCell("${entry.value.amount}"),
                          dataCell("${entry.value.paymentMethod}"),
                          dataCell(""),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
