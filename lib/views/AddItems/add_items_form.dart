import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:spos_retail/controllers/barcode_controller.dart';
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


  final ItemController itemController = Get.put(ItemController());

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _priceKey = GlobalKey<FormState>();
  final upcController = TextEditingController();
  final barcodeController = Get.put(BarcodeController());

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.updateisClick ? widget.name : "");
    priceController =
        TextEditingController(text: widget.updateisClick ? widget.price : "");
    sectionPriceController =
        TextEditingController(text: widget.updateisClick ? widget.price : "");
    
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

               GetBuilder<ItemController>(builder: (c) {
                    return toggleOption("UPC", c.barcodeUpc.value,
                        onchange: (v) {
                      c.toggleBarcodeUpc(v);
                    });
                  }),
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
                        debugPrint("check url :  https://sposversion2.extraaaz.com/${widget.itemimage!}");
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
              GetBuilder<ItemController>(builder: (c) {
                return Visibility(
                  visible: c.barcodeUpc.value,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("UPC",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      Container(
                        height: 70.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 06),
                        child: TextFormField(
                          controller: upcController,
                          onChanged: (v) {
                          },

                          style: TextStyle(
                              color: Theme.of(context).highlightColor),
                          // keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          enableSuggestions: true,
                          decoration: InputDecoration(
                            hintText: "Enter UPC",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor,
                                  width: 1.0), // Set border color and width
                            ),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .highlightColor
                                    .withOpacity(0.6)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              gapPadding: 19,
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                barcodeController.scanBarcodeNormal();
                                upcController.text =
                                    barcodeController.scanBarcode.value;
                                    setState(() {
                                      
                                    });
                                    print("UPC TEXT CONTROLLER : -----------------------${upcController.text}");
                              },
                              icon: const Icon(Icons.qr_code),
                            ),
                          ),
                        ),
                      ),
                      spacer(10)
                    ],
                  ),
                );
              }),
              const SizedBox(
                height: 20.0,
              ),
              
              ElevatedButton(

             

                  onPressed: ()async {
                    
                    if (nameController.text.isNotEmpty &&
                        priceController.text.isNotEmpty) {

                   // Create a multipart request
                      AddItem addItem = AddItem(
                          item_name: nameController.text,
                          price: priceController.text,
                          discount: "0.00",
                          inventory_status: 'instock',
                          category_id: widget.categoryId,
                          upc: upcController.text
                          );

                        
                      widget.updateisClick
                          ? itemController.postItemCondition(addItem, "${AppConstant.baseUrl}/items/${widget.itemId}/update-image", widget.itemId.toString())
                          
                          : itemController.postItemAddCondition(addItem,"${AppConstant.baseUrl}/items" ) ;    // itemController.sendToServer(addItem, "https://sposversion2.extraaaz.com/api/items")  ;  //itemController.postItem(addItem);
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

  Widget toggleOption(heading, value, {onchange}) {
    return SwitchListTile(
        contentPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
        title: customText(heading,
            color: Theme.of(context).highlightColor, font: 18.0),
        activeColor: Theme.of(context).primaryColor,
        value: value,
        onChanged: onchange);
  }
}
