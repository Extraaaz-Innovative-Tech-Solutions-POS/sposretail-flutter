import 'package:intl/intl.dart';
import 'package:spos_retail/views/widgets/export.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  String dropdownvalue = 'Select';

  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String formattedStartDate = "";
  String formattedEndDate = "";
  final reportsController = Get.put(ReportsController());

  var items = [
    'Select',
    'Cashierwise',
    'Billwise',
    'Item Sales',
    'Sold Items',
    'Cancelled Item',
  ];

  startDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      // barrierColor: Theme.of(context).highlightColor,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
      lastDate: DateTime.now(),
    );

    setState(() {
      startDate = selectedDate as DateTime;
      formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    });

    return formattedStartDate;
  }

  endDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
      lastDate: DateTime.now(),
    );

    setState(() {
      endDate = selectedDate!;
      formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);
    });

    return endDate;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText("reports".tr,
                    color: Theme.of(context).highlightColor, font: 20.0),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: screenWidth(context),
                  decoration: highlightBorderDecor(context),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: customText("$items Report",
                              color: Theme.of(context).highlightColor),
                        );
                      }).toList(),
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      customText("From".padRight(6),
                          color: Theme.of(context).highlightColor),
                      datePick(context, false,
                          title: formattedStartDate.isNotEmpty
                              ? formattedStartDate
                              : null,
                          color: Theme.of(context).highlightColor, onpress: () {
                        startDatePicker();
                      }),
                      const SizedBox(width: 5),
                      customText("To".padRight(4),
                          color: Theme.of(context).highlightColor),
                      datePick(context, false,
                          title: formattedEndDate.isNotEmpty
                              ? formattedEndDate
                              : null,
                          color: Theme.of(context).highlightColor, onpress: () {
                        endDatePicker();
                      }),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).focusColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  06), // Set border radius here
                            ),
                          ),
                          onPressed: () {
                            getDropDownSubmit();
                            //reportsController.dayReport(formattedStartDate, formattedEndDate);
                          },
                          child: customText("Submit",
                              color: Theme.of(context).highlightColor)),
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).focusColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  06), // Set border radius here
                            ),
                          ),
                          onPressed: () {
                            getDownloadSubmit();
                            //reportsController.dayReport(formattedStartDate, formattedEndDate);
                          },
                          child: customText("Download",
                              color: Theme.of(context).highlightColor)),
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).focusColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  06), // Set border radius here
                            ),
                          ),
                          onPressed: () async {
                            final pdfGenerator =
                                PdfGenerator(reportsController);
                            // Call the generatePdf method with the selected dropdown value, start date, and end date
                            await pdfGenerator.generateReportPdf(
                              dropdownvalue,
                              formattedStartDate,
                              formattedEndDate,
                            );

                            // Optionally, you can display a message to the user or perform additional actions after the PDF has been generated
                            print("PDF report has been generated.");
                          },
                          child: customText("Print",
                              color: Theme.of(context).highlightColor)),
                    ),
                  ],
                ),
                spacer(10),
                getDropDownContent(),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        // Navigator.of(context).pop();
        Get.to(BottomNav());
        return false;
      },
    );
  }

  Widget paymentOptions(context, title, amount) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
          border: Border.all(
            color: Theme.of(context)
                .highlightColor, // Set your desired border color here.
            width: 1.0, // Set the width of the border.
          ),
        ),
        child: ListTile(
            title: Text(
              title,
              style: TextStyle(color: Theme.of(context).highlightColor),
            ),
            subtitle: Text(
              "₹ $amount",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
            )),
      ),
    );
  }

  Widget reportData(context, title, data, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      height: 100,
      width: screenWidth(context, dividedBy: 3.5),
      decoration:
          highlightBorderDecor(context, color: Theme.of(context).focusColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, color: Theme.of(context).highlightColor.withOpacity(0.7)),
          customText("Total $title",
              font: 14.0, color: Theme.of(context).highlightColor),
          customText(data,
              font: 18.0,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              weight: FontWeight.bold)
        ],
      ),
    );
  }
//* Submit button function-------------------->

  getDropDownSubmit() {
    switch (dropdownvalue) {
      case 'Select':
        return reportsController.cashierReport(
            formattedStartDate, formattedEndDate, false);
      case 'Cashierwise':
        return reportsController.fetchCashierWiseReport(
            formattedStartDate, formattedEndDate, false);
      case 'Billwise':
        return reportsController.dayReport(
            formattedStartDate, formattedEndDate, false);
      case 'Item Sales':
        return reportsController.fetchItemsSalesReport(
            formattedStartDate, formattedEndDate, false);
      case 'Sold Items':
        return reportsController.fetchSoldItemsReport(
            formattedStartDate, formattedEndDate, false);
      case 'Cancelled Item':
        return reportsController.cancelledReport(
            formattedStartDate, formattedEndDate, false);

      default:
        return () {};
    }
  }

//* Download button Function----------------->
  getDownloadSubmit() {
    switch (dropdownvalue) {
      case 'Select':
        return reportsController.cashierReport(
            formattedStartDate, formattedEndDate, true);
      case 'Cashierwise':
        return reportsController.fetchCashierWiseReport(
            formattedStartDate, formattedEndDate, true);
      case 'Billwise':
        return reportsController.dayReport(
            formattedStartDate, formattedEndDate, true);
      case 'Item Sales':
        return reportsController.fetchItemsSalesReport(
            formattedStartDate, formattedEndDate, true);
      case 'Sold Items':
        return reportsController.fetchSoldItemsReport(
            formattedStartDate, formattedEndDate, true);
      case 'Cancelled Item':
        return reportsController.cancelledReport(
            formattedStartDate, formattedEndDate, true);

      default:
        return () {};
    }
  }

  Widget getDropDownContent() {
    switch (dropdownvalue) {
      case 'Select':
        return Row(
          children: [
            GetBuilder<ReportsController>(builder: (c) {
              return reportData(context, "Invoices", c.totalInvoice.value,
                  Icons.inventory_outlined);
            }),
            GetBuilder<ReportsController>(builder: (c) {
              return reportData(context, "Sales", c.totalSales.value,
                  Icons.inventory_outlined);
            }),
            GetBuilder<ReportsController>(builder: (c) {
              return reportData(context, "Sold", c.totalproductsSold.value,
                  Icons.inventory_outlined);
            }),
          ],
        );
      case 'Cashier':
        return const Text('');
      case 'Cashierwise':
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<ReportsController>(builder: (c) {
              return customText("Name:- ${c.cashierWiseName}",
                  color: Theme.of(context).highlightColor);
            }),
            GetBuilder<ReportsController>(builder: (c) {
              return customText("Role:- ${c.cashierWiseRole}",
                  color: Theme.of(context).highlightColor);
            }),
            const SizedBox(height: 10),
            Row(
              children: [
                GetBuilder<ReportsController>(builder: (c) {
                  return reportData(
                      context,
                      "Invoices",
                      c.totalCashierWiseInvoice.value,
                      Icons.inventory_outlined);
                }),
                GetBuilder<ReportsController>(builder: (c) {
                  return reportData(context, "Sales",
                      c.totalCashierWiseSales.value, Icons.inventory_outlined);
                }),
                GetBuilder<ReportsController>(builder: (c) {
                  return reportData(
                      context,
                      "Sold",
                      c.totalCashierWiseproductsSold.value,
                      Icons.inventory_outlined);
                }),
              ],
            ),
          ],
        );
      case 'Billwise':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.billing.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  columnSpacing: 16,
                  columns: [
                    //dataColumn("Bill"),
                    dataColumn("InvoiceNo."),
                    dataColumn("Amt."),
                    dataColumn("Payment"),
                    // dataColumn("Paid"),
                    dataColumn("Type"),
                  ],
                  rows: List<DataRow>.generate(
                    c.billing.length,
                    (index) => DataRow(
                      cells: [
                        // dataCell(
                        //   c.billing[index].tableId,
                        // ),
                        dataCell(c.billing[index].billnumber.toString()),
                        dataCell(c.billing[index].total),
                        dataCell(c.billing[index].paymentType),
                        //dataCell(c.billing[index].total),
                        dataCell(c.billing[index].orderType.toString()),
                      ],
                    ),
                  ));
        });

      case 'Item Sales':
        return Container(
          height: screenHeight(context, dividedBy: 2),
          child: GetBuilder<ReportsController>(builder: (c) {
            return c.itemSalesReportList.isEmpty
                ? Center(
                    child: customText("No Reports Found",
                        color: Theme.of(context).highlightColor),
                  )
                : SingleChildScrollView(
                    child: DataTable(
                        columnSpacing: 25,
                        columns: [
                          dataColumn("name".tr),
                          dataColumn("Qty."),
                          dataColumn("Price"),
                          dataColumn("Total"),
                        ],
                        rows: List<DataRow>.generate(
                          c.itemSalesReportList.length,
                          (index) => DataRow(
                            cells: [
                              dataCell(c.itemSalesReportList[index].name),
                              dataCell(c.itemSalesReportList[index].quantity),
                              dataCell(c.itemSalesReportList[index].price),
                              dataCell(
                                  c.itemSalesReportList[index].productTotal),
                            ],
                          ),
                        )),
                  );
          }),
        );

      // Padding(
      //   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      //   child: Row(
      //     children: [
      //       GetBuilder<PaymentController>(builder: (c) {
      //         return paymentOptions(context, "Online",
      //             paymentController.onlinePaymentAmount.value.toString());
      //       }),
      //       const SizedBox(width: 12),
      //       GetBuilder<PaymentController>(builder: (c) {
      //         return paymentOptions(context, "Cash",
      //             paymentController.cashPaymentAmount.value.toString());
      //       }),
      //     ],
      //   ),
      // );
      case 'Sold Items':
        return Container(
          height: screenHeight(context, dividedBy: 2),
          child: GetBuilder<ReportsController>(builder: (c) {
            return c.soldItemTotalList.isEmpty
                ? Center(
                    child: customText("No Reports Found",
                        color: Theme.of(context).highlightColor),
                  )
                : SingleChildScrollView(
                    child: DataTable(
                        columnSpacing: 25,
                        columns: [
                          dataColumn("name".tr),
                          dataColumn("Qty."),
                          dataColumn("Price"),
                          dataColumn("Total"),
                        ],
                        rows: List<DataRow>.generate(
                          c.soldItemTotalList.length,
                          (index) => DataRow(
                            cells: [
                              dataCell(c.soldItemTotalList[index].name),
                              dataCell(c.soldItemTotalList[index].quantity),
                              dataCell(c.soldItemTotalList[index].price),
                              dataCell(c.soldItemTotalList[index].productTotal),
                            ],
                          ),
                        )),
                  );
          }),
        );

      case 'Cancelled Item':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.cancelledReportList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Items Name"),
                      dataColumn("Status"),
                    ],
                  rows: List<DataRow>.generate(
                    c.cancelledReportList.length,
                    (index) => DataRow(
                      cells: [
                        dataCell(c.cancelledReportList[index].name),
                        dataCell(c.cancelledReportList[index].status),
                      ],
                    ),
                  ));
        });

      default:
        return Container(); // Return an empty container if no match found
    }
  }

  DataColumn dataColumn(title) {
    return DataColumn(
      label: customText(title, color: Theme.of(context).highlightColor),
    );
  }

  DataCell dataCell(title) {
    return DataCell(customText(title, color: Theme.of(context).highlightColor));
  }
}
