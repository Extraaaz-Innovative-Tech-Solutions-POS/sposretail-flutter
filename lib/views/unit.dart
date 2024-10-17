// import 'package:spos_retail/views/widgets/export.dart';

// enum UnitOptions { card, cash }

// class Unit extends StatelessWidget {
//   const Unit({super.key});

//   @override
//   Widget build(BuildContext context) {

    

//     UnitOptions? paymentMethod;

//     Widget buildUnitOptions() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: GetBuilder<GetCustomerAddressController>(
//           builder: (GetCustomerAddressController controller) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 30.0,
//             ),
//             customText("Payment",
//                 color: Theme.of(context).highlightColor, font: 16.0),
//             Divider(
//               color: Theme.of(context).highlightColor,
//             ),
//             RadioListTile<UnitOptions>(
//               value: UnitOptions.card,
//               groupValue: paymentMethod,
//               activeColor: Theme.of(context).primaryColor,
//               title: customText(
//                 "",
//                 color: Theme.of(context).highlightColor,
//               ),
//               onChanged: (UnitOptions? v) {
//                 // paymentUPI = true.obs;
//                 // paymentCash = false.obs;
//                 // setState(() {
//                 //   paymentMethod = v;
//                 // });
//               },
//             ),
//             RadioListTile<UnitOptions>(
//               value: UnitOptions.cash,
//               activeColor: Theme.of(context).primaryColor,
//               groupValue: paymentMethod,
//               title: customText("Sq. ft",
//                   color: Theme.of(context).highlightColor),
//               onChanged: (UnitOptions? v) {
//                 // paymentUPI = false.obs;
//                 // paymentCash = true.obs;
//                 // setState(() {
//                 //   paymentMethod = v;
//                 // });
//               },
//             ),
//           ],
//         );
//       }),
//     );
//   }


//     return Scaffold(
//       appBar: commonAppBar(context, "Unit", ""),

//       body: buildUnitOptions(),

//     );
//   }
// }

// // vichareyogesh18@gmail.com
// //123456

////////////////////

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
