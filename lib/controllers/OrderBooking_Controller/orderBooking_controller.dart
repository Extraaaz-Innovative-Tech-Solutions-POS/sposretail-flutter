// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:spos_retail/views/widgets/export.dart';
import '../../model/PrinterModel/kot_desktopModel.dart';
import '../../model/common_model.dart';

class OrderBookingController extends GetxController {
  final printerController = Get.put(PrinterController());
  final desktopPrinterController = Get.put(DesktopPrinterController());
  final cartController = Get.put(CartController());
  var printername, inchestype;
  DateTime invoiceDate = DateTime.now();
  @override
  void onInit() {
    super.onInit(); // Don't forget to call super.onInit()
    sharedPrefrence();
  }

  Future<void> sharedPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    printername = pref.getString("BillingPrinter");
    inchestype = pref.getInt("InchesType");
    // kotprinterName = pref.getString("KOTBillingPrinter");
    update();
  }

  Future<void> confirmOrderBtnTap(
      int? customerID,
      List<Item> items,
      String? tableId,
      String orderType,
      int table,
      int floor,
      String? sectionId,
      var takeAwayIDs,
      var dineTableID,
      var deliveryID,
      var advanceId,
      bool? kotBoolChecking,
      BuildContext context,
      {String? dateTime}) async {
    if (tableId != null) {
      AddItemOrder orders = AddItemOrder(
          customerId: customerID ?? 0,
          items: items,
          tableID: tableId,
          orderType: orderType,
          advanceDateTime: dateTime);

      if (kotBoolChecking == true) {
        final response =
            await DioServices.postRequest("add-item", orders.toJson());
        if (printername == null) {
          try {
            Get.put(CartController()).getTakewaRunningOrder();
            if (orderType == "Dine") {
              snackBar(
                  "${response.data['success']}", "${response.data['message']}");
              Get.to(() => BottomNav());
            }
          } catch (e) {
            print(e.toString());
          }
        } else {
          String itemsString = items.map((element) => element.name).join('/');
          String itemsQuantity =
              items.map((element) => element.quantity.toString()).join('/');

          if (Responsive.isDesktop(context)) {
            var formData = KotDesktopModel(
                printerNames: printername.toString(),
                tableNo: orderType == "Dine" ? "Dine" : "Take Away",
                items: itemsString,
                qty: itemsQuantity,
                billType: "0",
                dateTime: formatDateTime(invoiceDate),
                is3T: inchestype != null ? inchestype.toString() : "0",
                kotNo: "6");
            desktopPrinterController.kotPrinterPost(formData);
          } else {
            var formData = KOTPrinterModel(
                printerNames: printername,
                billNo: "101",
                tableNo: orderType == "Dine" ? table.toString() : "Take Away",
                items: itemsString,
                qty: itemsQuantity,
                billType: '0',
                dateTime: formatDateTime(invoiceDate),
                ipAddress: '192.168.1.100',
                is3T: inchestype != null ? inchestype.toString() : "0",
                kotNo: '6',
                iN: '0');
            printerController.kotPrinterPost(formData);
          }

          Get.put(CartController()).getTakewaRunningOrder();
          if (orderType == "Dine") {
            snackBar(
                "${response.data['success']}", "${response.data['message']}");
            Get.to(() => BottomNav());
          }
        }
      } else {
        try {
          final response =
              await DioServices.postRequest("add-item", orders.toJson());
          Get.put(CartController()).getTakewaRunningOrder();
          if (orderType == "Dine") {
            snackBar(
                "${response.data['success']}", "${response.data['message']}");
            Get.to(() => BottomNav());
          }
        } catch (e) {
          print(e.toString());
        }
      }
    } else {
      OrderRequest orders = OrderRequest(
          customerId: customerID ?? 0,
          floor: orderType == "Dine" ? floor.toString() : null,
          table: orderType == "Dine" ? table.toString() : null,
          items: items,
          tableID: orderType == "Dine"
              ? dineTableID
              : orderType == "Delivery"
                  ? deliveryID
                  : orderType == "Advance"
                      ? advanceId
                      : takeAwayIDs,
          section_id: orderType == "Dine" ? int.parse(sectionId.toString()) : 0,
          orderType: orderType,
          sub_table: 0,
          table_divided_by: 0,
          datetime: orderType == "Advance" ? dateTime : null);

      update();

      try {
        final response =
            await DioServices.postRequest(AppConstant.cart, orders.toJson());
        handlePostRequestResponse(
            response,
            kotBoolChecking ?? false,
            printername,
            context,
            orderType,
            items,
            orders,
            orderType == "Dine"
                ? dineTableID
                : orderType == "Delivery"
                    ? deliveryID
                    : orderType == "Advance"
                        ? advanceId
                        : takeAwayIDs,
            table,
            floor,
            response.data['order_number']);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  String getTableID(String orderType, var dineTableID, var deliveryID,
      var advanceId, var takeAwayIDs) {
    switch (orderType) {
      case "Dine":
        return dineTableID;
      case "Delivery":
        return deliveryID;
      case "Advance":
        return advanceId;
      default:
        return takeAwayIDs;
    }
  }

  void handlePostRequestResponse(
      response,
      bool kotBoolChecking,
      printername,
      context,
      String orderType,
      List<Item> items,
      OrderRequest orders,
      var takeAwayIDs,
      var table,
      var floor,
      var kotNo) async {
    // takeAwayIDs =

    if (kotBoolChecking) {
      if (printername == null) {
        await generateAndNavigate(
            orderType, response, items, table, floor, orders, takeAwayIDs);
      } else {
        await handlePrinting(context, printername, orderType, response, items,
            orders, table, floor, takeAwayIDs, kotNo);
      }
    } else {
      navigateBasedOnOrderType(orderType, response, orders, takeAwayIDs, items);
    }
  }

  Future<void> generateAndNavigate(String orderType, response, List<Item> items,
      var table, var floor, OrderRequest orders, String takeAwayIDs) async {
    final invoicePDF = generatekotpdf(
      orderType: orderType,
      orderId: "2",
      kotId: items,
      date: DateTime.now(),
      table: table,
      floor: floor,
      orders: items, //widget.orderedItems
      rebuildStatus: false,
    );
    await Printing.layoutPdf(
      onLayout: (format) {
        return Future(() => invoicePDF);
      },
      format: PdfPageFormat.roll57,
      name:
          "${invoiceDate.day}-${invoiceDate.month}${invoiceDate.year}Time:- ${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
    );
    navigateBasedOnOrderType(orderType, response, orders, takeAwayIDs, items);
  }

  Future<void> handlePrinting(
      context,
      String printername,
      String orderType,
      response,
      List<Item> items,
      OrderRequest orders,
      var table,
      var floor,
      var takeAwayIDs,
      var kotNo) async {
    String itemsString = items.map((element) => element.name).join('/');
    String itemsQuantity =
        items.map((element) => element.quantity.toString()).join('/');

    if (Responsive.isDesktop(context)) {
      var formData = KotDesktopModel(
        printerNames: printername.toString(),
        tableNo: orderType == "Dine" ? orders.table.toString() : "Take Away",
        items: itemsString,
        qty: itemsQuantity,
        billType: '0',
        dateTime: formatDateTime(invoiceDate),
        is3T: inchestype != null ? inchestype.toString() : "0",
        kotNo: kotNo.toString(),
      );
      desktopPrinterController.kotPrinterPost(formData);
    } else {
      var formData = KOTPrinterModel(
        printerNames: printername.toString(),
        billNo: "101",
        tableNo: orderType == "Dine" ? orders.table.toString() : "Take Away",
        items: itemsString,
        qty: itemsQuantity,
        billType: '0',
        dateTime: formatDateTime(invoiceDate),
        ipAddress: '192.168.1.100',
        is3T: inchestype != null ? inchestype.toString() : "0",
        kotNo: kotNo.toString(),
        iN: '0',
      );
      printerController.kotPrinterPost(formData);
    }

    navigateBasedOnOrderType(orderType, response, orders, takeAwayIDs, items);
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  void navigateBasedOnOrderType(String orderType, response, OrderRequest orders,
      var takeAwayIDs, List<Item> items) {
    switch (orderType) {
      case "Dine":
        snackBar("${response.data['success']}", "${response.data['message']}");
        Get.to(() => BottomNav());
        break;
      case "Delivery":
        Get.to(() => PendingOrderUI(advance: false, catering: false));
        break;
      case "Advance":
        Get.to(() => const PendingAdvanceOrder());
        break;
      default:
        Get.to(() => ShowOngoingOrder(
              ordertype: orderType,
              tableId: takeAwayIDs,
              orderData: orders.toJson(),
              items: items,
            ));
        break;
    }
  }
}
