import 'package:pdf/widgets.dart' as pw;
import 'package:spos_retail/model/cart_respose_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

class InvoicePdf {
  static Future<Uint8List> generateBillingPdf(
      {required List<Items> orders,
      required String invoiceId,
      //required UserController userController,
      // required dynamic orderdata,
      required String invoiceID,
      required var totalAmount,
      required dynamic ordertype,
      var customerName,
      var customerAddress,
      var customerPhone,
      var discount,
      var remainingAmount,
      var moneytoPay,
      bool? fullpayment}) async {
    // final CartController cartController = Get.put(CartController());
    final pdf = pw.Document();
    var restaurantName, address, phone;

    DateTime invoiceDate = DateTime.now();

    SharedPreferences pref = await SharedPreferences.getInstance();

    restaurantName = pref.getString("RestaurantName");
    address = pref.getString("Address");
    phone = pref.getString("Phone");

    pdf.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(300, double.infinity, marginAll: 6),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                //        Hotel Shubharam/Ashwin Nagar,CIDCO Nashik/+919119560608/+919657387404/****"
                pw.Text("${restaurantName ?? "---"}",
                    style: pw.TextStyle(
                        fontSize: 15.0, fontWeight: pw.FontWeight.bold)),

                //Suvadha Pure Veg/TV Centre Chh.Sambhajinagar/+918668961094/+918080492165/****
                pw.Text("${address ?? "--"}",
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 13.5,
                    )),

                pw.Text("Invoice Id: $invoiceId",
                    style: pw.TextStyle(
                        fontSize: 15, fontWeight: pw.FontWeight.bold)),

                pw.Text(ordertype,
                    style: const pw.TextStyle(
                      fontSize: 15.0,
                    )),

                pw.Text("Phone: ${phone ?? "---"}",
                    style: const pw.TextStyle(
                      fontSize: 13.5,
                    )),
                pw.Text(
                    "Date:- ${invoiceDate.day}-${invoiceDate.month}-${invoiceDate.year} Time:-${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
                    style: const pw.TextStyle(
                      fontSize: 13.5,
                    )),
                pw.Divider(),
                ordertype == 'Dine'
                    ? dineorderedItemsListWidget(orders)
                    : orderedItemsListWidget(orders),
                orderSummaryWidget(
                    // cartController.cartOrder.value!.items!,
                    discount,
                    ordertype,
                    totalAmount ?? "0",
                    remainingAmount,
                    moneytoPay,
                    fullpayment),

                ordertype == "Dine"
                    ? pw.SizedBox.shrink()
                    : pw.Text("Customer Details",
                        style: pw.TextStyle(
                            fontSize: 15.0, fontWeight: pw.FontWeight.bold)),
                ordertype == "Dine"
                    ? pw.SizedBox.shrink()
                    : pw.Text("${customerName ?? "--"}",
                        style: pw.TextStyle(
                            fontSize: 15.0, fontWeight: pw.FontWeight.bold)),

                ordertype == "Dine"
                    ? pw.SizedBox.shrink()
                    : pw.Text("${customerAddress ?? "---"}",
                        style: pw.TextStyle(
                            fontSize: 15.0, fontWeight: pw.FontWeight.bold)),
                ordertype == "Dine"
                    ? pw.SizedBox.shrink()
                    : pw.Text("${customerPhone ?? "---"}",
                        style: pw.TextStyle(
                            fontSize: 15.0, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF as bytes
    final List<int> pdfBytes = await pdf.save();

    // Convert the List<int> to Uint8List

    final Uint8List uint8List = Uint8List.fromList(pdfBytes);
    orderjson.clear();
    // userController.getUser().role == "manager" ||
    //         userController.getUser().role == "waiter"
    //     ? Get.offAll(() => Dashboard())
    //     : Get.offAll(() => OrderBookingScreen(
    //           ordertype: "Take Away",
    //         ));

    // Return the Uint8List
    return uint8List;
  }

  static pw.Widget dineorderedItemsListWidget(List<Items> orders) {
    // Modify the orderdata parameter type
    return pw.Center(
      child: pw.Table(
        columnWidths: const {
          0: pw.FixedColumnWidth(100),
          1: pw.FixedColumnWidth(50),
          2: pw.FixedColumnWidth(100),
          3: pw.FixedColumnWidth(100),
        },
        children: [
          pw.TableRow(
            children: [
              pw.Text("Items",
                  style: const pw.TextStyle(
                    fontSize: 13.5,
                  )),
              pw.Text("Qty.",
                  style: const pw.TextStyle(
                    fontSize: 13.5,
                  )),
              pw.Text("Rate",
                  style: const pw.TextStyle(
                    fontSize: 13.5,
                  )),
              pw.Text("Amount",
                  style: const pw.TextStyle(
                    fontSize: 13.5,
                  )),
            ],
          ),
          // Iterate over each order in the orderdata list
          for (var itemData in orders) // Iterate over each item in the order
            pw.TableRow(
              children: [
                //padding: const pw.EdgeInsets.symmetric(vertical: 5),
                pw.Row(
                  children: [
                    pw.SizedBox(width: 3),
                    pw.Expanded(
                      child: pw.Text(itemData.name.toString(),
                          maxLines: 2,
                          softWrap: true,
                          style: const pw.TextStyle(
                            fontSize: 13.5,
                          )),
                    ),
                  ],
                ),

                pw.Text(itemData.quantity.toString(),
                    style: const pw.TextStyle(
                      fontSize: 13.5,
                    )),

                pw.Row(
                  children: [
                    pw.SizedBox(width: 3),
                    pw.Expanded(
                      child: pw.Text(itemData.price.toString(),
                          maxLines: 2,
                          softWrap: true,
                          style: const pw.TextStyle(
                            fontSize: 13.5,
                          )),
                    ),
                  ],
                ),

                pw.Container(
                  child: pw.Text(
                      (double.parse(itemData.price.toString()) *
                              double.parse(itemData.quantity.toString()))
                          .toStringAsFixed(
                              2), // Parse price to double and round to 2 decimal places
                      style: const pw.TextStyle(
                        fontSize: 13.5,
                      )),
                ),
              ],
            ),
        ],
      ),
    );
  }

  static pw.Widget orderedItemsListWidget(List<Items> orders) {
    return pw.Center(
      child: pw.Table(
        columnWidths: const {
          0: pw.FixedColumnWidth(100),
          1: pw.FixedColumnWidth(50),
          2: pw.FixedColumnWidth(100),
          3: pw.FixedColumnWidth(100),
        },
        children: [
          pw.TableRow(
            children: [
              pw.Text("Items",
                  style: const pw.TextStyle(
                    fontSize: 13.5,
                  )),
              pw.Text("Qty.",
                  style: const pw.TextStyle(
                    fontSize: 13.5,
                  )),
              pw.Text("Rate",
                  style: const pw.TextStyle(
                    fontSize: 13.5,
                  )),
              pw.Text("Amount",
                  style: const pw.TextStyle(
                    fontSize: 13.5,
                  )),
            ],
          ),
          for (var itemData in orders)
            pw.TableRow(
              children: [
                pw.Row(
                  children: [
                    pw.SizedBox(width: 3),
                    pw.Expanded(
                      child: pw.Text(itemData.name.toString(),
                          maxLines: 2,
                          softWrap: true,
                          style: const pw.TextStyle(
                            fontSize: 13.5,
                          )),
                    ),
                  ],
                ),
                pw.Text(itemData.quantity.toString()),
                pw.Row(
                  children: [
                    pw.SizedBox(width: 3),
                    pw.Expanded(
                      child: pw.Text(itemData.price.toString(),
                          maxLines: 2,
                          softWrap: true,
                          style: const pw.TextStyle(
                            fontSize: 13.5,
                          )),
                    ),
                  ],
                ),
                pw.Container(
                  child: pw.Text(
                      (double.parse(itemData.price.toString()) *
                              double.parse(itemData.quantity.toString()))
                          .toString(),
                      style: const pw.TextStyle(
                        fontSize: 13.5,
                      )),
                ),
              ],
            ),
        ],
      ),
    );
  }

  static pw.Widget orderSummaryWidget(var discount, String? orderType,
      totalAmount, remaningAmount, moneytoPay, fullpayment) {
    return pw.Column(
      children: [
        // pw.Row(
        //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //   children: [
        //     pw.Text("Items Total",
        //         style: pw.TextStyle(
        //           fontSize: 13.5,
        //         )),
        //     pw.Text("${total.toStringAsFixed(2)}",
        //         style: pw.TextStyle(
        //           fontSize: 13.5,
        //         )),
        //   ],
        // ),
        //pw.Divider(),
        // for (RestTaxItem itemTax in restrotax)
        //   pw.Row(
        //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //     children: [
        //       pw.Text(
        //         "${itemTax.tax} @ ${itemTax.percentage.toStringAsFixed(2)}%",
        //       ),
        //       pw.Text("${itemTax.total.toStringAsFixed(2)}"),
        //     ],
        //   ),
        //pw.Divider(),
        // for (TaxItem itemTax in taxlist)
        //   pw.Row(
        //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //     children: [
        //       pw.Text(
        //         "${itemTax.itemName} @ ${itemTax.taxPercentage.toStringAsFixed(2)}% * ${itemTax.quantity}",
        //       ),
        //       pw.Text("${itemTax.totalTax.toStringAsFixed(2)}"),
        //     ],
        //   ),
        pw.Divider(),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Item Discount",
                style: const pw.TextStyle(
                  fontSize: 13.5,
                )),
            pw.Text("$discount",
                style: const pw.TextStyle(
                  fontSize: 13.5,
                )),
          ],
        ),
        orderType == "Advance" ||
                orderType == "Catering" && fullpayment == false
            ? pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Remaining Amount",
                      style: const pw.TextStyle(
                        fontSize: 13.5,
                      )),
                  pw.Text("$remaningAmount",
                      style: const pw.TextStyle(
                        fontSize: 13.5,
                      )),
                ],
              )
            : pw.SizedBox(),

        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Item Subtotal",
                style: const pw.TextStyle(
                  fontSize: 13.5,
                )),
            pw.Text("$totalAmount",
                style: const pw.TextStyle(
                  fontSize: 13.5,
                )),
          ],
        ),

        pw.Divider(),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Payable Amount",
                style: const pw.TextStyle(
                  fontSize: 13.5,
                )),
            orderType == "Advance"
                ? pw.Text(
                    "$totalAmount",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  )
                : pw.Text(
                    "$totalAmount",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
          ],
        ),

        orderType == "Advance" ||
                orderType == "Catering" && fullpayment == false
            ? pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Partial Payment",
                      style: const pw.TextStyle(
                        fontSize: 11.5,
                      )),
                  pw.Text(
                    "$moneytoPay",
                    style: pw.TextStyle(
                      fontSize: 15.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  )
                ],
              )
            : pw.SizedBox()
      ],
    );
  }
}
