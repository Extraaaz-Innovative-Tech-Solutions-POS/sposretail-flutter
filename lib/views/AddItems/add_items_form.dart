import 'package:spos_retail/views/widgets/export.dart';
import 'package:spos_retail/model/common_model.dart';

class AddItemsForm extends StatefulWidget {
  int category_id;
  bool updateisClick;
  int? item_id;
  String? price;
  String? name;
  String? discount;
  AddItemsForm({
    Key? key,
    required this.category_id,
    required this.updateisClick,
    this.price,
    this.name,
    this.discount,
    this.item_id,
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
                              child: customText("KOT",
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
                  "Name",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        activeColor: Theme.of(context).primaryColor,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      customText('Pure Veg',
                          color: Theme.of(context).highlightColor)
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Theme.of(context).primaryColor,
                        value: 2,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      customText('Non Veg',
                          color: Theme.of(context).highlightColor)
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: switchclick,
                child: Column(
                  children: [
                    // SizedBox(
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemCount: sectionController.sectionList.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.only(top: 8.0),
                    //         child: ListTile(
                    //           title: customText(
                    //               sectionController.sectionList[index].name,
                    //               color: Theme.of(context).highlightColor),
                    //           trailing: Container(
                    //             height: 150,
                    //             width: 100,
                    //             child: TextField(
                    //               keyboardType: TextInputType.number,
                    //               style: TextStyle(
                    //                   color: Theme.of(context).highlightColor),
                    //               onChanged: (v) {},
                    //               decoration: InputDecoration(
                    //                 border: OutlineInputBorder(
                    //                   borderSide: BorderSide(
                    //                       color: Theme.of(context).focusColor,
                    //                       width:
                    //                           1.0), // Set border color and width
                    //                 ),
                    //                 hintText: priceController.text,
                    //                 hintStyle: TextStyle(
                    //                     color: Theme.of(context).hintColor),
                    //                 labelStyle: TextStyle(
                    //                     color:
                    //                         Theme.of(context).highlightColor),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

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
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        priceController.text.isNotEmpty
                       ) {
//
                      sectionWisePricing.assignSectionWisePricing(
                          widget.item_id,
                          selectedSectionId,
                          sectionPriceController.text);
                      print(widget.item_id.toString());
                      AddItem addItem = AddItem(
                          item_name: nameController.text,
                          price: priceController.text,
                      discount: "0.00",
                          inventory_status: 'instock',
                          category_id: widget.category_id);
                      widget.updateisClick
                          ? itemController.updateItem(
                              widget.item_id.toString(), addItem)
                          : itemController.postItem(addItem);
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
