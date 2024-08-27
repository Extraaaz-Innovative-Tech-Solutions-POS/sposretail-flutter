import '../../views/widgets/export.dart';

class StockController extends GetxController{
  RxString thresholdValue = "".obs;


  Future<void> setThreshold(id) async {
    try {
      final response = await DioServices.postRequest(AppConstant.setThreshold,
          {"ingredient_id": id, "threshold_value": thresholdValue.value});
      if (response.statusCode == 200) {
        print("SET THRESHOLD -------------------------------------->");
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }


}