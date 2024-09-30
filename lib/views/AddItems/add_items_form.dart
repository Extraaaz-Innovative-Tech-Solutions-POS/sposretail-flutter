import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

class AddItemsForm extends StatefulWidget {
  int categoryId;
  bool updateisClick;
  int? itemId;
  String? price;
  String? name;
  String? discount;
  String? itemimage;
  AddItemsForm({
    Key? key,
    required this.categoryId,
    required this.updateisClick,
    this.price,
    this.name,
    this.discount,
    this.itemId,
    this.itemimage
  }) : super(key: key);

  @override
  State<AddItemsForm> createState() => _AddItemsFormState();
}

class _AddItemsFormState extends State<AddItemsForm> {
  late final TextEditingController nameController;

  late final TextEditingController priceController;
  late final TextEditingController sectionPriceController;

  late final TextEditingController discountController;

  final sectionController = Get.put(SectionController());
  final sectionWisePricing = Get.put(SectionWisePricing());
  int _selectedValue = 0;
  bool switchclick = false;
  String? _selectedItem;
  var selectedSectionId;

  final ItemController itemController = Get.put(ItemController());

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  //final sectionController = Get.put(SectionController());
  final GlobalKey<FormState> _priceKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _sectionPriceKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _discountKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    selectedSectionId = 0;
    nameController =
        TextEditingController(text: widget.updateisClick ? widget.name : "");
    priceController =
        TextEditingController(text: widget.updateisClick ? widget.price : "");
    sectionPriceController =
        TextEditingController(text: widget.updateisClick ? widget.price : "");
    // discountController = TextEditingController(
    //     text: widget.updateisClick ? widget.discount : "");
    sectionController.fetchSection();
    
  }


  Future<String> convertFileToBase64(File file) async {
  final bytes = await file.readAsBytes();
  return base64Encode(bytes);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Add Items", ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: customText("Section wise Pricing",
                        color: Theme.of(context).highlightColor, font: 18.0),
                  ),
                  Expanded(
                    child: SwitchListTile(
                        activeColor: Theme.of(context).primaryColor,
                        value: switchclick,
                        onChanged: (value) {
                          setState(() {
                            switchclick = value;
                          });
                        },
                        title: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: customText("kot".tr,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  weight: FontWeight.bold,
                                  alignment: TextAlign.start,
                                  font: 15.0),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              itemForms(
                  context,
                  "name".tr,
                  widget.updateisClick ? widget.name : "Item Name",
                  false,
                  nameController,
                  key: _nameKey),
              itemForms(
                  context,
                  "Price",
                  widget.updateisClick ? widget.price : "Price",
                  true,
                  priceController,
                  key: _priceKey),
              // itemForms(
              //     context, "Discount", "Discount", true, discountController,
              //     key: _discountKey),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Image",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        itemController.pickImage();
                      },
                      icon: const Icon(
                        Icons.image_aspect_ratio_rounded,
                        size: 50,
                      )),

                  //     GetBuilder<ItemController>(
                  //   builder: (controller) {
                  //     return controller.image.value != null
                  //         ? Image.file(
                  //             controller.image.value!,
                  //             height: 100,
                  //             width: 100,
                  //           )
                  //         : Text("No image selected.", style: TextStyle(color: Theme.of(context).primaryColor),);
                  //   },
                  // ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 100,
                    width: 100,
                    child: Obx((){

                      if(itemController.image.value != null){
                        return  ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: kIsWeb
                                  ? Image.network(
                                      itemController
                                          .image.value!.path, // Adjust for web
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    )
                                  : Image.file(
                                      itemController.image.value!,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                            );
                      }else if(widget.updateisClick && widget.itemimage != null){
                        print("check url :  https://sposversion2.extraaaz.com/${widget.itemimage!}");
                          return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: widget.itemimage != null ? Image.network(
                          "https://sposversion2.extraaaz.com/${widget.itemimage!}",
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ):Image.asset(Images.placeholder),
                      );
                      }else{
                        return Center(
                              child: Text(
                                "No image selected.",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            );
                      }
                      // return itemController.image.value != null
                      //     ? ClipRRect(
                      //         borderRadius: BorderRadius.circular(10),
                      //         child: kIsWeb
                      //             ? Image.network(
                      //                 itemController
                      //                     .image.value!.path, // Adjust for web
                      //                 fit: BoxFit.cover,
                      //                 height: 100,
                      //                 width: 100,
                      //               )
                      //             : Image.file(
                      //                 itemController.image.value!,
                      //                 fit: BoxFit.cover,
                      //                 height: 100,
                      //                 width: 100,
                      //               ),
                      //       )
                      //     : Center(
                      //         child: Text(
                      //           "No image selected.",
                      //           style: TextStyle(
                      //               color: Theme.of(context).primaryColor),
                      //         ),
                      //       );
                    }),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: switchclick,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: Theme.of(context).highlightColor)),
                      padding: const EdgeInsets.only(left: 10),
                      margin: const EdgeInsets.all(10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          value: _selectedItem,
                          items: sectionController.dropdownSectionList
                              .asMap()
                              .entries
                              .map((entry) => DropdownMenuItem(
                                    child: customText(
                                        entry.value["sectionName"],
                                        color:
                                            Theme.of(context).highlightColor),
                                    value: entry.value["sectionName"],
                                    onTap: () {
                                      selectedSectionId = entry.value["id"];

                                      setState(() {});
                                    },
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedItem = value.toString();
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Select Section',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).highlightColor)),
                        ),
                      ),
                    ),
                    itemForms(
                        context,
                        "Section Price",
                        widget.updateisClick ? widget.price : "Section Price",
                        true,
                        sectionPriceController,
                        key: _sectionPriceKey),
                  ],
                ),
              ),
              ElevatedButton(

             

                  onPressed: ()async {
                    
                    if (nameController.text.isNotEmpty &&
                        priceController.text.isNotEmpty) {
                      sectionWisePricing.assignSectionWisePricing(widget.itemId,
                          selectedSectionId, sectionPriceController.text);
                             // Convert the file to base64

                   // Create a multipart request
                      AddItem addItem = AddItem(
                          item_name: nameController.text,
                          price: priceController.text,
                          discount: "0.00",
                          inventory_status: 'instock',
                          category_id: widget.categoryId,
                          );

                        
                      widget.updateisClick
                          ? itemController.postItemCondition(addItem, "${AppConstant.baseUrl}/items/${widget.itemId}/update-image", widget.itemId.toString())
                          
                          : itemController.postItemAddCondition(addItem,"https://sposversion2.extraaaz.com/api/items" ) ;    // itemController.sendToServer(addItem, "https://sposversion2.extraaaz.com/api/items")  ;  //itemController.postItem(addItem);
                    } else {
                      snackBarBottom(
                          "Error", "Please Enter the required field", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: widget.updateisClick
                      ? customText(
                          "Update Items",
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )
                      : customText(
                          "Add Items",
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}









////////////////////////////////////////////////

// import 'package:flutter/foundation.dart';
// import 'package:spos_retail/views/widgets/export.dart';
// import 'package:spos_retail/model/common_model.dart';

// class AddItemsForm extends StatefulWidget {
//   int categoryId;
//   bool updateisClick;
//   int? itemId;
//   String? price;
//   String? name;
//   String? discount;
//   String? itemimage;
//   AddItemsForm({
//     Key? key,
//     required this.categoryId,
//     required this.updateisClick,
//     this.price,
//     this.name,
//     this.discount,
//     this.itemId,
//     this.itemimage
//   }) : super(key: key);

//   @override
//   State<AddItemsForm> createState() => _AddItemsFormState();
// }

// class _AddItemsFormState extends State<AddItemsForm> {
//   late final TextEditingController nameController;

//   late final TextEditingController priceController;
//   late final TextEditingController sectionPriceController;

//   late final TextEditingController discountController;

//   final sectionController = Get.put(SectionController());
//   final sectionWisePricing = Get.put(SectionWisePricing());
//  // var selectedSectionId;

//   final ItemController itemController = Get.put(ItemController());

//   final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _priceKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
//     //selectedSectionId = 0;
//     nameController =
//         TextEditingController(text: widget.updateisClick ? widget.name : "");
//     priceController =
//         TextEditingController(text: widget.updateisClick ? widget.price : "");
//     sectionPriceController =
//         TextEditingController(text: widget.updateisClick ? widget.price : "");
//     // discountController = TextEditingController(
//     //     text: widget.updateisClick ? widget.discount : "");
//     sectionController.fetchSection();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: commonAppBar(context, "Add Items", ""),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               itemForms(
//                   context,
//                   "Name",
//                   widget.updateisClick ? widget.name : "Item Name",
//                   false,
//                   nameController,
//                   key: _nameKey),
//               itemForms(
//                   context,
//                   "Price",
//                   widget.updateisClick ? widget.price : "Price",
//                   true,
//                   priceController,
//                   key: _priceKey),
//                   /////////////////
//                   Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Text(
//                       "Image",
//                       style: TextStyle(
//                           color: Theme.of(context).primaryColor, fontSize: 15),
//                       textAlign: TextAlign.left,
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         itemController.pickImage();
//                       },
//                       icon: const Icon(
//                         Icons.image_aspect_ratio_rounded,
//                         size: 50,
//                       )),

//                   //     GetBuilder<ItemController>(
//                   //   builder: (controller) {
//                   //     return controller.image.value != null
//                   //         ? Image.file(
//                   //             controller.image.value!,
//                   //             height: 100,
//                   //             width: 100,
//                   //           )
//                   //         : Text("No image selected.", style: TextStyle(color: Theme.of(context).primaryColor),);
//                   //   },
//                   // ),

//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     height: 100,
//                     width: 100,
//                     child: Obx((){

//                       if(itemController.image.value != null){
//                         return  ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: kIsWeb
//                                   ? Image.network(
//                                       itemController
//                                           .image.value!.path, // Adjust for web
//                                       fit: BoxFit.cover,
//                                       height: 100,
//                                       width: 100,
//                                     )
//                                   : Image.file(
//                                       itemController.image.value!,
//                                       fit: BoxFit.cover,
//                                       height: 100,
//                                       width: 100,
//                                     ),
//                             );
//                       }else if(widget.updateisClick && widget.itemimage != null){
//                         print("check url :  https://sposversion2.extraaaz.com/${widget.itemimage!}");
//                           return ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: widget.itemimage != null ? Image.network(
//                           "https://sposversion2.extraaaz.com/${widget.itemimage!}",
//                           fit: BoxFit.cover,
//                           height: 100,
//                           width: 100,
//                         ):Image.asset(Images.placeholder),
//                       );
//                       }else{
//                         return Center(
//                               child: Text(
//                                 "No image selected.",
//                                 style: TextStyle(
//                                     color: Theme.of(context).primaryColor),
//                               ),
//                             );
//                       }
//                       // return itemController.image.value != null
//                       //     ? ClipRRect(
//                       //         borderRadius: BorderRadius.circular(10),
//                       //         child: kIsWeb
//                       //             ? Image.network(
//                       //                 itemController
//                       //                     .image.value!.path, // Adjust for web
//                       //                 fit: BoxFit.cover,
//                       //                 height: 100,
//                       //                 width: 100,
//                       //               )
//                       //             : Image.file(
//                       //                 itemController.image.value!,
//                       //                 fit: BoxFit.cover,
//                       //                 height: 100,
//                       //                 width: 100,
//                       //               ),
//                       //       )
//                       //     : Center(
//                       //         child: Text(
//                       //           "No image selected.",
//                       //           style: TextStyle(
//                       //               color: Theme.of(context).primaryColor),
//                       //         ),
//                       //       );
//                     }),
//                   )
//                 ],
//               ),
//                   /////////////////
//               ElevatedButton(
//                   onPressed: () {
//                     if (nameController.text.isNotEmpty &&
//                         priceController.text.isNotEmpty
//                        ) {
//                       AddItem addItem = AddItem(
//                           item_name: nameController.text,
//                           price: priceController.text,
//                       discount: "0.00",
//                           inventory_status: 'instock',
//                           category_id: widget.categoryId);
//                       widget.updateisClick
//                           ? itemController.updateItem(
//                               widget.itemId.toString(), addItem)
//                           : itemController.postItem(addItem);
//                     } else {
//                       snackBarBottom(
//                           "Error", "Please Enter the required field", context);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).primaryColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0))),
//                   child: widget.updateisClick
//                       ? customText(
//                           "Update Items",
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                         )
//                       : customText(
//                           "Add Items",
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                         )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
