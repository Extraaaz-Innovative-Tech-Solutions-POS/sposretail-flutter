// import 'package:spos_retail/controllers/allOnGoingOrder_controller/allLiveOrderController.dart';
// import 'package:spos_retail/views/widgets/export.dart';

// class CateringOngoing extends StatefulWidget {


//    CateringOngoing({super.key});

//   @override
//   State<CateringOngoing> createState() => _CateringOngoingState();
// }

// class _CateringOngoingState extends State<CateringOngoing> {
//   final allLiveOrderController = Get.put(AllLiveOrderController());
  
//   @override
//   void initState() {
//     super.initState();
//     allLiveOrderController.fetchallLiveOrder();
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(body: GetBuilder<AllLiveOrderController>(
//         builder: (AllLiveOrderController controller) {
//       return Column(
//         children: [
//           WillPopScope(
//               child: Expanded(
//                   child: ListView.builder(
//                       itemCount: allLiveOrderController.allLiveOrder.length,
//                       itemBuilder: (context, index) {


//                         if(allLiveOrderController.allLiveOrder[index].orderType != "Catering") {
//     return null;
//   }
//                         return Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).focusColor,
//                               border: Border.all(
//                                   color: Theme.of(context).highlightColor),
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                             child: ListTile(
//                               onTap: () {
//                                 Get.to(() => ShowOngoingOrder(
//                                   price: 100,
                                 
//                                   paymentcount: 1,
//                                     ordertype: allLiveOrderController
//                                         .allLiveOrder[index].orderType,
//                                     table_id: allLiveOrderController
//                                         .allLiveOrder[index].tableId
//                                         .toString(), items: [],));
//                               },
//                               title: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       allLiveOrderController
//                                           .allLiveOrder[index].status!
//                                           .toUpperCase(),
//                                       style: TextStyle(
//                                           letterSpacing: 3,
//                                           color:
//                                               Theme.of(context).primaryColor),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Row(children: [
//                                     Text('Order Type:',
//                                         style: TextStyle(
//                                             color: Theme.of(context)
//                                                 .highlightColor)),
//                                     SizedBox(width: 8),
//                                     Text(
//                                         allLiveOrderController
//                                             .allLiveOrder[index].orderType
//                                             .toString()
//                                             .toUpperCase(),
//                                         style: TextStyle(
//                                             color: Theme.of(context)
//                                                 .highlightColor)),
//                                   ]),
//                                   // Row(
//                                   //   children: [
//                                   //     Text('Item Count:',
//                                   //         style: TextStyle(
//                                   //             color: Theme.of(context)
//                                   //                 .highlightColor)),
//                                   //     const SizedBox(width: 8),
//                                   //     Text('',
//                                   //         style: TextStyle(
//                                   //             color: Theme.of(context)
//                                   //                 .highlightColor))
//                                   //   ],
//                                   // ),
//                                   Row(
//                                     children: [
//                                       Text('Total Bill:',
//                                           style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .highlightColor)),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                           allLiveOrderController
//                                               .allLiveOrder[index].total
//                                               .toString(),
//                                           style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .highlightColor)),
//                                     ],
//                                   ),
//                                   allLiveOrderController
//                                               .allLiveOrder[index].orderType ==
//                                           "Dine"
//                                       ? Text(
//                                           "Table: ${allLiveOrderController.allLiveOrder[index].tableNumber.toString()}",
//                                           style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .highlightColor),
//                                         )
//                                       : SizedBox.shrink(),
//                                   allLiveOrderController
//                                               .allLiveOrder[index].orderType ==
//                                           "Dine"
//                                       ? Text(
//                                           "Floor: ${allLiveOrderController.allLiveOrder[index].floorNumber.toString()}",
//                                           style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .highlightColor),
//                                         )
//                                       : SizedBox.shrink()
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       })),
//               onWillPop: () async {
//                 Get.to(BottomNav(pageindex: 1));
//                 return false;
//               })
//         ],
//       );
//     }));
//   }
// }
