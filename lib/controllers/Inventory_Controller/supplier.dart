import 'package:spos_retail/model/Inventory/get_inventory.dart';
import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

import '../../model/Inventory/view_Statement.dart';

class SupplierController extends GetxController {
  List<GetSupplierInventory> getInventory = [];
  RxList<ViewStatementData> viewStatementList = <ViewStatementData>[].obs;

  Future<void> addSupplier(String name, String mobileno, String gstin,
      String cPerson, String cNumber) async {
    AddSupplier data = AddSupplier(
        name: name,
        mobileNumber: mobileno,
        gstin: gstin,
        c_person: cPerson,
        c_number: cNumber);
    try {
      final response = await DioServices.postRequest(
          AppConstant.createSupplier, data.toJson());
      if (response.statusCode == 200) {
        Get.back();
        getSupplier();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSupplier() async {
    final response = await DioServices.get(AppConstant.getSupplier);
    try {
      final response = await DioServices.get(AppConstant.getSupplier);
      if (response.statusCode == 200) {
        getInventory = response.data['data']
            .map<GetSupplierInventory>(
                (json) => GetSupplierInventory.fromJson(json))
            .toList();

        update();
      }
    } catch (e) {
      // print("Data----------->");
      print(e);
    }
  }

  Future<void> deleteSuppliers(int i) async {
    try {
      final response = await DioServices.delete("${AppConstant.suppliers}/$i");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Delete Successfully");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> viewStatement(int id) async {
    try {
      final response =
          await DioServices.get("${AppConstant.viewStatement}/$id");
      if (response.statusCode == 200) {
        viewStatementList.assignAll((response.data as List)
            .map((orderJson) => ViewStatementData.fromJson(orderJson)));
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
