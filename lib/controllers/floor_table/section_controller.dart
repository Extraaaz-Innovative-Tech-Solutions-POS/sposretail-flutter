import 'package:spos_retail/views/widgets/export.dart';

class SectionController extends GetxController {
  RxList<FetchSection> sectionList = <FetchSection>[].obs;
  List<Map<String, dynamic>> dropdownSectionList = [];
  RxList<TableSectionList> tableSectionList = <TableSectionList>[].obs;
  RxInt floorSectionCount = 0.obs;
  List<String> dropdownTableSectionlist = [];
  List<String> oldIndexId = [];
  bool sectionstable = false;
  int currentSection = 0;

  RxInt existingSection = 0.obs;

  addSection(name, id) async {
    final response = await DioServices.postRequest(
        AppConstant.sectionsUrl, {"name": name, "user_id": id});
    print(response);
    if (response.statusCode == 200) {
      snackBar("Success", "Section Added Successfully");
      fetchSection();
      Get.to(BottomNav());
    } else {
      snackBar("Error", "Failed to add Section");
    }
  }

  fetchSection() async {
    final response = await DioServices.get(AppConstant.sectionsUrl);

    if (response.statusCode == 200) {
      sectionList.assignAll((response.data['data'])
          .map<FetchSection>((json) => FetchSection.fromJson(json)));
      update();
      oldIndexId.clear();
      for (var element in sectionList) {
        oldIndexId.add(element.id);
      }
      dropdownSectionList.clear();

      for (int indexs = 0; indexs < sectionList.length; indexs++) {
        dropdownSectionList.add({
          'sectionName': sectionList[indexs].name,
          'id': sectionList[indexs].id,
          "index": indexs
        });
      }
    } else {
      snackBar("Error", "Failed to add Section");
    }
  }

  assignSectionTables(floorId, sectionId, tableCount) async {
    try {
      final response =
          await DioServices.postRequest(AppConstant.setSectionTables, {
        "floor_id": floorId, //1,
        "section_ids": sectionId, //[2, 1],
        "tables_counts": tableCount //[5, 3]
      });

      if (response.statusCode == 200) {
        snackBar("Success", "Sections Assigned Successfully");
      } else {
        snackBar("Failed", "Failed to add Sections");
      }
    } catch (e) {}
  }
}
