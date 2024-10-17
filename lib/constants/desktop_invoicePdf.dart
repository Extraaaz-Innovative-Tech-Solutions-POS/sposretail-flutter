// ignore_for_file: prefer_const_constructors

import 'dart:ui' as ui;
import 'package:spos_retail/views/widgets/export.dart';
import 'package:pdf/widgets.dart' as pw;

class DesktopInvoicePdf {
  Future<Uint8List> generateBillingPdf(
      {required List<Items> orders,
      required String invoiceId,
      //required UserController userController,
      // required dynamic orderdata,
      required String invoiceID,
      required var totalAmount,
      required dynamic ordertype,
      var discount,
      var remainingAmount,
      var moneytoPay,
      var customerName,
      var customerAddress,
      var customerPhone,
      var thaliprice,
      var numberOfThali,
      var datetime,
      bool? fullpayment}) async {
    final pdf = pw.Document();
    var restaurantName, address, phone;
    DateTime invoiceDate = DateTime.now();
    SharedPreferences pref = await SharedPreferences.getInstance();

    restaurantName = pref.getString("RestaurantName");
    address = pref.getString("Address");
    phone = pref.getString("Phone");

    final imageBytesList = await Future.wait(
      orders.map((order) => _captureTextAsImage(order.name!)).toList(),
    );

    ordertype != "Catering"
        ? pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.roll80,
              // pageFormat: PdfPageFormat(
              //   80 * PdfPageFormat.mm,
              //   90*PdfPageFormat.mm,
              //   // A4 paper height in mm (you can adjust this)
              //   marginAll: 5 * PdfPageFormat.mm,
              // ),
              orientation: pw.PageOrientation.portrait,
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Column(
                    // crossAxisAlignment: pw.CrossAxisAlignment.center,
                    // mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      //        Hotel Shubharam/Ashwin Nagar,CIDCO Nashik/+919119560608/+919657387404/****"
                      pw.Text("${restaurantName ?? "---"}",
                          style: pw.TextStyle(
                              fontSize: 13.0, fontWeight: pw.FontWeight.bold)),

                      //Suvadha Pure Veg/TV Centre Chh.Sambhajinagar/+918668961094/+918080492165/****
                      pw.Text("${address ?? "--"}",
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 12.0,
                          )),

                      pw.Text("Invoice Id: $invoiceId",
                          style: pw.TextStyle(
                              fontSize: 13, fontWeight: pw.FontWeight.bold)),
                      // pw.Text("Email: priyasfoodcorner@gmail.com",
                      //     style: pw.TextStyle(
                      //       fontSize: 13.5,
                      //     )),
                      pw.Text("Phone: ${phone ?? "---"}",
                          style: const pw.TextStyle(
                            fontSize: 12.0,
                          )),
                      pw.Text(
                          "Date:- ${invoiceDate.day}-${invoiceDate.month}-${invoiceDate.year} Time:-${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
                          style: const pw.TextStyle(
                            fontSize: 12.0,
                          )),
                      pw.Divider(),
                      ordertype == 'Dine'
                          ? dineorderedItemsListWidget(orders, imageBytesList)
                          : orderedItemsListWidget(orders, imageBytesList),
                      orderSummaryWidget(
                          discount,
                          ordertype,
                          totalAmount ?? "0",
                          remainingAmount,
                          moneytoPay,
                          fullpayment,
                          thaliprice ?? "0",
                          numberOfThali ?? "0"),

                          // pw.Text("Credit Amount", style:  pw.TextStyle(color: PdfColors.black)  )

                      // pw.Text("Customer Details",
                      //     style: pw.TextStyle(
                      //         fontSize: 15.0, fontWeight: pw.FontWeight.bold)),
                      // pw.Text("${customerName ?? "---"}",
                      //     style: pw.TextStyle(
                      //         fontSize: 15.0, fontWeight: pw.FontWeight.bold)),

                      // pw.Text("${customerAddress ?? "---"}",
                      //     style: pw.TextStyle(
                      //         fontSize: 15.0, fontWeight: pw.FontWeight.bold)),
                      // pw.Text("${customerPhone ?? "---"}",
                      //     style: pw.TextStyle(
                      //         fontSize: 15.0, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                );
              },
            ),
          )
        : pdf.addPage(
            pw.Page(
              orientation: pw.PageOrientation.portrait,
              pageFormat: ordertype == "Catering"
                  ? PdfPageFormat.a4
                  : PdfPageFormat.roll57,
              build: (pw.Context context) {
                return pw.Container(
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColors.black, width: 1.0)),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Row(children: [
                          //        Hotel Shubharam/Ashwin Nagar,CIDCO Nashik/+919119560608/+919657387404/****"
                          pw.Column(children: [
                            pw.Container(
                                height: 60.0,
                                width: 350,
                                margin: const pw.EdgeInsets.only(
                                    left: 10.0, top: 12.0),
                                decoration: pw.BoxDecoration(
                                    border:
                                        pw.Border.all(color: PdfColors.black)),
                                child: pw.Column(children: [
                                  pw.SizedBox(height: 5.0),
                                  pw.Text("${restaurantName ?? "---"}",
                                      style: pw.TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: pw.FontWeight.bold)),
                                  //Suvadha Pure Veg/TV Centre Chh.Sambhajinagar/+918668961094/+918080492165/****
                                  pw.Text("${address ?? "--"}",
                                      textAlign: pw.TextAlign.center,
                                      style: const pw.TextStyle(
                                        fontSize: 13.0,
                                      )),
                                  pw.Text("Phone: ${phone ?? "---"}",
                                      style: const pw.TextStyle(
                                        fontSize: 13,
                                      )),
                                ])),
                            pw.Container(
                                height: 60.0,
                                width: 350,
                                margin: const pw.EdgeInsets.only(
                                    top: 10.0, left: 10.0),
                                decoration: pw.BoxDecoration(
                                    border:
                                        pw.Border.all(color: PdfColors.black)),
                                child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Padding(
                                        padding: const pw.EdgeInsets.only(
                                          top: 5.0,
                                        ),
                                        child: pw.Text("Customer Details",
                                            style: pw.TextStyle(
                                                fontSize: 12.0,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                      ),
                                      pw.Text("${customerName ?? "---"}",
                                          style: const pw.TextStyle(
                                              fontSize: 11.0)),
                                      pw.Text("${customerAddress ?? "---"}",
                                          style: const pw.TextStyle(
                                              fontSize: 11.0)),
                                      pw.Text("${customerPhone ?? "---"}",
                                          style: const pw.TextStyle(
                                              fontSize: 11.0)),
                                    ]))
                          ]),
                          pw.Container(
                              width: 100.0,
                              height: 120.0,
                              margin: pw.EdgeInsets.only(left: 10.0),
                              decoration: pw.BoxDecoration(
                                  border:
                                      pw.Border.all(color: PdfColors.black)),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text("Invoice Id: $invoiceId",
                                        style: pw.TextStyle(
                                            fontSize: 13,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.only(left: 10.0),
                                      child: pw.Text("Date:- $datetime",
                                          style: const pw.TextStyle(
                                            fontSize: 10,
                                          )),
                                    ),
                                    pw.SizedBox(height: 5.0),
                                    pw.Text("Terms of payment: ",
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        )),
                                  ]))
                        ]),
                        pw.Divider(),
                        ordertype == 'Dine'
                            ? dineorderedItemsListWidget(orders, imageBytesList)
                            : ordertype == "Catering"
                                ? cateringorderedItemsListWidget(
                                    orders,
                                    thaliprice,
                                    numberOfThali,
                                    totalAmount ?? "0")
                                : orderedItemsListWidget(
                                    orders, imageBytesList),
                        orderSummaryWidget(
                            discount,
                            ordertype,
                            totalAmount ?? "0",
                            remainingAmount,
                            moneytoPay,
                            fullpayment,
                            thaliprice ?? "0",
                            numberOfThali ?? "0"),
                        pw.Container(
                          margin: pw.EdgeInsets.only(top: 10.0),
                          // decoration: pw.BoxDecoration(
                          //     border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Terms And Conditions".padLeft(10),
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    " 1. A Non-refundable advance payment for order cancellations within 2 days "
                                        .padLeft(10)
                                        .padRight(10),
                                    textAlign: pw.TextAlign.justify,
                                    style: const pw.TextStyle(fontSize: 10.0)),
                                pw.Text(
                                    " 2. Our catering services require a 25-50% advance payment upon booking to secure your event date."
                                        .padLeft(10)
                                        .padRight(10),
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(fontSize: 10.0)),
                                pw.Text(
                                    " 3. Extra plates and water bottles will be charged separately. Thali Services does not include them."
                                      ..padLeft(10).padRight(10),
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(fontSize: 10.0)),
                                pw.Text(
                                    " 4. A deposit is required upon booking."
                                      ..padLeft(10).padRight(10),
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(fontSize: 10.0)),
                                pw.Text(
                                    " 5. Menu changes must be requested at least 2 days before the event. "
                                        .padLeft(10)
                                        .padRight(10),
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(fontSize: 10.0)),
                                pw.Text(
                                    " 6. Customers are responsible for purchasing meat and chicken for Non-vegetarian orders. "
                                        .padLeft(10)
                                        .padRight(10),
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(fontSize: 10.0)),
                              ]),
                        ),
                        pw.Container(
                            margin: pw.EdgeInsets.only(top: 20.0),
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: pw.Column(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 5.0),
                                    child: pw.Text(
                                        " Holder Name :  GANESH BAPURAO PATIL"
                                            .padLeft(10),
                                        textAlign: pw.TextAlign.start,
                                        style:
                                            const pw.TextStyle(fontSize: 9.0)),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 5.0),
                                    child: pw.Text(
                                        " Account number :  921010044756764"
                                            .padLeft(10),
                                        textAlign: pw.TextAlign.start,
                                        style:
                                            const pw.TextStyle(fontSize: 9.0)),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 3.0,
                                        top: 5.0),
                                    child: pw.Text(
                                        " IFSC Code :  UTIB0000849".padLeft(10),
                                        textAlign: pw.TextAlign.start,
                                        style:
                                            const pw.TextStyle(fontSize: 9.0)),
                                  )
                                ]))
                      ],
                    ));
              },
            ),
          );

    // Save the PDF as bytes
    final List<int> pdfBytes = await pdf.save();

    final Uint8List uint8List = Uint8List.fromList(pdfBytes);
    final directory = await getApplicationDocumentsDirectory();

//    Define the path to save the PDF
   // final path = '${directory.path}/report.pdf';

    // Create the necessary directories if they don't exist
    // final reportDirectory = Directory('${directory.path}');
    // if (!await reportDirectory.exists()) {
    //   await reportDirectory.create(recursive: true);
    // }

    // Save the PDF file
    // final file = File(path);
    // await file.writeAsBytes(await pdf.save());

    // OpenFile.open(path);

    orderjson.clear();
    // OpenFile.open(r'C:\Users\jashm\Desktop\mpos\temp.pdf');
    return uint8List;
  }

  static pw.Widget dineorderedItemsListWidget(
      List<Items> orders, List<Uint8List> imageBytesList) {
    final List<pw.TableRow> rows = [
      pw.TableRow(
        children: [
          pw.Text("Items",
              style: const pw.TextStyle(
                fontSize: 10,
              )),
          pw.Text("Qty.",
              style: const pw.TextStyle(
                fontSize: 10,
              )),
          pw.Text("Rate",
              style: const pw.TextStyle(
                fontSize: 10,
              )),
          pw.Text("Amount",
              style: const pw.TextStyle(
                fontSize: 10,
              )),
        ],
      ),
    ];

    for (int i = 0; i < orders.length; i++) {
      final itemData = orders[i];
      final imageBytes = imageBytesList[i];
      final pdfImage = pw.MemoryImage(imageBytes);

      rows.add(
        pw.TableRow(
          children: [
            pw.Row(
              children: [
                pw.SizedBox(width: 3),
                pw.Expanded(
                  child: pw.Image(pdfImage),
                ),
              ],
            ),
            pw.Row(children: [
              pw.SizedBox(width: 3),
              pw.Expanded(
                child: pw.Text(itemData.quantity.toString(),
                    maxLines: 2,
                    softWrap: true,
                    style: const pw.TextStyle(
                      fontSize: 10,
                    )),
              ),
            ]),
            pw.Row(
              children: [
                pw.SizedBox(width: 3),
                pw.Expanded(
                  child: pw.Text(itemData.price.toString(),
                      maxLines: 2,
                      softWrap: true,
                      style: const pw.TextStyle(
                        fontSize: 10,
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
                    fontSize: 10,
                  )),
            ),
          ],
        ),
      );
    }

    return pw.Table(
      columnWidths: const {
        0: pw.FixedColumnWidth(100),
        1: pw.FixedColumnWidth(50),
        2: pw.FixedColumnWidth(100),
        3: pw.FixedColumnWidth(100),
      },
      children: rows,
    );
  }

  static pw.Widget orderedItemsListWidget(
      List<Items> orders, List<Uint8List> imageBytesList) {
    final List<pw.TableRow> rows = [
      pw.TableRow(
        children: [
          pw.Text("Items",
              style: const pw.TextStyle(
                fontSize: 10,
              )),
          pw.Text("Qty.",
              style: const pw.TextStyle(
                fontSize: 10,
              )),
          pw.Text("Rate",
              style: const pw.TextStyle(
                fontSize: 10,
              )),
          pw.Text("Amount",
              style: const pw.TextStyle(
                fontSize: 10,
              )),
        ],
      ),
    ];

    for (int i = 0; i < orders.length; i++) {
      final itemData = orders[i];
      final imageBytes = imageBytesList[i];
      final pdfImage = pw.MemoryImage(imageBytes);

      rows.add(
        pw.TableRow(
          children: [
            pw.Row(
              children: [
                pw.SizedBox(width: 3),
                pw.Expanded(
                  child: pw.Image(pdfImage),
                ),
              ],
            ),
            pw.Row(children: [
              pw.SizedBox(width: 3),
              pw.Expanded(
                child: pw.Text(itemData.quantity.toString(),
                    maxLines: 2,
                    softWrap: true,
                    style: const pw.TextStyle(
                      fontSize: 10,
                    )),
              ),
            ]),
            pw.Row(
              children: [
                pw.SizedBox(width: 3),
                pw.Expanded(
                  child: pw.Text(itemData.price.toString(),
                      maxLines: 2,
                      softWrap: true,
                      style: const pw.TextStyle(
                        fontSize: 10,
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
                    fontSize: 10,
                  )),
            ),
          ],
        ),
      );
    }

    return pw.Table(
      columnWidths: const {
        0: pw.FixedColumnWidth(100),
        1: pw.FixedColumnWidth(50),
        2: pw.FixedColumnWidth(100),
        3: pw.FixedColumnWidth(100),
      },
      children: rows,
    );
  }

  static Future<Uint8List> _captureTextAsImage(String text) async {
    final TextSpan span = TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 40),
      text: text,
    );

    final TextPainter painter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );

    painter.layout();

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final rect = Rect.fromLTWH(0.0, 0.0, painter.width, painter.height);
    canvas.drawRect(
        rect, Paint()..color = Colors.white); // Fill with white color

    painter.paint(canvas, Offset.zero);

    final img = pictureRecorder.endRecording();
    final ui.Image image =
        await img.toImage(painter.width.ceil(), painter.height.ceil());
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  static pw.Widget cateringorderedItemsListWidget(
      List<Items> orders, var thaliprice, var numberOfThali, var totalamount) {
    return pw.Center(
      child: pw.Table(
        border: const pw.TableBorder(
          verticalInside: pw.BorderSide(color: PdfColors.black),
        ),
        columnWidths: const {
          0: pw.FixedColumnWidth(100),
          1: pw.FixedColumnWidth(50),
          2: pw.FixedColumnWidth(100),
          3: pw.FixedColumnWidth(100),
          4: pw.FixedColumnWidth(100),
        },
        children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.black),
              ),
            ),
            children: [
              pw.Center(
                child: pw.Text(" Menu Items",
                    style: const pw.TextStyle(
                      fontSize: 10,
                    )),
              ),
              pw.Center(
                child: pw.Text("Qty.",
                    style: const pw.TextStyle(
                      fontSize: 10,
                    )),
              ),
              pw.Center(
                child: pw.Text("Adjusted",
                    style: const pw.TextStyle(
                      fontSize: 10,
                    )),
              ),
              pw.Center(
                child: pw.Text("Unit Cost",
                    style: const pw.TextStyle(
                      fontSize: 10,
                    )),
              ),
              pw.Center(
                child: pw.Text("Total Price",
                    style: const pw.TextStyle(
                      fontSize: 10,
                    )),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              // First Column (Iterate over orders)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  for (var itemData in orders)
                    pw.Row(
                      children: [
                        pw.SizedBox(width: 3),
                        pw.Expanded(
                          child: pw.Text(
                            itemData.name.toString(),
                            maxLines: 2,
                            softWrap: true,
                            style: const pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              // Second Column (Fixed text, not iterated)

              pw.Container(
                margin: pw.EdgeInsets.only(top: 15.0),
                child: pw.Center(
                  child: pw.Text(
                    numberOfThali,
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              // Third Column (Fixed text, not iterated)
              pw.Row(
                children: [
                  pw.SizedBox(width: 3),
                  pw.Expanded(
                      child: pw.Center(
                    child: pw.Text(
                      "",
                      maxLines: 2,
                      softWrap: true,
                      style: pw.TextStyle(
                          fontSize: 10, fontWeight: pw.FontWeight.bold),
                    ),
                  )),
                ],
              ),
              // Fourth Column (Empty container)

              pw.Container(
                  margin: pw.EdgeInsets.only(top: 15.0),
                  child: pw.Center(
                    child: pw.Text(
                      thaliprice,
                      maxLines: 2,
                      softWrap: true,
                      style: pw.TextStyle(
                          fontSize: 10, fontWeight: pw.FontWeight.bold),
                    ),
                  )),
              pw.Container(
                  margin: pw.EdgeInsets.only(top: 15.0),
                  child: pw.Center(
                    child: pw.Text(
                      totalamount.toString(),
                      style: pw.TextStyle(
                          fontSize: 10, fontWeight: pw.FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget orderSummaryWidget(
      var discount,
      String? orderType,
      totalAmount,
      remaningAmount,
      moneytoPay,
      fullpayment,
      thaliPrice,
      thaliCount) {
    return pw.Column(
      children: [
        pw.Divider(),
        // orderType == "Catering" && fullpayment == false
        //     ? pw.Row(
        //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //         children: [
        //           pw.Text("Price of Thali",
        //               style: pw.TextStyle(
        //                 fontSize: 10,
        //               )),
        //           pw.Text("$thaliPrice",
        //               style: pw.TextStyle(
        //                 fontSize: 10,
        //               )),
        //         ],
        //       )
        //     : pw.SizedBox(),
        // orderType == "Catering" && fullpayment == false
        //     ? pw.Row(
        //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //         children: [
        //           pw.Text("No. of Thali",
        //               style: pw.TextStyle(
        //                 fontSize: 10,
        //               )),
        //           pw.Text("$thaliCount",
        //               style: pw.TextStyle(
        //                 fontSize: 10,
        //               )),
        //         ],
        //       )
        //     : pw.SizedBox(),
        // pw.Row(
        //   children: [
        //     pw.Text("Item Discount",
        //         style: const pw.TextStyle(
        //           fontSize: 10,
        //         )),
        //     pw.Text("$discount",
        //         style: const pw.TextStyle(
        //           fontSize: 10,
        //         )),
        //   ],
        // ),
        // orderType == "Advance" ||
        //         orderType == "Catering" && fullpayment == false
        //     ? pw.Row(
        //         mainAxisAlignment: pw.MainAxisAlignment.end,
        //         children: [
        //           pw.Text("Remaining Amount:- ",
        //               style: pw.TextStyle(
        //                 fontSize: 10,
        //               )),
        //           pw.Text("$remaningAmount".padRight(10),
        //               style: pw.TextStyle(
        //                 fontSize: 10,
        //               )),
        //         ],
        //       )
        //     : pw.SizedBox(),
        // pw.Row(
        //   mainAxisAlignment: pw.MainAxisAlignment.end,
        //   children: [
        //     pw.Text("Item Subtotal:- ",
        //         style: pw.TextStyle(
        //           fontSize: 10,
        //         )),
        //     pw.Text("${totalAmount}".padRight(10),
        //         style: pw.TextStyle(
        //           fontSize: 10,
        //         )),
        //   ],
        // ),
        // pw.Divider(),
        // pw.Row(
        //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //   children: [
        //     pw.Text("GST",
        //         style: pw.TextStyle(
        //           fontSize: 10,
        //         )),

        //     pw.Text(
        //             "2.5%",
        //             style: pw.TextStyle(
        //               fontSize: 13,
        //               fontWeight: pw.FontWeight.bold,
        //             ),
        //           ),
        //   ],
        // ),
        // pw.Row(
        //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //   children: [
        //     pw.Text("SGST",
        //         style: pw.TextStyle(
        //           fontSize: 10,
        //         )),

        //     pw.Text(
        //             "2.5%",
        //             style: pw.TextStyle(
        //               fontSize: 13,
        //               fontWeight: pw.FontWeight.bold,
        //             ),
        //           ),
        //   ],
        // ),

        pw.Divider(),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text("Payable Amount:- ",
                style: pw.TextStyle(
                  fontSize: 10,
                )),

                
            orderType == "Advance"
                ? pw.Text(
                    "$totalAmount".padRight(10),
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  )
                : pw.Text(
                    "$totalAmount".padRight(10),
                    style: pw.TextStyle(
                      fontSize: 13,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                   pw.Text("Credit Amount:- ",
                style: pw.TextStyle(
                  fontSize: 10,
                )),

                  //    orderType == "Advance"?
                  //  pw.Text(''):pw.Text("Credit Amount"),


                  
          ],
        ),

        orderType == "Advance" ||
                orderType == "Catering" && fullpayment == false
            ? pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("Advance Payment:- ",
                      style: pw.TextStyle(
                        fontSize: 11.5,
                      )),
                  pw.Text(
                    "$moneytoPay".padRight(10),
                    style: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  )
                ],
              )
            : pw.SizedBox(),
        orderType == "Advance" ||
                orderType == "Catering" && fullpayment == false
            ? pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("Pending Amount:- ",
                      style: pw.TextStyle(
                        fontSize: 11.5,
                      )),
                  pw.Text(
                    "$remaningAmount".padRight(10),
                    style: pw.TextStyle(
                      fontSize: 10.0,
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
