import 'package:spos_retail/views/widgets/export.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  String dropdownvalue = 'Select';

  // DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  // DateTime endDate = DateTime.now();
  // String formattedStartDate = "";
  // String formattedEndDate = "";
  final reportsController = Get.put(ReportsController());

  var items = [
    'Select',
    'Cashierwise',
    'Billwise',
    'Item Sales',
    'Sold Items',
    'Cancelled Item',
    'Sale Reports',
    'Best Selling Items',
    'Worst Selling Items',
    'stock report',
    'cut Offday',
    'day Block',
    'sales Profit Loss',
      'Item Quantitywise',
    'Purchase',
    'Credit Payment'
  ];

  // startDatePicker() async {
  //   DateTime? selectedDate = await showDatePicker(
  //     // barrierColor: Theme.of(context).highlightColor,
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
  //     lastDate: DateTime.now(),
  //   );

  //   setState(() {
  //     startDate = selectedDate as DateTime;
  //     formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);

  //   });

  //   return formattedStartDate;
  // }

  // endDatePicker() async {
  //   DateTime? selectedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
  //     lastDate: DateTime.now(),
  //   );

  //   setState(() {
  //     endDate = selectedDate!;
  //     formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);
  //   });

  //   return endDate;
  // }

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
                      GetBuilder<ReportsController>(
                        builder: (rc) {
                          return datePick(context, false,
                              title: rc.formattedStartDate.isNotEmpty
                                  ? rc.formattedStartDate
                                  : null,
                              color: Theme.of(context).highlightColor, onpress: () {
                            rc.startDatePicker(context);
                          });
                        }
                      ),


                      const SizedBox(width: 5),
                      customText("To".padRight(4),
                          color: Theme.of(context).highlightColor),

                      GetBuilder<ReportsController>(
                        builder: (rc) {
                          return datePick(context, false,
                              title: rc.formattedEndDate.isNotEmpty
                                  ? rc.formattedEndDate
                                  : null,
                              color: Theme.of(context).highlightColor, onpress: () {
                            rc.endDatePicker(context);
                          });
                        }
                      ),
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
                              reportsController.formattedStartDate,
                             reportsController.formattedEndDate,
                            );

                            // Optionally, you can display a message to the user or perform additional actions after the PDF has been generated
                            debugPrint("PDF report has been generated.");
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
        return reportsController.cashierReport( false);
      case 'Cashierwise':
        return reportsController.fetchCashierWiseReport( false);
      case 'Billwise':
        return reportsController.dayReport(false);
      case 'Item Sales':
        return reportsController.fetchItemsSalesReport(false);
      case 'Sold Items':
        return reportsController.fetchSoldItemsReport( false);
      case 'Cancelled Item':
        return reportsController.cancelledReport(false);

     case 'Sale Reports':
        return reportsController.saleReport( false);

    case 'Best Selling Items':
        return reportsController.saleReport( false);

    case 'Worst Selling Items':
        return reportsController.saleReport( false);

    case 'stock report':
        return reportsController.StockReport( false);


    case 'cut Offday':
        return reportsController.CutOffdayReport( false);


    case 'day Block':
        return reportsController.DayBlockReport( false);

    case 'sales Profit Loss':
        return reportsController.salesProfitLossReport( false);


      case 'Item Quantitywise':
        return reportsController.fetchItemsQualityWise();
      case 'Purchase':
        return reportsController.fetchPurchaseReport(); 
      case 'Credit Payment':
        return reportsController.fetchCreditPaymentReport();
        

      default:
        return () {};
    }
  }

//* Download button Function----------------->
  getDownloadSubmit() {
    switch (dropdownvalue) {
      case 'Select':
        return reportsController.cashierReport( true);
      case 'Cashierwise':
        return reportsController.fetchCashierWiseReport( true);
      case 'Billwise':
        return reportsController.dayReport( true);
      case 'Item Sales':
        return reportsController.fetchItemsSalesReport(true);
      case 'Sold Items':
        return reportsController.fetchSoldItemsReport( true);
      case 'Cancelled Item':
        return reportsController.cancelledReport(true);

      case 'Sale Reports':
        return reportsController.saleReport( true);

      case 'Best Selling Items':
        return reportsController.saleReport( true);

      case 'Worst Selling Items':
        return reportsController.saleReport( true);

      case 'stock report':
        return reportsController.StockReport( true);

      case 'cut Offday':
        return reportsController.CutOffdayReport( true);


      case 'day Block':
        return reportsController.DayBlockReport( true);

      case 'sales Profit Loss':
        return reportsController.salesProfitLossReport( false);



      case 'Item Quantitywise':
        return reportsController.fetchItemsQualityWise();
      case 'Purchase':
        return reportsController.fetchPurchaseReport(); 
      case 'Credit Payment':
        return reportsController.fetchCreditPaymentReport();
        
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





//////// sale Report

          case 'Sale Reports':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.salesDataList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Items Name"),
                      dataColumn("Qty Sold"),
                      dataColumn("Total Revenue"),
                    ],
                  rows: List<DataRow>.generate(
                    c.salesDataList.length,
                    (index) => DataRow(
                      cells: [
                        dataCell(c.salesDataList[index].itemName),
                        dataCell(c.salesDataList[index].quantitySold),
                        dataCell(c.salesDataList[index].totalRevenue),
                      ],
                    ),
                  ));
        });





           case 'Best Selling Items':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.bestSellingItemList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Items Name"),
                      dataColumn("Qty Sold"),
                      dataColumn("Total Revenue"),
                    ],
                  rows: List<DataRow>.generate(
                    c.bestSellingItemList.length,
                    (index) => DataRow(
                      cells: [
                        dataCell(c.bestSellingItemList[index].itemName),
                        dataCell(c.bestSellingItemList[index].quantitySold),
                        dataCell(c.bestSellingItemList[index].totalRevenue),
                      ],
                    ),
                  ));
        });



                   case 'Worst Selling Items':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.worstSellingItemList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Items Name"),
                      dataColumn("Qty Sold"),
                      dataColumn("Total Revenue"),
                    ],
                  rows: List<DataRow>.generate(
                    c.worstSellingItemList.length,
                    (index) => DataRow(
                      cells: [
                        dataCell(c.worstSellingItemList[index].itemName),
                        dataCell(c.worstSellingItemList[index].quantitySold),
                        dataCell(c.worstSellingItemList[index].totalRevenue ),
                      ],
                    ),
                  ));
        });


                           case 'stock report':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.stockReportModelList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Product Name"),
                      dataColumn("Qty"),
                      dataColumn("Threshold Value"),
                    ],
                  rows: List<DataRow>.generate(
                    c.stockReportModelList.length,
                   
                    (index) => DataRow(
                      cells: [
                        dataCell(c.stockReportModelList[index].productName),
                        dataCell(c.stockReportModelList[index].quantity),
                        dataCell(c.stockReportModelList[index].thresholdValue ),
                      ],
                    ),
                  ));
        });



                              case 'cut Offday':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.cuttOffDayModelList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Total Sales"),
                      dataColumn("Total discounts"),
                      dataColumn("Total Orders"),
                      dataColumn("Total Items Sold"),
                    ],
                  rows: List<DataRow>.generate(
                    c.cuttOffDayModelList.length,
                   
                    (index) => DataRow(
                      cells: [
                        dataCell(c.cuttOffDayModelList[index].totalSales),
                        dataCell(c.cuttOffDayModelList[index].totalDiscounts),
                        dataCell(c.cuttOffDayModelList[index].totalOrders ),
                        dataCell(c.cuttOffDayModelList[index].totalItemsSold ),
                      ],
                    ),
                  ));
        });




                                      case 'day Block':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.dayblockModelList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Total Sales"),
                      dataColumn("Total discounts"),
                      dataColumn("Total Orders"),
                      dataColumn("Total Items Sold"),
                    ],
                  rows: List<DataRow>.generate(
                    c.dayblockModelList.length,
                   
                    (index) => DataRow(
                      cells: [
                        dataCell(c.dayblockModelList[index].totalSales),
                        dataCell(c.dayblockModelList[index].totalDiscounts),
                        dataCell(c.dayblockModelList[index].totalOrders ),
                        dataCell(c.dayblockModelList[index].totalItemsSold ),
                      ],
                    ),
                  ));
        });




                                              case 'sales Profit Loss':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.salesProfitLossModelList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Revenue"),
                      dataColumn("Discounts"),
                      dataColumn("Cogs"),
                      dataColumn("Net Profit"),
                    ],
                  rows: List<DataRow>.generate(
                    c.salesProfitLossModelList.length,
                   
                    (index) => DataRow(
                      cells: [
                        dataCell(c.salesProfitLossModelList[index].revenue),
                        dataCell(c.salesProfitLossModelList[index].discounts),
                        dataCell(c.salesProfitLossModelList[index].cogs ),
                        dataCell(c.salesProfitLossModelList[index].netProfit ),
                      ],
                    ),
                  ));
        });



                //more reports to add rrrrrrrrrrrrrrrrrrrr
      case 'Item Quantitywise':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.quantityWiseItemList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Item Name"),
                      dataColumn("Qty."),
                      dataColumn("Subtotal")
                    ],
                  rows: List<DataRow>.generate(
                    c.quantityWiseItemList.length,
                    (index) => DataRow(
                      cells: [
                        dataCell(c.quantityWiseItemList[index].itemName),
                        dataCell(c.quantityWiseItemList[index].quantity),
                        dataCell(c.quantityWiseItemList[index].subtotal)
                      ],
                    ),
                  ));
        });
        
      case 'Purchase':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.purchaseList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                    dataColumn("Supplier"),
                      dataColumn("Product"),
                      dataColumn("Qty."),
                      dataColumn("Amount")
                    ],
                  rows: List<DataRow>.generate(
                    c.purchaseList.length,
                    (index) => DataRow(
                      cells: [
                        dataCell(c.purchaseList[index].supplierName),
                        dataCell(c.purchaseList[index].supplierName),
                        dataCell(c.purchaseList[index].quantity),
                        dataCell(c.purchaseList[index].amount)
                      ],
                    ),
                  ));
        });
      case 'Credit Payment':
        return GetBuilder<ReportsController>(builder: (c) {
          return c.creditReportList.isEmpty
              ? Center(
                  child: customText("No Reports Found",
                      color: Theme.of(context).highlightColor),
                )
              : DataTable(
                  // columnSpacing: 16,
                  columns: [
                      dataColumn("Cust Name"),
                      dataColumn("Credit"),
                      dataColumn("Outstanding")
                    ],
                  rows: List<DataRow>.generate(
                    c.creditReportList.length,
                    (index) => DataRow(
                      cells: [
                        dataCell(c.creditReportList[index].customerName),
                        dataCell(c.creditReportList[index].amount),
                        dataCell(c.creditReportList[index].outstandingBalance)
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
