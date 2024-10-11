import 'dart:io';

import 'package:intl/intl.dart';
import 'package:spos_retail/model/reports/credit_report.dart';
import 'package:spos_retail/model/reports/cutoffmodel.dart';
import 'package:spos_retail/model/reports/dayblock_model.dart';
import 'package:spos_retail/model/reports/purchase_order.dart';
import 'package:spos_retail/model/reports/quantitywise_itemsell.dart';
import 'package:spos_retail/model/reports/salereports_model.dart';
import 'package:spos_retail/model/reports/salesprofitloss.dart';
import 'package:spos_retail/model/reports/stock_reports_model.dart';
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



  RxList<SalesDataModel> salesDataModel =<SalesDataModel>[].obs;
  RxList<ItemSale> salesDataList =<ItemSale>[].obs;
  RxList<ItemSale> worstSellingItemList =<ItemSale>[].obs;
  RxList<ItemSale> bestSellingItemList =<ItemSale>[].obs;

  RxList<StockReportModdel> stockReportModelList =<StockReportModdel>[].obs;

    RxList<CutOffDayModdel> cuttOffDayModelList =<CutOffDayModdel>[].obs;
     RxList<DayBlockModel> dayblockModelList =<DayBlockModel>[].obs;
      RxList<SalesProfitLossModel> salesProfitLossModelList =<SalesProfitLossModel>[].obs;




  RxList<CreditReport> creditReportList = <CreditReport>[].obs;
  RxList<QuantityWiseItemSales> quantityWiseItemList = <QuantityWiseItemSales>[].obs;
  RxList<PurchaseModel> purchaseList = <PurchaseModel>[].obs;






  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String formattedStartDate = "";
  String formattedEndDate = "";




    startDatePicker(context) async {
    DateTime? selectedDate = await showDatePicker(
      // barrierColor: Theme.of(context).highlightColor,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
      lastDate: DateTime.now(),
      
    );

   
      startDate = selectedDate as DateTime;
      formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
      update();


    return formattedStartDate;
  }

  endDatePicker(context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -(365 * 5))),
      lastDate: DateTime.now(),
    );

   
      endDate = selectedDate!;
      formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);
       update();
    return endDate;
  }



  

  dayReport( bool downloadCheck) async {
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

  cashierReport(bool downloadcheck) async {
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

  fetchCashierWiseReport( bool downloadcheck) async {
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



  

  cancelledReport( bool downloadcheck) async {
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

  fetchItemsSalesReport( bool downloadCheck) async {
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

  fetchSoldItemsReport( bool downloadCheck) async {
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




  //////////////
  saleReport( bool downloadcheck) async {
    try {
      final response = await DioServices.get(AppConstant.saleReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      print(response);

      if (response.statusCode == 200) {
        
        print("sales data checking: ${response.data['item_sales']}");


          salesDataList.assignAll((response.data['item_sales'])
            .map<ItemSale>((json) => ItemSale.fromJson(json)));

            bestSellingItemList.assignAll((response.data['best_selling_items'])
            .map<ItemSale>((json) => ItemSale.fromJson(json)));

              worstSellingItemList.assignAll((response.data['worst_selling_items'])
            .map<ItemSale>((json) => ItemSale.fromJson(json)));
        update();
    

        print("List of item sale : ${salesDataList}");

        if (downloadcheck == true) {
          List<Map<String, dynamic>> data = [
            {

            },
          ];
          await createExcelFile(data, "sale_reports");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }





    //////////////
  StockReport( bool downloadcheck) async {
    try {
      final response = await DioServices.get(AppConstant.stockReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      print(response);

      if (response.statusCode == 200) {

        

        stockReportModelList.assignAll((response.data['ingredients'])
            .map<StockReportModdel>((json) => StockReportModdel.fromJson(json)));

            update();

            print("Stcok reportlist : ${stockReportModelList}");

        if (downloadcheck == true) {
          List<Map<String, dynamic>> data = [
            {

            },
          ];
          await createExcelFile(data, "stock report");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



      //////////////
  CutOffdayReport( bool downloadcheck) async {
    try {
      final response = await DioServices.get(AppConstant.cutOffdayReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      print(response);

      if (response.statusCode == 200) {
        cuttOffDayModelList.assignAll((response.data['cut_off_report'])
            .map<CutOffDayModdel>((json) => CutOffDayModdel.fromJson(json)));
            update();


            print("cutoff reportlist : ${cuttOffDayModelList}");
        if (downloadcheck == true) {
          List<Map<String, dynamic>> data = [
            {

            },
          ];
          await createExcelFile(data, "cut-Offday-report");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }





        //////////////
  DayBlockReport( bool downloadcheck) async {
    try {
      final response = await DioServices.get(AppConstant.dayBlockReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      print(response);

      if (response.statusCode == 200) {
        dayblockModelList.assignAll((response.data['daily_report'])
            .map<DayBlockModel>((json) => DayBlockModel.fromJson(json)));
            update();

            
            print("Stcok reportlist : ${dayblockModelList}");

        
        if (downloadcheck == true) {
          List<Map<String, dynamic>> data = [
            {

            },
          ];
          await createExcelFile(data, "day-block-report");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  
        //////////////
   salesProfitLossReport( bool downloadcheck) async {
    try {
      final response = await DioServices.get(AppConstant.salesProfitLossReport,
          queryParameters: {"fromDate": startDate, "toDate": endDate});

      print(response);

      if (response.statusCode == 200) {
        salesProfitLossModelList.assignAll((response.data['report'])
            .map<SalesProfitLossModel>((json) => SalesProfitLossModel.fromJson(json)));
            update();

            
            print("Stcok reportlist : ${salesProfitLossModelList}");

        

        if (downloadcheck == true) {
          List<Map<String, dynamic>> data = [
            {

            },
          ];
          await createExcelFile(data, "sales-profitloss-report");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }









    fetchItemsQualityWise() async {
    try{
      final response = await DioServices.get(AppConstant.itemSalesQuantityWise, queryParameters: {"fromDate": formattedStartDate, "toDate": formattedEndDate});
      print(response.data);
      quantityWiseItemList.assignAll((response.data['orders'])
            .map<QuantityWiseItemSales>((json) => QuantityWiseItemSales.fromJson(json)));
        update();
        print("LENGTH ------------ ${quantityWiseItemList.length}");
    } catch(e) {

    }

}

fetchPurchaseReport() async {
  try{
      final response = await DioServices.get(AppConstant.purchaseReport, queryParameters: {"fromDate": formattedStartDate, "toDate": formattedEndDate});
      print(response.data);
      purchaseList.assignAll((response.data)
            .map<PurchaseModel>((json) => PurchaseModel.fromJson(json)));
        update();
        print("LENGTH ------------ ${purchaseList.length}");
      
    } catch(e) {

    }


}

fetchCreditPaymentReport() async {
  try{
      final response = await DioServices.get(AppConstant.creditPaymentReport, queryParameters: {"fromDate": formattedStartDate, "toDate": formattedEndDate});
      print(response.data);
      creditReportList.assignAll((response.data)
            .map<CreditReport>((json) => CreditReport.fromJson(json)));
        update();
    } catch(e) {
      debugPrint(e.toString());
    }
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
