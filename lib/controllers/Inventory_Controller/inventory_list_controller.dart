import 'package:spos_retail/model/Inventory/inventory_list_modal.dart' as il;
import '../../views/widgets/export.dart';

class InventoryListController extends GetxController {
  RxList<il.InventoryList> inventoryListData = <il.InventoryList>[].obs;

  fetchInventoryList() async {
    try {
      final response = await DioServices.get(AppConstant.inventoryList);
      if (response.statusCode == 200) {
        print(response.toString());
        inventoryListData = response.data["data"]
            .map<Tables>((json) => Tables.fromJson(json))
            .toList();
      }
    } catch (e) {}
  }
}
