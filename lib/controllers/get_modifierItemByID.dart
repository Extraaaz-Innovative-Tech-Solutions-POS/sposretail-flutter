import 'package:spos_retail/model/varient_model.dart';
import '../views/widgets/export.dart';

class GetModifierItemById extends GetxController {
  List<VarientModel> menu = [];
  List<Modifier> items = [];
  RxBool checkedthelist = false.obs;
  var modifiersGroupID;
  Future<void> fetchModifierById(String id) async {
    final response =
        await DioServices.get("${AppConstant.orderbookingmodifiers}/$id");
    try {
      if (response.statusCode == 200) {
        final data = response.data["modifierGroups"][0]['modifiers'];
        modifiersGroupID = response.data["modifierGroups"][0]['id'].toString();
        items.clear();

        data.forEach((el) {
          Modifier varientModelData = Modifier.fromJson(el);
          items.add(varientModelData);
          checkedthelist = true.obs;
          print(response.data['modifierGroups']);
          // print(el);
          update();
        });

        // menu = response.data['data']
        //     .map<VarientModel>((json) => VarientModel.fromJson(json))
        //     .toList();
        // items = [];
        // items.addAll(menu);

        //   update();

        // update();
      } else {
        print("Error im form emnu: ${response.statusCode}");
      }
    } catch (error) {
      items = [];
      checkedthelist = false.obs;
      update();
      print("Exception: $error");
    }
  }
}
