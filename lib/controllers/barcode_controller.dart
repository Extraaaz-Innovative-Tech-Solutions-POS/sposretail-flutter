import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:spos_retail/views/widgets/export.dart';

class BarcodeController extends GetxController {

 RxString scanBarcode = "".obs;


 RxString name ="".obs;
 RxString price ="".obs;



  void updateName(String newName) {
    name.value = newName;
  }

  void updatePrice(String newPrice) {
    price.value = newPrice;
  }

  String get qrData => '${name.value}, Price: ${price.value}';




  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
   // if (!mounted) return;

      scanBarcode.value = barcodeScanRes;
      update();
  }

}