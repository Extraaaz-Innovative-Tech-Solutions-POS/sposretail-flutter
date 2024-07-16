import 'package:spos_retail/model/Inventory/payment/payment_details.dart';
import 'package:spos_retail/views/widgets/export.dart';

class PaymentInvoice extends StatelessWidget {
  const PaymentInvoice({super.key});

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
      body: Padding(
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
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                customText("25 Jun 2024",
                                    color: Theme.of(context).highlightColor),
                                customText("10:29:07 AM",
                                    color: Theme.of(context).highlightColor),
                              ],
                            ),
                          ),
                          dataCell("120.00"),
                          dataCell("Cash"),
                          DataCell(Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.cloud_download_sharp,
                                      color: Theme.of(context).highlightColor))
                              // customText("text", color: Theme.of(context).highlightColor, font: 16.0),
                              )),
                        ],
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
