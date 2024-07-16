import 'package:spos_retail/views/widgets/export.dart';

class FloorController extends GetxController {
  List<Tables> floor = [];
  List<Map<String, dynamic>> dropdownFloorSectionList = [];
  RxList<FloorSectionList> floorSectionList = <FloorSectionList>[].obs;
  RxList<FetchFloor> fetchedfloor = <FetchFloor>[].obs;
  Tables? currentFloor;
  RxInt existingFloor = 0.obs;
  RxBool requestinProgess = false.obs;
  RxBool requestsentSucessfully = false.obs;

  final count = RxInt(0);
  final List<String> griditem = [];

  void setcurrentfloor(Tables floor) {
    currentFloor = floor;
    update();
  }

  void fetchFloorTable(bool dine, String type) async {
    try {
      final response = await DioServices.get(AppConstant.floorTables);

      if (response.statusCode == 200) {
        floor = [];
        List<Tables> floorDataList = response.data["tables"]
            .map<Tables>((json) => Tables.fromJson(json))
            .toList();
        floor = floorDataList;
        requestsentSucessfully = true.obs;

        update();

        if (dine) {
          if (type == "Take Away") {
            Get.to(() => OrderBookingScreen(
                  ordertype: type,
                ));
          } else {
            Get.to(() => OrderBookingScreen(
                  ordertype: type,
                ));
          }
        }
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (error) {
      update();
    } finally {
      requestinProgess = false.obs;
    }
  }

  fetchAllFloor(bool? floor) async {
    // If a request is in progress or has already been successful, do not send another request
    // if (requestsentSucessfully.isTrue || requestinProgess.isTrue) {
    //   snackBar("Please Wait", "Request in progress or already successful");

    //   return;
    // }

    requestinProgess.value = true;
    update();

    try {
      final response = await DioServices.get(AppConstant.getAllFloor);
      if (response.statusCode == 200) {
        // Parse the response and update the floorSectionList
        floorSectionList.assignAll((response.data['data'] as List)
            .map<FloorSectionList>((json) => FloorSectionList.fromJson(json))
            .toList());

        requestsentSucessfully.value = true;
        update();

        // Clear and update the dropdownFloorSectionList
        dropdownFloorSectionList.clear();
        for (int index = 0; index < floorSectionList.length; index++) {
          dropdownFloorSectionList.add({
            'floorName': floorSectionList[index].floorName,
            'id': floorSectionList[index].id,
            'index': index,
          });
        }

        // Navigate based on the floor parameter
        if (floor == true) {
          Get.to(const FloorSectionTable());
        } else if (floor == false) {
          Get.to(AddFloorSection());
        } else {
          Get.to(const DeleteFloor());
        }
      }
    } catch (e) {
      // Handle the error by resetting the requestsentSucessfully flag to allow retries
      requestsentSucessfully.value = false;
      debugPrint(e.toString());
    } finally {
      // Reset the requestinProgess flag to allow new requests if necessary
      requestinProgess.value = false;
    }
  }

  addFloor(floor) async {
    try {
      final response = await DioServices.postRequest(AppConstant.getAllFloor, {
        "floor_name": floor,
      });
      if (response.statusCode == 200) {
        snackBar("Success", response.data["message"]);
        Get.to(BottomNav());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  fetchExistingFloor() async {
    try {
      final response = await DioServices.get(AppConstant.getExistingFloor);
      if (response.statusCode == 200) {
        fetchedfloor.assignAll((response.data['data'])
            .map<FetchFloor>((json) => FetchFloor.fromJson(json)));
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateFloor(int floor) async {
    try {
      final response = await DioServices.postRequest(
        "floor",
        {"floor_name": floor},
      );
      if (response.statusCode == 200) {
        fetchFloorTable(false, "");
      } else if (response.statusCode == 201) {
        // Handle other status codes if needed
        fetchFloorTable(false, "");
      } else {
        debugPrint("Unexpected response: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error updating floor: $error");
    }
  }
}
