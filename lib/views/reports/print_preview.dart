import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:spos_retail/views/widgets/export.dart';

class PdfGenerator {
  final ReportsController reportsController;

  PdfGenerator(this.reportsController);

  Future<void> generateReportPdf(
      String dropdownValue, String startDate, String endDate) async {
    // Create a PDF document
    final pdf = pw.Document();

    // Retrieve data based on the dropdown selection
    var reportData;
    switch (dropdownValue) {
      case 'Select':
        reportData =
            await reportsController.cashierReport(startDate, endDate, false);
        break;
      case 'Cashier Hallwise':
        reportData =
            await reportsController.dayReport(startDate, endDate, false);
        break;
      case 'Billwise':
        reportData =
            await reportsController.dayReport(startDate, endDate, false);
        break;
      case 'Item Sales':
        reportData = await reportsController.fetchItemsSalesReport(
            startDate, endDate, false);
        break;
      case 'Sold Items':
        reportData = await reportsController.fetchSoldItemsReport(
            startDate, endDate, false);
        break;
      case 'Cancelled Item':
        reportData =
            await reportsController.cancelledReport(startDate, endDate, true);
        break;
      default:
        return; // Exit function if no valid report type is found
    }

    // Add content to the PDF based on the report data
    pdf.addPage(pw.Page(
      build: (context) {
        switch (dropdownValue) {
          case 'Select':
            return buildSelectReport(pdf, reportData);
          case 'Cashier Hallwise':
            return buildCashierHallwiseReport(pdf, reportData);
          case 'Billwise':
            return buildBillwiseReport(pdf, reportData);
          case 'Item Sales':
            return buildItemSalesReport(pdf, reportData);
          case 'Sold Items':
            return buildSoldItemsReport(pdf, reportData);
          case 'Cancelled Item':
            return buildCancelledItemReport(pdf, reportData);
          default:
            return pw
                .Container(); // Return an empty container if no match found
        }
      },
    ));

    final directory = await getApplicationDocumentsDirectory();

    // Define the path to save the PDF
    final path = '${directory.path}/reports/report.pdf';

    // Create the necessary directories if they don't exist
    final reportDirectory = Directory('${directory.path}/reports');
    if (!await reportDirectory.exists()) {
      await reportDirectory.create(recursive: true);
    }
    

    // Save the PDF file
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    // print('PDF files Saved at: $path');
    // OpenFile.open(path);

    //showPrintPreview(file);
  }

  pw.Widget buildSelectReport(pw.Document pdf, var reportData) {
    // Add your specific UI elements and data handling for the 'Select' report
    return pw.Center(
      child: pw.Text('Select Report'),
    );
  }

  pw.Widget buildCashierHallwiseReport(pw.Document pdf, var reportData) {
    // Add your specific UI elements and data handling for the 'Cashier Hallwise' report
    return pw.Center(
      child: pw.Text('Cashier Hallwise Report'),
    );
  }

  pw.Widget buildBillwiseReport(pw.Document pdf, var reportData) {
    // Define the column headers
    final columns = <pw.Widget>[
      pw.Text('TableID',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Amt.',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Payment',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
    ];

    // Define the rows for the table
    final rows = <pw.TableRow>[
      for (int index = 0; index < reportsController.billing.length; index++)
        pw.TableRow(
          children: [
            pw.Text(reportsController.billing[index].tableId.toString()),
            pw.Text(reportsController.billing[index].total.toString()),
            pw.Text(reportsController.billing[index].paymentType.toString()),
          ],
        ),
    ];

    // Create the table
    return pw.Table(
      columnWidths: {
        0: const pw.FixedColumnWidth(200), // Set width for the first column
        1: const pw.FlexColumnWidth(),
        2: const pw.FlexColumnWidth(),
      },
      children: [
        pw.TableRow(
          children: columns,
        ),
        ...rows,
      ],
    );
  }

  pw.Widget buildItemSalesReport(pw.Document pdf, var reportData) {
    // Add your specific UI elements and data handling for the 'Item Sales' report
    final columns = <pw.Widget>[
      pw.Text('Name',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Qty.',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Price',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Total',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
    ];

    // Define the rows for the table
    final rows = <pw.TableRow>[
      for (int index = 0;
          index < reportsController.itemSalesReportList.length;
          index++)
        pw.TableRow(
          children: [
            pw.Text(
                reportsController.itemSalesReportList[index].name.toString()),
            pw.Text(reportsController.itemSalesReportList[index].quantity
                .toString()),
            pw.Text(
                reportsController.itemSalesReportList[index].price.toString()),
            pw.Text(reportsController.itemSalesReportList[index].productTotal
                .toString()),
          ],
        ),
    ];

    // Create the table
    return pw.Table(
      columnWidths: {
        0: const pw.FixedColumnWidth(200), // Set width for the first column
        1: const pw.FlexColumnWidth(),
        2: const pw.FlexColumnWidth(),
        3: const pw.FlexColumnWidth(),
      },
      children: [
        pw.TableRow(
          children: columns,
        ),
        ...rows,
      ],
    );
  }

  pw.Widget buildSoldItemsReport(pw.Document pdf, var reportData) {
    // Add your specific UI elements and data handling for the 'Sold Items' report
    final columns = <pw.Widget>[
      pw.Text('Name',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Qty.',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Price',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Total',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
    ];

    // Define the rows for the table
    final rows = <pw.TableRow>[
      for (int index = 0;
          index < reportsController.soldItemTotalList.length;
          index++)
        pw.TableRow(
          children: [
            pw.Text(reportsController.soldItemTotalList[index].name.toString()),
            pw.Text(
                reportsController.soldItemTotalList[index].quantity.toString()),
            pw.Text(
                reportsController.soldItemTotalList[index].price.toString()),
            pw.Text(reportsController.soldItemTotalList[index].productTotal
                .toString()),
          ],
        ),
    ];

    // Create the table
    return pw.Table(
      columnWidths: {
        0: const pw.FixedColumnWidth(200), // Set width for the first column
        1: const pw.FlexColumnWidth(),
        2: const pw.FlexColumnWidth(),
        3: const pw.FlexColumnWidth(),
      },
      children: [
        pw.TableRow(
          children: columns,
        ),
        ...rows,
      ],
    );
  }

  pw.Widget buildCancelledItemReport(pw.Document pdf, var reportData) {
    // Add your specific UI elements and data handling for the 'Cancelled Item' report
    final columns = <pw.Widget>[
      pw.Text('Item Name',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.Text('Status',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
    ];

    // Define the rows for the table
    final rows = <pw.TableRow>[
      for (int index = 0;
          index < reportsController.cancelledReportList.length;
          index++)
        pw.TableRow(
          children: [
            pw.Text(
                reportsController.cancelledReportList[index].name.toString()),
            pw.Text(
                reportsController.cancelledReportList[index].status.toString()),
          ],
        ),
    ];

    // Create the table
    return pw.Table(
      columnWidths: {
        0: const pw.FixedColumnWidth(200), // Set width for the first column
        1: const pw.FlexColumnWidth(),
      },
      children: [
        pw.TableRow(
          children: columns,
        ),
        ...rows,
      ],
    );
  }

  // void showPrintPreview(File pdfFile) async {
  //   // Use the Printing package to show the print preview
  //   await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async => pdfFile.readAsBytes(),
  //   );
  // }

  DataColumn dataColumn(title) {
    return DataColumn(
      label: customText(title),
    );
  }

  DataCell dataCell(title) {
    return DataCell(customText(title));
  }
}
