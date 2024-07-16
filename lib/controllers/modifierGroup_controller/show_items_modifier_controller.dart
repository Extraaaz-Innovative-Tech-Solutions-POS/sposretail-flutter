
import '../../model/common_model.dart';
import '../../views/widgets/export.dart';

class ShowModifierAndItemController extends GetxController {
  List<ShowItemsModifierData> showItemModifierList = [];
  List<ShowModifierData> showModifierList = [];
  List<ModifiersAll> selectModifierList = [];
  List<dynamic> listid = [];
  List<ItemsAll> selectItemsList = [];
  List<dynamic> itemlistid = [];

  //* For All the items----------->
  Future<void> getshowItemsModifier(String id) async {
    final response = await DioServices.get("${AppConstant.showModifierItems}/$id");
    if (response.statusCode == 200) {
      print("Your Called it show modifier------>");
      showItemModifierList = response.data['data']
          .map<ShowItemsModifierData>(
              (json) => ShowItemsModifierData.fromJson(json))
          .toList();
      update();
    }
  }

//* For all the Modifiers------------>
  Future<void> getshowModifiers(String id) async {
    final response = await DioServices.get("${AppConstant.showModifiers}/$id");
    if (response.statusCode == 200) {
      showModifierList = response.data['data']
          .map<ShowModifierData>((json) => ShowModifierData.fromJson(json))
          .toList();
      update();
    }
  }

//* To Select the Modifiers----------------->
  Future<void> getSelectModifiers(String id) async {
    final response = await DioServices.get("${AppConstant.selectModifiers}/$id");
    if (response.statusCode == 200) {
      selectModifierList = response.data['modifiersAll']
          .map<ModifiersAll>((json) => ModifiersAll.fromJson(json))
          .toList();
      listid = response.data['ids'];

      update();
    }
  }

//* To Saved the Modifiers------------->
  Future<void> postSaveModifiers(String id, List<int> listofid) async {
    SetModifiers modifiers = SetModifiers(id: listofid);
    final response = await DioServices.postRequest(
        "${AppConstant.saveModifiers}/$id", modifiers.toJson());
    if (response.statusCode == 200) {
      getshowModifiers(id);
      snackBar("Success", "Modifiers Saved Sucessfully");
      update();
    }
  }

  //* To Selects items------------->
  Future<void> getSelectItems(String id) async {
    final response = await DioServices.get("${AppConstant.selectItems}/$id");
    if (response.statusCode == 200) {
      selectItemsList = response.data['itemsAll']
          .map<ItemsAll>((json) => ItemsAll.fromJson(json))
          .toList();
      itemlistid = response.data['ids'];
      update();
      //  var id = response.data['ids'];
    }
  }

  //* Saved Items ---------------->
  Future<void> postSavedItems(String id, List<int> listofid) async {
    SetModifiers modifiers = SetModifiers(id: listofid);
    final response =
        await DioServices.postRequest("${AppConstant.saveItems}/$id", modifiers.toJson());
    if (response.statusCode == 200) {
      getshowItemsModifier(id);
      snackBar("Success", "Items Saved Sucessfully");
      update();
    }
  }
}
