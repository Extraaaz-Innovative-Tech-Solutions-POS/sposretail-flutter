import 'package:spos_retail/views/widgets/custom_textfield.dart';

import '../../widgets/export.dart';

class AddPurchaseUI extends StatefulWidget {
  const AddPurchaseUI({super.key});

  @override
  State<AddPurchaseUI> createState() => _AddPurchaseUIState();
}

class _AddPurchaseUIState extends State<AddPurchaseUI> {
  final purchaseController = Get.put(PurchaseController());
  final supplierController = Get.put(SupplierController());

  final recipeController = Get.put(RecipeController());
  String? _selectedSupplierId;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> productName = GlobalKey<FormState>();
    final GlobalKey<FormState> unit = GlobalKey<FormState>();
    final GlobalKey<FormState> quantity = GlobalKey<FormState>();
    final GlobalKey<FormState> rate = GlobalKey<FormState>();
    final GlobalKey<FormState> amount = GlobalKey<FormState>();
    final GlobalKey<FormState> partialAmount = GlobalKey<FormState>();
    final GlobalKey<FormState> sgst = GlobalKey<FormState>();
    final GlobalKey<FormState> csgst = GlobalKey<FormState>();
    final GlobalKey<FormState> dicount = GlobalKey<FormState>();
    final GlobalKey<FormState> netrange = GlobalKey<FormState>();
    return Scaffold(
        appBar: commonAppBar(context, "Add Purchase", ""),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).highlightColor)),
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.all(10),
              child: GetBuilder<SupplierController>(builder: (c) {
                return DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    value: _selectedSupplierId,
                    items: c.dropdownSupplierId
                        .asMap()
                        .entries
                        .map((entry) => DropdownMenuItem(
                              child: customText(entry.value["name"],
                                  color: Theme.of(context).highlightColor),
                              value: entry.value["name"],
                              onTap: () {
                                c.supplierId.value = entry.value["id"];
                                setState(() {});
                                print(c.supplierId.value);
                              },
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSupplierId = value.toString();
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Select Supplier',
                        labelStyle:
                            TextStyle(color: Theme.of(context).highlightColor)),
                  ),
                );
              }),
            ),

            textFieldWithHeading(productName, "Product Name", context,
                "Product Name", TextInputType.text, onchanged: (v) {
              purchaseController.purchaseName.value = v;
            }),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: textFieldWithHeading(
                        unit, "Unit", context, "Unit", TextInputType.text,
                        onchanged: (v) {
                  purchaseController.purchaseUnit.value = v;
                })),
                // SizedBox(width: 10),
                Expanded(
                    child: textFieldWithHeading(quantity, "Quantity", context,
                        "Quantity", TextInputType.number, onchanged: (v) {
                  purchaseController.purchaseQuantity.value = v;
                })),
              ],
            ),
            const SizedBox(height: 10),
            textFieldWithHeading(
                rate, "Rate", context, "Rate", TextInputType.text,
                onchanged: (v) {
              purchaseController.purchaseRate.value = v;
            }),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: textFieldWithHeading(
                        amount, "Amount", context, "Amount", TextInputType.text,
                        onchanged: (v) {
                  purchaseController.purchaseAmount.value = v;
                })),
                // SizedBox(width: 10),
                Expanded(
                    child: textFieldWithHeading(dicount, "Discount", context,
                        "Discount", TextInputType.number, onchanged: (v) {
                  purchaseController.purchaseDiscount.value = v;
                })),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: textFieldWithHeading(
                        csgst, "CGST", context, "CGST", TextInputType.text,
                        onchanged: (v) {
                  purchaseController.purchaseCgst.value = v;
                })),
                Expanded(
                    child: textFieldWithHeading(
                        sgst, "SGST", context, "SGST", TextInputType.number,
                        onchanged: (v) {
                  purchaseController.purchaseSgst.value = v;
                })),
              ],
            ),

            //////////////////////////Radio for payment

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Radio button for Full Pay
                GetBuilder<PurchaseController>(
                  builder: (controller) {
                    return Radio(
                      value: 1, // Full Pay
                      groupValue: controller.isPartial.value
                          ? 0
                          : 1, // Set Full Pay as 1
                      onChanged: (value) {
                        controller.isPartial.value = value == 0;
                        controller.update();
                      },
                    );
                  },
                ),
                customText(
                  'Full Pay',
                  color: Theme.of(context).highlightColor,
                ),
                const SizedBox(
                    width: 20), // Spacing between the two radio buttons

                // Radio button for Partial Pay
                GetBuilder<PurchaseController>(
                  builder: (controller) {
                    return Radio(
                      value: 0, // Partial Pay
                      groupValue: controller.isPartial.value
                          ? 0
                          : 1, // Set Partial Pay as 0
                      onChanged: (value) {
                        controller.isPartial.value = value == 0;
                        controller.update();
                      },
                    );
                  },
                ),
                customText(
                  'Partial Pay',
                  color: Theme.of(context).highlightColor,
                ),
              ],
            ),

            // Conditionally show TextField when Partial Pay is selected
            GetBuilder<PurchaseController>(
              builder: (controller) {
                if (controller.isPartial.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10), // Add spacing
                      textFieldWithHeading(
                        partialAmount,
                        "Partial Amount",
                        context,
                        "Enter Partial Amount",
                        TextInputType.number,
                        onchanged: (v) {
                          purchaseController.purchasePartialAmount.value = v;
                        },
                      ),
                    ],
                  );
                } else {
                  return Container(); // Return an empty container if Full Pay is selected
                }
              },
            ),
            
            textFieldWithHeading(
                netrange, "Net Pay", context, "Net Pay", TextInputType.text,
                onchanged: (v) {
              purchaseController.purchaseNetRange.value = v;
            }),

            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  // width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () {
                      purchaseController.createPurchase(
                          context, supplierController.supplierId.value);
                    },
                    child: customText(
                      'Create Purchase',
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: customText(
                      'Cancel',
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}
