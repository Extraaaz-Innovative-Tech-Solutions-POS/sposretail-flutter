import 'package:get/get.dart';
import 'package:spos_retail/model/running_kot.dart';
import 'package:spos_retail/views/widgets/export.dart';

class KitchenController extends GetxController {
  List<RunningKot> kot = [];
  var currentFloor = 0;
  bool pendingExpansion = false;
  bool completedExpansion = false;

  void setPendingExpansion(bool value) {
    pendingExpansion = value;
    update();
  }

  void setCompletedExpansion(bool value) {
    completedExpansion = value;
    update();
  }

  Map<String, List<RunningKot>> segregateListByStatus(List<RunningKot> list) {
    Map<String, List<RunningKot>> segregatedLists = {};

    for (var runningKot in list) {
      if (!segregatedLists.containsKey(runningKot.status)) {
        segregatedLists[runningKot.status] = [];
      }
      segregatedLists[runningKot.status]!.add(runningKot);
    }

    return segregatedLists;
  }

  // Future<void> fetchRunningKot() async {
  //   try {
  //     final response = await DioServices.get(getrunningkot);

  //     if (response.statusCode == 200) {
  //       List<RunningKot> kitchenDataList = (response.data as List)
  //           .map<RunningKot>((json) => RunningKot.fromJson(json))
  //           .toList();

  //       kot = kitchenDataList;
  //       debugPrint("Fetched floor data: $kot");
  //       Map<String, List<RunningKot>> segregatedLists =
  //           segregateListByStatus(kot);
  //       segregatedLists.forEach((status, list) {
  //         debugPrint("List for status $status: $list");
  //       });
  //       Get.to(KitchenDashboard(
  //         segregatedLists: segregatedLists,
  //       ));
  //     } else {
  //       debugPrint("Error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     debugPrint("Error during HTTP request: $e");
  //   }
  // }
}
