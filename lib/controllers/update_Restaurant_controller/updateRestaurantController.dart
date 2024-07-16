import 'package:spos_retail/constants/app_constant.dart';
import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

class UpdateRestaurantController extends GetxController {
  Future<void> updaterestaurantController(
      String restaurant_name, String address, String state, int id) async {
    UpdateRestaurant updateRestaurant = UpdateRestaurant(
        restaurant_name: restaurant_name, address: address, state: state);
    var response = await DioServices.put(
        "${AppConstant.updateRestaurantAPI}/${id.toString()}",
        updateRestaurant.toJson());
    if (response.statusCode == 201) {
      // print(response.data);
      snackBar("Success", "Your Restaurant Update Successfully");
      Get.back();
      update();
    }
  }
}
