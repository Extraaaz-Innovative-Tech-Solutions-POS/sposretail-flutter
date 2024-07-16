import '../../views/widgets/export.dart';

class GetModifierGroupController extends GetxController {
  List<GetModifierGroupData> getModifierList = [];
  Future<void> getModifierGroup() async {
    final response = await DioServices.get(AppConstant.modifier);
    if (response.statusCode == 200) {
      getModifierList = response.data['data']
          .map<GetModifierGroupData>(
              (json) => GetModifierGroupData.fromJson(json))
          .toList();
     // print(response.data);
      update();
    }
  }
}
