
import 'package:spos_retail/model/common_model.dart';

import '../../model/Inventory/view_statement.dart';
import '../../views/widgets/export.dart';

class SupplierController extends GetxController {
  RxList<SupplierData> supplierListdata = <SupplierData>[].obs;
  List<Map<String, dynamic>> dropdownSupplierId = [];
  RxInt supplierId = 0.obs;
  RxString supplierName = "".obs;
  RxString supplierMobile = "".obs;
  RxString supplierGstin = "".obs;
  RxString supplierAddress = "".obs;
  RxString supplierPerson = "".obs;
  RxString supplierNumber = "".obs;
  

  RxList<ViewStatementData> viewStatementList = <ViewStatementData>[].obs;

  Future<void> addSupplier(context) async {
    AddSupplierData data = AddSupplierData(
        name: supplierName.value,
        mobileNumber: supplierMobile.value,
        gstin: supplierGstin.value,
        c_person: supplierPerson.value,
        c_number: supplierNumber.value);
    if (supplierName.value.isNotEmpty &&
        supplierMobile.value.isNotEmpty &&
        supplierAddress.value.isNotEmpty &&
        supplierGstin.value.isNotEmpty &&
        supplierPerson.value.isNotEmpty &&
        supplierNumber.value.isNotEmpty) {
      try {
        final response = await DioServices.postRequest(
            AppConstant.createSupplier, data.toJson());
        print(response.data);
        print(response.statusMessage);
        if (response.statusCode == 200) {
           supplierName.value ='';
           supplierMobile.value ='';
           supplierGstin.value ='';
           supplierAddress.value ='';
           supplierPerson.value ='';
            supplierNumber.value ='';
          snackBar("Success", "Supplier Added Successfully");
          Get.off(const SupplierUI());
          getSupplier();
        }
      } catch (e) {
        print(e);
      }
    } else {
      snackBarBottom("Error", "Enter the required field", context);
    }
  }


    Future<void> updateSupplier(context, i) async {
    AddSupplierData data = AddSupplierData(
        name: supplierName.value,
        mobileNumber: supplierMobile.value,
        gstin: supplierGstin.value,
        c_person: supplierPerson.value,
        c_number: supplierNumber.value);
    if (supplierName.value.isNotEmpty &&
        supplierMobile.value.isNotEmpty &&
        supplierAddress.value.isNotEmpty &&
        supplierGstin.value.isNotEmpty &&
        supplierPerson.value.isNotEmpty &&
        supplierNumber.value.isNotEmpty) {
      try {
        final response = await DioServices.put(
            "${AppConstant.suppliers}/$i", data.toJson());
        print(response.data);
        print(response.statusMessage);
        if (response.statusCode == 200) {
            supplierName.value ='';
           supplierMobile.value ='';
           supplierGstin.value ='';
           supplierAddress.value ='';
           supplierPerson.value ='';
            supplierNumber.value ='';
          snackBar("Success", "Supplier Update Successfully");
          // Get.off(const InventoryList());
            Get.off(const SupplierUI());
          getSupplier();
        }
      } catch (e) {
        print(e);
      }
    } else {
      snackBarBottom("Error", "Enter the required field", context);
    }
  }

  Future<void> getSupplier() async {
    final response = await DioServices.get(AppConstant.getSupplier);
    print(response.statusMessage);
    try {
      final response = await DioServices.get(AppConstant.getSupplier);
      if (response.statusCode == 200) {
        print(response.data);

        supplierListdata.assignAll((response.data['data'])
            .map<SupplierData>((json) => SupplierData.fromJson(json)));

        dropdownSupplierId.clear();
        for (int indexs = 0; indexs < supplierListdata.length; indexs++) {
          dropdownSupplierId.add({
            'name': supplierListdata[indexs].name,
            'id': supplierListdata[indexs].id,
            "index": indexs
          });
        }

        update();
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }



    void getSupplierById(int id){
     try {
      //  Find the supplier by id in the supplierList
      SupplierData supplier = supplierListdata.firstWhere((supplier) => supplier.id == id);
      print("supplier testing : ${supplier.address}");
      // Update supplier data
      supplierName.value = supplier.name!;
      supplierMobile.value = supplier.mobile!;
      supplierGstin.value = supplier.gstin!;
      supplierAddress.value = supplier.address;
      supplierPerson.value = supplier.cPerson!;
      supplierNumber.value = supplier.cNumber!;

    } catch (e) {
      print("Supplier with id $id not found");
    }
  }

  Future<void> deleteSuppliers(i) async {
    try {
      final response = await DioServices.delete("${AppConstant.suppliers}/$i");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Delete Successfully");
        getSupplier();
        update();
      }
      else {
        Fluttertoast.showToast(msg: "Failed to Delete");
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
