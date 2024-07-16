import 'dart:io';

import 'package:spos_retail/model/cart_respose_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'package:spos_retail/views/widgets/export.dart';

Future<Uint8List> generatekotpdf(
    {required DateTime date,
    required var table,
    required var floor,
    required List<Item> orders,
    required orderId,
    required kotId,
    required String orderType,
    required bool rebuildStatus,
    List<Items>? rebuildItems}) async {
  //var controller = Get.put(UserController());
  final emoji = await PdfGoogleFonts.notoColorEmoji();

  final pdf = pw.Document();
  final imageBytesList = await Future.wait(
    orders.map((order) => _captureTextAsImage(order.name)).toList(),
  );

  pdf.addPage(
    pw.Page(
      pageFormat: const PdfPageFormat(
        80 * PdfPageFormat.mm,
        90 * PdfPageFormat.mm, // A4 paper height in mm (you can adjust this)
        marginAll: 5 * PdfPageFormat.mm,
      ),
      orientation: pw.PageOrientation.portrait,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Divider(),
            pw.Center(
              // fit: pw.BoxFit.fitWidth,
              child: pw.Container(
                child: pw.Text(
                  "KOT",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontFallback: [emoji],
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              height: 5,
            ),

            pw.Center(
              // fit: pw.BoxFit.fitWidth,
              child: pw.Container(
                child: pw.Text(
                  orderType,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontFallback: [emoji],
                  ),
                ),
              ),
            ),

            // pw.SizedBox(height: 20),
            pw.Divider(),

            // pw.Divider(),
            pw.FittedBox(
                fit: pw.BoxFit.fitWidth,
                child: pw.Column(children: [
                  pw.Row(
                    children: [
                      pw.Text(
                        "Table",
                        style: pw.TextStyle(
                          // fontWeight: pw.FontWeight.bold,
                          fontFallback: [emoji],
                        ),
                      ),
                      pw.SizedBox(width: 30),
                      pw.Text(
                        "$floor/$table",
                        style: pw.TextStyle(
                          // fontWeight: pw.FontWeight.bold,
                          fontFallback: [emoji],
                        ),
                      ),
                    ],
                  ),
                  // pw.Text(
                  //   "BillNo:- ${orderId.toString()}",
                  //   // style: pw.TextStyle(
                  //   //   // fontWeight: pw.FontWeight.bold,
                  //   //   fontFallback: [emoji],
                  //   // ),
                  // ),
                  // pw.Row(
                  //   children: [
                  //     pw.Text(
                  //       "Floor",
                  //       style: pw.TextStyle(
                  //         // fontWeight: pw.FontWeight.bold,
                  //         fontFallback: [emoji],
                  //       ),
                  //     ),
                  //     pw.SizedBox(width: 30),
                  //     pw.Text(
                  //       "$floor",
                  //       style: pw.TextStyle(
                  //         // fontWeight: pw.FontWeight.bold,
                  //         fontFallback: [emoji],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ])),
            pw.FittedBox(
              fit: pw.BoxFit.fitWidth,
              child: pw.Container(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Date: ${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute}",
                      style: pw.TextStyle(
                        fontFallback: [emoji],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //   pw.Divider(),
            pw.SizedBox(height: 10),
            orderedItemsListWidget(orders, imageBytesList)
            // pw.Table(
            //   children: [
            //     pw.TableRow(
            //       children: [
            //         pw.Text(
            //           "Item Name",
            //           style: pw.TextStyle(
            //             fontWeight: pw.FontWeight.bold,
            //             fontFallback: [emoji],
            //           ),
            //         ),
            //         pw.Text(
            //           "Qty",
            //           style: pw.TextStyle(
            //             fontWeight: pw.FontWeight.bold,
            //             fontFallback: [emoji],
            //           ),
            //         ),
            //       ],
            //     ),
            //     ...rebuildStatus == false
            //         ? orders
            //             .map((item) => pw.TableRow(
            //                   children: [
            //                     pw.RichText(
            //                       text: pw.TextSpan(
            //                         children: [
            //                           pw.TextSpan(
            //                               text: item.name.padRight(10),
            //                               style:
            //                                   const pw.TextStyle(fontSize: 12)),
            //                           pw.TextSpan(
            //                               text: "(${item.instruction})",
            //                               style: pw.TextStyle(
            //                                 fontSize: 9,
            //                                 fontWeight: pw.FontWeight.bold,
            //                               )),
            //                         ],
            //                       ),
            //                     ),

            //                     // pw.Text(
            //                     //   "${item.name}- ${item.instruction}",
            //                     //   style: pw.TextStyle(
            //                     //     fontFallback: [emoji],
            //                     //   ),
            //                     // ),
            //                     pw.Text(
            //                       "${item.quantity}",
            //                       style: pw.TextStyle(
            //                         fontFallback: [emoji],
            //                       ),
            //                     ),
            //                   ],
            //                 ))
            //             .toList()
            //         : rebuildItems!
            //             .map((item) => pw.TableRow(
            //                   children: [
            //                     pw.RichText(
            //                       text: pw.TextSpan(
            //                         children: [
            //                           pw.TextSpan(
            //                               text: item.name!.padRight(10),
            //                               style:
            //                                   const pw.TextStyle(fontSize: 12)),
            //                           // pw.TextSpan(
            //                           //     text: "More Sugar",
            //                           //     style: pw.TextStyle(
            //                           //       fontSize: 9,
            //                           //       fontWeight: pw.FontWeight.bold,
            //                           //     )),
            //                         ],
            //                       ),
            //                     ),

            //                     // pw.Text(
            //                     //   "${item.name}- ${item.instruction}",
            //                     //   style: pw.TextStyle(
            //                     //     fontFallback: [emoji],
            //                     //   ),
            //                     // ),
            //                     pw.Text(
            //                       "${item.quantity}",
            //                       style: pw.TextStyle(
            //                         fontFallback: [emoji],
            //                       ),
            //                     ),
            //                   ],
            //                 ))
            //             .toList()
            //   ],
            // ),
          ],
        ); // Center
      },
    ),
  );
  final List<int> pdfBytes = await pdf.save();

  final Uint8List uint8List = Uint8List.fromList(pdfBytes);
  final directory = await getApplicationDocumentsDirectory();

  //Define the path to save the PDF
  final path = '${directory.path}/kot.pdf';

  // Create the necessary directories if they don't exist
  // final reportDirectory = Directory('${directory.path}');
  // if (!await reportDirectory.exists()) {
  //   await reportDirectory.create(recursive: true);
  // }

  // Save the PDF file
  // final file = File(path);
  // await file.writeAsBytes(await pdf.save());
  // OpenFile.open(path);

  return uint8List;
}

pw.Widget orderedItemsListWidget(
    List<dynamic> orders, List<Uint8List> imageBytesList) {
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
                child: pw.Image(pdfImage, width: 60.0, height: 100.0),
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
        ],
      ),
    );
  }

  return pw.Table(
    columnWidths: const {
      0: pw.FixedColumnWidth(100),
      1: pw.FixedColumnWidth(50),
    },
    children: rows,
  );
}

Future<Uint8List> _captureTextAsImage(String text) async {
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
  canvas.drawRect(rect, Paint()..color = Colors.white); // Fill with white color

  painter.paint(canvas, Offset.zero);

  final img = pictureRecorder.endRecording();
  final ui.Image image =
      await img.toImage(painter.width.ceil(), painter.height.ceil());
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
