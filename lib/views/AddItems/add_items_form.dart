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
 // var selectedSectionId;

  final ItemController itemController = Get.put(ItemController());

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _priceKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    //selectedSectionId = 0;
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
              ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        priceController.text.isNotEmpty
                       ) {
//
                      // sectionWisePricing.assignSectionWisePricing(
                      //     widget.item_id,
                      //     selectedSectionId,
                      //     sectionPriceController.text);
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
