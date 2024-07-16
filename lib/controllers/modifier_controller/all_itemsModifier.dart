import 'package:spos_retail/views/widgets/export.dart';

class AllModifierListController extends GetxController {
  List<Data> modifierAllItemsList = [];
  Future<void> getAllModifierList() async {
    final response = await DioServices.get(AppConstant.addmodifiers);
    if (response.statusCode == 200) {
      modifierAllItemsList = response.data['data']
          .map<Data>((json) => Data.fromJson(json))
          .toList();
      update();
    }
  }
}
