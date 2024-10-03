import 'dart:io';

import 'package:spos_retail/controllers/settings_controller.dart';
import 'package:spos_retail/model/cart_respose_model.dart';
import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

class CartController extends GetxController {
  List<Items> orderedItems = [];

  Rx<Kot?> cartOrder = Rx<Kot?>(null);
  RxBool successful = false.obs;
  RxBool completingOrder = false.obs;
  RxString phone = "".obs;
  var ordernumber, printername;

  RxList<TakeAwayOrder> takewayorders = <TakeAwayOrder>[].obs;
  final user = Get.put(UserController());
  final settingsController = Get.put(SettingsController());
  List<Kot> kot = [];

  Future<void> getCartResponse(int floor, int table, String tableId) async {
    try {
      final response = await DioServices.get(
        "getOrdersBill?table_id=$tableId",
      );
      if (response.statusCode == 200) {
        orderedItems.clear();
        cartOrder.value = Kot.fromJson(response.data['kot']);
        orderedItems.assignAll(cartOrder.value!.items!);
        ordernumber = response.data['kot']['order_number'];
        successful.value = true;
        update();
      } else {
        successful.value = true;
        orderedItems.clear();
      }
    } catch (e) {
      successful.value = false;
      orderedItems.clear();
      snackBar("Error", e.toString());
    } finally {
      update();
    }
  }

  DateTime invoiceDate = DateTime.now();

  Future<void> completeBilling(
      String orderType,
      String invoicedata,
      var discount,
      var totalAmount,
      var remainingAmount,
      var moneytoPay,
      bool fullpayment,
      BuildContext context,
      List<Items> order,
      {bool cashier = false,
      var customeraddress,
      var customername,
      var customerphone,
      var thaliPrice,
      var numberOfthali,
      var datetime,
      var sgst,
      statusclick,
      var cgst}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      printername = pref.getString("BillingPrinter");

      Future<void> _statusbool() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        statusclick = prefs.getBool("CustomerDetailsBool");

        update();
      }

      print("testing customer details :$customername");

      if (Responsive.isDesktop(context)) {
        final desktopInvoicePdf = DesktopInvoicePdf();
        final invoicePDF = await desktopInvoicePdf.generateBillingPdf(
            orders: orderedItems,
            invoiceId: invoicedata.toString(),
            invoiceID: invoicedata.toString(),
            discount: discount,
            remainingAmount: remainingAmount,
            ordertype: orderType,
            totalAmount: totalAmount ?? "0",
            moneytoPay: moneytoPay ?? "0",
            fullpayment: fullpayment,
            customerAddress: customeraddress,
            customerName: customername,
            customerPhone: customerphone,
            thaliprice: thaliPrice,
            numberOfThali: numberOfthali,
            datetime: datetime);

        // sendPDFToAPI(invoicePDF, printername);

        final output = await getTemporaryDirectory();
        final Uint8List pdfBytes = invoicePDF;
        final file = File('${output.path}/invoice.pdf');
        await file.writeAsBytes(pdfBytes);
        final xFile = XFile(file.path);

        _statusbool().whenComplete(() {
          if (statusclick == true && settingsController.whatsappBilling.value) {
            print("PHONE NUMBER : --------------------- +91${phone.value}");
            shareWhatsapp.shareFile(phone: "+91${phone.value}", xFile, type: settingsController.whatsappPersonal ? WhatsApp.standard: WhatsApp.business);
          }
        });

        Get.to(BottomNav());
      } else {
        final invoicePDF = InvoicePdf.generateBillingPdf(
            orders:  orderedItems,
            invoiceId: invoicedata.toString(),
            invoiceID: invoicedata.toString(),
            discount: double.parse(discount.toString()),
            remainingAmount: remainingAmount,
            ordertype: orderType,
            totalAmount: totalAmount ?? "0",
            moneytoPay: moneytoPay ?? "0",
            fullpayment: fullpayment,
            customerAddress: customeraddress,
            customerName: customername,
            customerPhone: customerphone);

        settingsController.printPreview.value
            ? await Printing.layoutPdf(
                onLayout: (format) {
                  return Future(() => invoicePDF);
                },
                format: PdfPageFormat.roll57,
                name:
                    "${invoiceDate.year}${invoiceDate.month}${invoiceDate.day}${invoiceDate.hour}${invoiceDate.minute}${invoiceDate.second}${invoiceDate.millisecond}",
              )
            : null;
        Get.to(BottomNav());

        // Future<String> savePDFToFile(Uint8List uint8List) async {
        //   final output = await getTemporaryDirectory();
        //   final file = File('${output.path}/example.pdf');
        //   await file.writeAsBytes(uint8List);

        //   return file.path;
        // }
        print(
            "CUSTOMER NAME billlllllllllllll --------------------------> $customername");

        final output = await getTemporaryDirectory();
        final Uint8List pdfBytes = await invoicePDF;
        final file = File('${output.path}/invoice.pdf');
        await file.writeAsBytes(pdfBytes);
        final xFile = XFile(file.path);
        print("PHONE NUMBER : --------------------- +91${phone.value}");
        _statusbool().whenComplete(() {
          if (statusclick == true && settingsController.whatsappBilling.value) {
            print("PHONE NUMBER : --------------------- +91${phone.value}");
            shareWhatsapp.shareFile(phone: "+91${phone.value}", xFile, type: settingsController.whatsappPersonal ? WhatsApp.standard: WhatsApp.business);
          }
        });
      }
    } catch (e) {
      successful.value = false;

      snackBar("Error", e.toString());
    } finally {
      completingOrder.value = false; // Reset loading state
      update();
    }
  }

  // void sendPDFToAPI(Uint8List pdfFile, String printername) async {
  //   print(
  //       'PDF file size: ${pdfFile.length} bytes'); // Check the size of the PDF file

  //   // Create a temporary file for debugging
  //   File tempFile = await File('temp.pdf').writeAsBytes(pdfFile);
  //   print(
  //       'Temp file path: ${tempFile.path}'); // Check the path of the temporary file

  //   try {
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('http://localhost:2001/print'),
  //     );
  //     request.fields.addAll({'printerNames': printername});
  //     request.files.add(http.MultipartFile.fromBytes(
  //       'pdfFile',
  //       pdfFile,
  //       filename: 'report.pdf', // Provide a filename for the PDF
  //       contentType: MediaType('application', 'pdf'),
  //     ));

  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       print(await response.stream.bytesToString());
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error sending file: $e');
  //   }
  // }

  Future<void> getTakewaRunningOrder() async {
    try {
      final response = await DioServices.get("getTakeaway");

      if (response.statusCode == 200) {
        takewayorders.assignAll((response.data as List)
            .map((orderJson) => TakeAwayOrder.fromJson(orderJson)));

        update();
      }
    } catch (error) {}
  }

  Future<void> getTakeAwayResponse(String id) async {
    try {
      final response = await DioServices.get(
        "getOrdersBill?table_id=$id",
      );

      if (response.statusCode == 200) {
        orderedItems.clear();
        cartOrder.value = Kot.fromJson(response.data["kot"]);
        ordernumber = response.data['kot']['order_number'];
        orderedItems.assignAll(cartOrder.value!.items!);
        successful.value = true;
        update();
      } else {
        successful.value = true;
        orderedItems.clear();
      }
    } catch (e) {
      successful.value = false;
      orderedItems.clear();
      snackBar("Error", e.toString());
    } finally {
      update();
    }
  }

  Future<void> updateBillQuantity(
      String tableId, String itemId, String quantity) async {
    UpdateQuantity updateQuantitydata =
        UpdateQuantity(tableId: tableId, itemId: itemId, quantity: quantity);
    try {
      final response =
          await DioServices.postRequest(updateQuantity, updateQuantitydata);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Quantity Updated Sucessfully");
      }
    } catch (e) {
      print(e);
    }
  }
}
