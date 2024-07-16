import 'package:spos_retail/views/widgets/export.dart';

class AllItemsController extends GetxController {
  List<CategoryModel> menu = [];
  List<ItemModel> items = [];
  // List<Modifiers> modifiersItem = [];
  Future<void> fetchMenu(sectionId) async {
    try {
      final response = await DioServices.get(
          "${AppConstant.item}?section_id=${sectionId ?? ""}");

      if (response.statusCode == 200) {
        menu = response.data['data']
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
        //log(response.data['data'].toString());
        update();
      } else {
        print("Error im form emnu: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    }
  }

  void getItemByCategory(int catId) {
    items = [];
    for (var cat in menu) {
      if (cat.categoryId.toString() == catId.toString()) {
        items = cat.items!;
      }
    }
    update();
  }
}
