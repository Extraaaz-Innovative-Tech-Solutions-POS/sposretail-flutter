import 'package:spos_retail/views/widgets/export.dart';

class SectionWisePricing extends GetxController {
  assignSectionWisePricing(itemId, sectionId, price) async {
    try {
      final response = await DioServices.postRequest(
        AppConstant.setsectionprice,
        {"item_id": itemId, "section_id": sectionId, "price": price},
      );
      if (response.statusCode == 200) {
        snackBar("Success", "Section Price Update Successfully");
        Get.back();
      }
      // print(response.data);
    } catch (e) {}
  }
}
