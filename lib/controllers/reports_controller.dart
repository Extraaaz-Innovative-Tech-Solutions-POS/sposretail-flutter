import 'dart:io';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../model/reports/sold_item_total.dart';
import 'package:spos_retail/views/widgets/export.dart';

class ReportsController extends GetxController {
  RxString totalInvoice = "0".obs;
  RxString totalSales = "0".obs;
  RxString totalproductsSold = "0".obs;
  RxString totalCashierWiseInvoice = "0".obs;
  RxString totalCashierWiseSales = "0".obs;
  RxString totalCashierWiseproductsSold = "0".obs;
  RxString cashierWiseName = "".obs;
  RxString cashierWiseRole = "".obs;
  RxList<Result> billing = <Result>[].obs;
  RxList<Orders> cancelledReportList = <Orders>[].obs;
  RxList<ItemSalesReport> itemSalesReportList = <ItemSalesReport>[].obs;
  RxList<SoldItemTotal> soldItemTotalList = <SoldItemTotal>[].obs;

  dayReport(startDate, endDate, bool downloadCheck) async {
    try {
      final response = await DioServices.get(AppConstant.dayReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      if (response.statusCode == 200) {
        billing.assignAll((response.data['result'])
            .map<Result>((json) => Result.fromJson(json)));
        update();
        if (downloadCheck == true) {
          List<dynamic> result = response.data['result'];
          List<Result> billingReports =
              result.map<Result>((json) => Result.fromJson(json)).toList();
          List<Map<String, dynamic>> billingData = billingReports
              .map((report) => report
                  .toJson()) // Assuming toJson method is available in BillingReport
              .toList();

          await createExcelFile(billingData, "bill_wise");
        }

        print(" BILLING DONE ${billing[0].paymentType}");
      }
    } catch (e) {}
  }

  cashierReport(startDate, endDate, bool downloadcheck) async {
    try {
      final response = await DioServices.get(AppConstant.cashierReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      print(response);

      if (response.statusCode == 200) {
        totalInvoice.value = response.data["totalInvoice"].toString();
        totalSales.value = response.data["totalSale"].toString();
        totalproductsSold.value = response.data["productsCount"].toString();
        update();
        if (downloadcheck == true) {
          List<Map<String, dynamic>> data = [
            {
              'Total Invoice': response.data["totalInvoice"].toString(),
              'Total Sales': response.data["totalSale"].toString(),
              'Total Products Sold': response.data["productsCount"].toString(),
            },
          ];
          await createExcelFile(data, "cashier_report");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  fetchCashierWiseReport(startDate, endDate, bool downloadcheck) async {
    try {
      final response = await DioServices.get(AppConstant.cashierWiseReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      print("FETCH CASHIER RESPOSE ${response}");

      if (response.statusCode == 200) {
        totalCashierWiseInvoice.value =
            response.data["totalInvoice"].toString();
        totalCashierWiseSales.value = response.data["totalSale"].toString();
        totalCashierWiseproductsSold.value =
            response.data["productsCount"].toString();
        totalCashierWiseproductsSold.value =
            response.data["productsCount"].toString();
        cashierWiseName.value =
            response.data["ordersQuery"][0]["name"].toString();
        cashierWiseRole.value =
            response.data["ordersQuery"][0]["role"].toString();
        update();
        if (downloadcheck == true) {
          List<Map<String, dynamic>> data = [
            {
              'Total Invoice': response.data["totalInvoice"].toString(),
              'Total Sales': response.data["totalSale"].toString(),
              'Total Products Sold': response.data["productsCount"].toString(),
            },
          ];
          await createExcelFile(data, "cashier_wise_report");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  cancelledReport(startDate, endDate, bool downloadcheck) async {
    try {
      final response = await DioServices.get(AppConstant.cancelOrderReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      if (response.statusCode == 200) {
        cancelledReportList.assignAll((response.data['orders'])
            .map<Orders>((json) => Orders.fromJson(json)));
        update();
        if (downloadcheck == true) {
          List<dynamic> result = response.data['orders'];
          List<Orders> cancelreport =
              result.map<Orders>((json) => Orders.fromJson(json)).toList();
          print(
              "CANCELlllllllllllllll REPORT =======================> $cancelreport");
          List<Map<String, dynamic>> billingData = cancelreport
              .map((report) => report
                  .toJson()) // Assuming toJson method is available in BillingReport
              .toList();
          print(
              "Cancelled DATA ====================================== > $billingData");
          await createExcelFile(billingData, "cancel_report");
        }
        // print(" BILLING DONE ${cancelledReportList[0].name}");
      }

      print("${response.data}  ====== THIS IS RESSSSSSSSSSS");
    } catch (e) {}
  }

  fetchItemsSalesReport(startDate, endDate, bool downloadCheck) async {
    // print("STARTED");
    try {
      final response = await DioServices.get(AppConstant.itemSalesReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      if (response.statusCode == 200) {
        // debugPrint("Your Item Sales Response--------------> ${response.data}");
        print(
            "Your Item Sales Response--------------> ${response.data['productsCount']}");
        itemSalesReportList.assignAll((response.data['productsCount'])
            .map<ItemSalesReport>((json) => ItemSalesReport.fromJson(json)));
        update();
        if (downloadCheck == true) {
          List<dynamic> result = response.data['productsCount'];
          List<ItemSalesReport> cancelreport = result
              .map<ItemSalesReport>((json) => ItemSalesReport.fromJson(json))
              .toList();
          List<Map<String, dynamic>> billingData = cancelreport
              .map((report) => report
                  .toJson()) // Assuming toJson method is available in BillingReport
              .toList();
          print(billingData.length);
          await createExcelFile(billingData, "itemSales_report");
          update();
        }

        print(
            "ASSIGNED ITEM LIST REPORT : ======================> ${itemSalesReportList[0].name}");
      } else {}
    } catch (e) {}
  }

  fetchSoldItemsReport(startDate, endDate, bool downloadCheck) async {
    //print("STARTED");
    try {
      final response = await DioServices.get(AppConstant.soldItemTotal,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      if (response.statusCode == 200) {
        print("SOLD RESPONSE ------------------------ ${response.data}");
        print(
            "Your Sold Item Sales Response--------------> ${response.data['productsData']}");
        soldItemTotalList.assignAll((response.data['productsData'])
            .map<SoldItemTotal>((json) => SoldItemTotal.fromJson(json)));
        update();
        if (downloadCheck == true) {
          List<dynamic> result = response.data['productsData'];
          List<SoldItemTotal> soldReport = result
              .map<SoldItemTotal>((json) => SoldItemTotal.fromJson(json))
              .toList();
          List<Map<String, dynamic>> billingData = soldReport
              .map((report) => report
                  .toJson()) // Assuming toJson method is available in BillingReport
              .toList();
          await createExcelFile(billingData, "soldItems_report");
          update();
        }

        print(
            "ASSIGNED SOLD ITEM LIST REPORT : ======================> ${itemSalesReportList[0].name}");
      } else {}
    } catch (e) {}
  }
}

Future<void> createExcelFile(
    List<Map<String, dynamic>> data, String endpoint) async {
  // Create a new Excel workbook
  final Workbook workbook = Workbook();

  // Add a worksheet
  final Worksheet sheet = workbook.worksheets[0];

  // Add column names
  final List<String> columnNames =
      data.isNotEmpty ? data.first.keys.toList() : [];
  for (int col = 0; col < columnNames.length; col++) {
    sheet.getRangeByIndex(1, col + 1).setText(columnNames[col]);
  }

  // Add data rows
  for (int row = 0; row < data.length; row++) {
    final rowData = data[row].values.toList();
    for (int col = 0; col < rowData.length; col++) {
      sheet.getRangeByIndex(row + 2, col + 1).setText(rowData[col].toString());
    }
  }

  // Get the temporary directory path
  final Directory tempDir = await getTemporaryDirectory();
  final String tempPath = tempDir.path;

  // Save the Excel file
  final String filePath = '$tempPath/$endpoint.xlsx';
  final File file = File(filePath);
  await file.writeAsBytes(await workbook.saveAsStream());
  workbook.dispose();

  print('Excel file saved at: $filePath');
  OpenFile.open(filePath);
}
