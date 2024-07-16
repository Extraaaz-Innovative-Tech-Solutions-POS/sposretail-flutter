// import 'package:get/get.dart';
// import 'package:spos_retail/constants/constant.dart';

// import '../model/Pending orders/advance_pending_order.dart';
// import '../services/dio_services.dart';


// class PendingOrderController extends GetxController {
//   List<AdvancePendingOrder> pendingAdvanceOrderList = [];
//   Future<void> advancedPendingOrder() async {
//     try {
//       var response = await DioServices.get(advanced);
//       pendingAdvanceOrderList.assignAll((response.data['data'] as List)
//           .map((orderJson) => AdvancePendingOrder.fromJson(orderJson)));
//       update();
//     } catch (e) {
//       print(e);
//     }
//   }
// }