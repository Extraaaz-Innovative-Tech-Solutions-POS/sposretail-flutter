import 'package:spos_retail/views/widgets/export.dart';

class GraphController extends GetxController {
  RxList<Graph> graphList = <Graph>[].obs;
  getGraph(from, to, orderType) async {
    try {
      final response = await DioServices.get(AppConstant.graph,
          queryParameters: {
            "fromDate": from,
            "toDate": to,
            "order_type": orderType
          });
      if (response.statusCode == 200) {
        graphList.assignAll((response.data['result'])
            .map<Graph>((json) => Graph.fromJson(json)));
        update();
      }
    } catch (e) {}
  }
}
