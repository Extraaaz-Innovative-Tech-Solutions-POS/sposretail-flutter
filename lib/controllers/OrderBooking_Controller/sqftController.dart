//import 'package:spos_retail/views/widgets/export.dart';
import 'package:get/get.dart';
import 'package:spos_retail/model/order_request_model.dart';

class SqftController extends GetxController {
  RxList<Item> itemList = <Item>[].obs;
   RxInt sqftLength = 0.obs;
  RxInt sqftWidth = 0.obs;
   void toggleLength(v) {
      //itemList[i].length = v;
   sqftLength.value = v;
   print("SQFT : ------------------ Length $sqftLength + WIDTH $sqftWidth ");
    update();
  }

  void toggleWidth(v, i) {
   // itemList[i].length.value = v;
    sqftWidth.value = v;
    toggleSqft(i);
     print("SQFT : ------------------ Length $sqftLength + WIDTH $sqftWidth + SQ: ${itemList[i].sqft}");
  //  print("SQFT : ------------------ Length ${itemList[i].length} + WIDTH ${itemList[i].width} + SQ: ${itemList[i].sqft}");
    update();
  }

  void toggleSqft(i) {
    itemList[i].sqft = sqftLength.value * sqftWidth.value ;
    itemList.refresh();
    update();
  }

}