// //import 'package:spos_retail/views/widgets/export.dart';
// import 'package:get/get.dart';
// import 'package:spos_retail/model/order_request_model.dart';

// class SqftController extends GetxController {
//   RxList<Item> itemList = <Item>[].obs;
//    void toggleLength(v, i) {
//       itemList[i].length = v;
//    // sqftLength.value = v;
//    // print("SQFT : ------------------ Length $sqftLength + WIDTH $sqftWidth + SQ: $sqft");
//     update();
//   }

//   void toggleWidth(v, i) {
//     itemList[i].length.value = v;
//    // sqftWidth.value = v;
//     toggleSqft(i);
//     print("SQFT : ------------------ Length ${itemList[i].length} + WIDTH ${itemList[i].width} + SQ: ${itemList[i].sqft}");
//     update();
//   }

//   void toggleSqft(i) {
//     itemList[i].sqft.value = itemList[i].length.value * itemList[i].width.value ;
//     update();
//   }

// }