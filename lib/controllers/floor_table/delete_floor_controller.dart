

import '../../views/widgets/export.dart';

class DeleteFloorController extends GetxController {
  final FloorController _floorController = FloorController();
  Future<void> deleteFloor(String floorid) async {
    try {
      final response = await DioServices.delete("floor/$floorid");
      if (response.statusCode == 200) {
        _floorController.fetchAllFloor(null);
        update();
        snackBar("Success", "Floor is Deleted Successfully");
      }
    } catch (e) {
      print('Unsuccessful $e');
    }
  }
}
