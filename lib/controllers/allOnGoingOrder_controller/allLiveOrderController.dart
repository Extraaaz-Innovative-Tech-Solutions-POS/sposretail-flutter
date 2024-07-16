import 'package:spos_retail/model/AllLiveOrder/allLiveOrderModel.dart';
import 'package:spos_retail/views/widgets/export.dart';

class AllLiveOrderController extends GetxController {
  List<AllLiveOrderModel> allLiveOrder = [];
  Future<void> fetchallLiveOrder() async {
    try {
      final response = await DioServices.get(AppConstant.onGoingOrder);
      print(response.data['data']);
      if (response.statusCode == 200) {
        allLiveOrder = (response.data['data'] as List)
            .map<AllLiveOrderModel>((json) => AllLiveOrderModel.fromJson(json))
            .toList();

        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
