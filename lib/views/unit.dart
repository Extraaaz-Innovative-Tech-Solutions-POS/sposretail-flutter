
// // vichareyogesh18@gmail.com
// //123456

import 'package:spos_retail/views/widgets/export.dart';



class Unit extends StatefulWidget {
  @override
  _UnitState createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  //int _groupValue = 0;
  final settingController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Unit'),
        ),
        body: GetBuilder<SettingsController>(
          builder: (c) {
            return Column(
              children: <Widget>[
                RadioListTile(
                  value: 0,
                  groupValue: c.unitValue, // _groupValue,
                  onChanged: (value) {
                    settingController.toggleUnit(value);
                  
                  },
                  title: const Text('Quantity'),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: c.unitValue,
                  onChanged: (value) {
                    settingController.toggleUnit(value);
                  },
                  title: const Text('Sq. ft.'),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: c.unitValue,
                  onChanged: (value) {
                    settingController.toggleUnit(value);
                  },
                  title: const Text('Gram'),
                ),
              ],
            );
          }
        ),
      );
  }
}
