// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:spos_retail/constants/web_sockets.dart';
import 'package:spos_retail/model/PrinterModel/bill_desktopModel.dart';
import 'package:spos_retail/model/cart_respose_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

enum PaymentMethod { card, cash }

enum PaymentOptions { full, partial }

var price;

class ShowOngoingOrder extends StatefulWidget {
  final int? floor;
  final int? table;
  final String? ordertype;
  final dynamic orderData;
  List<Item> items;
  var price;
  final String tableId;
  final int? paymentcount;
  final int? customerId;
  final String? totalAmount;
  final String? remainingAmount;
  final String? totalGivenAmount;

  ShowOngoingOrder({
    Key? key,
    this.floor,
    this.table,
    required this.ordertype,
    this.orderData,
    required this.items,
    this.price,
    required this.tableId,
    this.paymentcount,
    this.customerId,
    this.totalAmount,
    this.totalGivenAmount,
    this.remainingAmount
  }) : super(key: key);

  @override
  State<ShowOngoingOrder> createState() => _ShowOngoingOrderState();
}

//var currentdate;
int? data;
late InvoiceManager invoiceManager;
int? ratesprice;
bool discountcheck = false;
bool quantityEdit = false;
var discountpercentage = 0;

TextEditingController discountController = TextEditingController();
bool disablebutton = false;
var discount,
    selectedAddressid,
    printername,
    kotprinterName,
    currentInvoiceId,
    checkBoxindex;
CustomerAddressData? selectedAddress;
final printerController = Get.put(PrinterController());
final desktopController = Get.put(DesktopPrinterController());
DateTime invoiceDate = DateTime.now();
bool generateBillClick = false;

class _ShowOngoingOrderState extends State<ShowOngoingOrder> {
  final controller = Get.put(CartController());
  final completeOrdercontroller = Get.put(CompleteOrderController());
  final catOrdercontroller = Get.put(CateringOrderController());
  final itemCancelcontroller = Get.put(ItemCancelController());
  final cancelOrderController = Get.put(CancelOrderController());

  //* Customer Address for Delivery Only------------------->
  final GetCustomerAddressController customerAddressController =
      Get.put(GetCustomerAddressController());
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final WebSocketService _webSocketService = WebSocketService();

  PaymentMethod? paymentMethod;
  PaymentOptions? paymentOptions;

  static RxBool paymentUPI = false.obs;
  static bool fullPayment = true;
  RxBool paymentCash = false.obs;
  var _printerStatus;
  var printername,
      selectedPaymentOption,
      restaurantName,
      address,
      phone,
      invoiceType;
  DateTime time = DateTime.now();

  @override
  void initState() {
    print("items at init ... ${Items}");
    super.initState();
    fullPayment = true;
    //currentdate = time.day
    //;
    discountController.text = "";
    discountpercentage = 0;
    selectedAddressid = null;
    generateBillClick = false;
    setState(() {});

    sharedPrefrence();
    paymentOptions = PaymentOptions.full;

    widget.ordertype == "Delivery"
        ? customerAddressController
            .getCustomerAddressController(widget.customerId.toString())
        : null;

    //sharedPrefrence_init();
    paymentCash = false.obs;
    paymentUPI = false.obs;
    widget.ordertype == "Dine"
        ? controller.getCartResponse(
            widget.floor ?? 0, widget.table ?? 1, widget.tableId)
        : controller.getTakeAwayResponse(widget.tableId);
    _webSocketService.connect('ws://localhost:8080');
    _webSocketService.listen(_onMessageReceived);
  }

  void _onMessageReceived(dynamic message) {
    _printerStatus = message;
    print("Message------------->" + message);
    setState(() {});
  }

  Future<void> sharedPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    printername = pref.getString("BillingPrinter");
    restaurantName = pref.getString("RestaurantName");
    address = pref.getString("Address");
    phone = pref.getString("Phone");
    invoiceType = pref.getInt("InchesType");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Retail Order", "", action: []),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.successful.isFalse || controller.completingOrder.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.orderedItems.isEmpty) {
        return const Center(child: Text("There is no order(s) on this Table."));
      } else {
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  orderSummaryWidget(
                      controller.cartOrder.value!.grandTotal,
                      controller.cartOrder.value!.taxData?.cgst ?? "0",
                      controller.cartOrder.value!.taxData?.sgst ?? "0"),
                  const SizedBox(height: 10),
                  orderedItemsListWidget(controller.orderedItems, context),
                  const SizedBox(height: 20),
                  widget.ordertype == "Advance"
                      ? _buildPaymentOption()
                      : const SizedBox.shrink(),
                  Visibility(
                      visible: !fullPayment,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 8.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  if (int.parse(v) > widget.price! ||
                                      int.parse(v) >
                                          controller
                                              .cartOrder.value!.grandTotal!) {
                                    snackBarBottom(
                                        "Error", "Invalid Amount", context);
                                    disablebutton = true;
                                    setState(() {});
                                  } else {
                                    priceController.text = v;
                                    disablebutton = false;
                                    setState(() {});
                                  }
                                },
                                onChanged: (v) {
                                  if (int.parse(v) > widget.price! ||
                                      int.parse(v) >
                                          controller
                                              .cartOrder.value!.grandTotal!) {
                                    snackBarBottom(
                                        "Error", "Invalid Amount", context);
                                    disablebutton = true;
                                    setState(() {});
                                  } else {
                                    priceController.text = v;
                                    disablebutton = false;
                                    setState(() {});
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                style: TextStyle(
                                    color: Theme.of(context).highlightColor),
                                textInputAction: TextInputAction.next,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                  hintText: "Enter Amount",
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    // Set consistent border for all states
                                    borderSide: BorderSide(
                                        color: Theme.of(context).highlightColor,
                                        width:
                                            1.0), // Set border color and width
                                  ),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .highlightColor
                                          .withOpacity(0.6)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).highlightColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    gapPadding: 19,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).highlightColor),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).highlightColor),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return 'Please Enter Table Count';
                                  }
                                  return null; // Return null if the input is valid
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                  _buildPaymentMethodSelection(),
                  // SizedBox(
                  //   height: screenHeight(context, dividedBy: 3.5),
                  // ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //  _buildFloatingActionButton(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: BeveledRectangleBorder(
                                side: BorderSide(
                                    color: Theme.of(context).focusColor)),
                            content: customText(
                                'Are you Sure, you want to Cancel Order?',
                                color: Theme.of(context).highlightColor),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    cancelOrderController.cancelorderMethod(
                                        widget.tableId, "Not Cooked");
                                    // Update the state of the app.
                                  },
                                  child: customText(
                                    'Yes',
                                    color: Theme.of(context).hoverColor,
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: customText(
                                    'No',
                                    color: Theme.of(context).primaryColor,
                                  )),
                            ],
                          );
                        });
                  },
                  child: Container(
                    // height: 48.0,
                    //width: 150.0,
                    margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                    // decoration: BoxDecoration(
                    //   color: Theme.of(context).scaffoldBackgroundColor,
                    //   border: Border.all(color: Theme.of(context).primaryColor),
                    //   borderRadius: BorderRadius.circular(15),
                    // ),
                    child: const Center(
                        child: Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                    )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (Responsive.isDesktop(context)) {
                        final formData = buildDesktopFormData();
                        desktopController.postData(formData);
                      } else {
                        final formData = buildFormData();
                        printerController.postData(formData);
                      }
                      generateBillClick = true;
                      setState(() {});
                    },
                    child: Container(
                      height: 48.0,
                      //width: 150.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: customText(
                          "Generate Bill",
                          color: Theme.of(context).primaryColor,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // Expanded(
                //   child: GestureDetector(
                //     onTap: () async {
                //       if (printername == null) {
                //         try {
                //           Get.put(CartController()).getTakewaRunningOrder();
                //           DateTime invoiceDate = DateTime.now();
                //           final invoicePDF = generatekotpdf(
                //               orderType: widget.ordertype.toString(),
                //               orderId: controller.kot,
                //               kotId: controller.orderedItems,
                //               date: DateTime.now(),
                //               table: widget.table ?? 0,
                //               floor: widget.floor ?? 0,
                //               orders: widget.items, //widget.orderedItems
                //               rebuildStatus: true,
                //               rebuildItems: controller.orderedItems);
                //           await Printing.layoutPdf(
                //             onLayout: (format) {
                //               return Future(() => invoicePDF);
                //             },
                //             format: PdfPageFormat.roll80,
                //             name:
                //                 "${invoiceDate.day}-${invoiceDate.month}${invoiceDate.year}Time:- ${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
                //           );
                //           if (widget.ordertype == "Dine") {
                //             Get.back();
                //           }
                //         } catch (e) {
                //           // print(e.toString());
                //         }
                //       } else {
                //         Get.put(CartController()).getTakewaRunningOrder();
                //         String itemsString = widget.items
                //             .map((element) => element.name)
                //             .join('/'); // Joining all elements with '/'
                //         String itemsquantity = widget.items
                //             .map((element) => element.quantity.toString())
                //             .join('/');
                //         var formData = KOTPrinterModel(
                //             printerNames: printername.toString(),
                //             billNo: "0",
                //             tableNo: widget.ordertype == "Dine"
                //                 ? "Dine"
                //                 : "Take Away",
                //             items: itemsString,
                //             qty: itemsquantity,
                //             billType: '0',
                //             dateTime:
                //                 "${invoiceDate.day}-${invoiceDate.month}-${invoiceDate.year} "
                //                 "${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
                //             ipAddress: '192.168.1.100',
                //             is3T: invoiceType != null
                //                 ? invoiceType.toString()
                //                 : "0",
                //             kotNo: '6',
                //             iN: '0');
                //         printerController.kotPrinterPost(formData);
                //       }
                //     },
                //     child: Container(
                //       height: 48.0,
                //       //width: 150.0,
                //       margin: const EdgeInsets.only(right: 10.0),
                //       decoration: BoxDecoration(
                //         color: Theme.of(context).scaffoldBackgroundColor,
                //         border:
                //             Border.all(color: Theme.of(context).primaryColor),
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       child: Center(
                //         child: customText(
                //           "Rebuilt KOT",
                //           color: Theme.of(context).primaryColor,
                //           weight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (generateBillClick == true) {
                        if (Responsive.isDesktop(context)) {
                          btnCompleteOrderTap(false);
                        } else {
                          widget.ordertype == "Advance"
                              ? disablebutton
                                  ? snackBarBottom(
                                      "Error",
                                      "Partial Amount is greater than total Amount",
                                      context)
                                  : btnCompleteOrderTap(true)
                              : widget.ordertype == "Delivery"
                                  ? selectedAddressid == null
                                      ? snackBarBottom("Error",
                                          "Please Select the Address", context)
                                      : btnCompleteOrderTap(false)
                                  : btnCompleteOrderTap(false);
                        }
                      }
                    },
                    child: Container(
                      height: 48.0,
                      decoration: BoxDecoration(
                          color: disablebutton || generateBillClick == false
                              ? Theme.of(context).hintColor
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Center(
                        child: customText(
                          "Complete",
                          font: 17.0,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // Expanded(
                //   child: TextButton(
                //     onPressed: () async {
                //       shareWhatsapp.shareText("HELLO DEEP");
                //     },
                //     child: const Text("Send Message"),
                //   ),
                // )
              ],
            ),
          ],
        );
      }
    });
  }

  Widget orderedItemsListWidget(List<Items> orders, BuildContext context) {
    return DataTable(
      showCheckboxColumn: true,
      columnSpacing: 14.0,
      border: TableBorder(
          horizontalInside:
              BorderSide(color: Theme.of(context).highlightColor)),
      columns: [
        dataColumn("Items", false),
        dataColumn("Qty.", true),
        dataColumn("Rate", true),
        dataColumn("Amt.", true),
        dataColumn("", true),
        dataColumn("", true),
      ],
      rows: orders.asMap().entries.map<DataRow>((entry) {
        final item = entry.value;

        print("final item testing... ${orders[0].quantity}");

        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      entry.value.name!,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            quantityEdit
                ? DataCell(TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Theme.of(context).highlightColor),
                    onSubmitted: (value) {
                      controller.updateBillQuantity(
                          entry.value.tableId.toString(),
                          entry.value.itemId.toString(),
                          value.toString());
                      setState(() {});
                    },
                  ))
                : dataCell("${entry.value.quantity}"),
            dataCell("${entry.value.price}"),
            dataCell("${entry.value.productTotal}"),
            dataCell(""),
            // DataCell(Center(
            //     child: InkWell(
            //         onTap: () {
            //           setState(() {
            //             quantityEdit = !quantityEdit;
            //           });
            //         },
            //         child: Icon(
            //           Icons.edit_document,
            //           color: Theme.of(context).highlightColor,
            //           size: 20.0,
            //         )))),
            DataCell(Center(
                child: InkWell(
                    onTap: () async {

                      controller.orderedItems.length == 1 ?
                      cancelOrderController.cancelorderMethod(
                                        widget.tableId, "Not Cooked"):
                      await itemCancelcontroller.fetchMenu(
                          widget.tableId,
                          int.parse(item.itemId.toString()),
                          "Not want",
                          context);
                      controller.getTakeAwayResponse(widget.tableId);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).hoverColor,
                      size: 20.0,
                    )))),
          ],
        );
      }).toList(),
    
    );
  }

  DataCell dataCell(text) {
    return DataCell(Center(
      child:
          customText(text, color: Theme.of(context).highlightColor, font: 16.0),
    ));
  }

  DataColumn dataColumn(title, bool numeric) {
    return DataColumn(
        label: Center(
          child: customText(title,
              color: Theme.of(context).highlightColor, font: 16.0),
        ),
        numeric: numeric);
  }

  Widget _buildPaymentOption() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText("Payment Options".padLeft(25),
            color: Theme.of(context).highlightColor),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.paymentcount! > 0
                ? const SizedBox.shrink()
                : Expanded(
                    child: RadioListTile<PaymentOptions>(
                      value: PaymentOptions.partial,
                      groupValue: paymentOptions,
                      activeColor: Theme.of(context).primaryColor,
                      title: customText(
                        "Pay Partial",
                        color: Theme.of(context).highlightColor,
                      ),
                      onChanged: (v) {
                        setState(() {
                          fullPayment = false;
                          paymentOptions = v;
                        });
                      },
                    ),
                  ),
            Expanded(
              child: RadioListTile<PaymentOptions>(
                value: PaymentOptions.full,
                groupValue: paymentOptions,
                activeColor: Theme.of(context).primaryColor,
                title: customText("Pay Full",
                    color: Theme.of(context).highlightColor),
                onChanged: (v) {
                  setState(() {
                    fullPayment = true;
                    paymentOptions = v;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GetBuilder<GetCustomerAddressController>(
          builder: (GetCustomerAddressController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            customText("Payment",
                color: Theme.of(context).highlightColor, font: 16.0),
            Divider(
              color: Theme.of(context).highlightColor,
            ),
            RadioListTile<PaymentMethod>(
              value: PaymentMethod.card,
              groupValue: paymentMethod,
              activeColor: Theme.of(context).primaryColor,
              title: customText(
                "Paid by UPI",
                color: Theme.of(context).highlightColor,
              ),
              onChanged: (PaymentMethod? v) {
                paymentUPI = true.obs;
                paymentCash = false.obs;
                setState(() {
                  paymentMethod = v;
                });
              },
            ),
            RadioListTile<PaymentMethod>(
              value: PaymentMethod.cash,
              activeColor: Theme.of(context).primaryColor,
              groupValue: paymentMethod,
              title: customText("Paid by Cash",
                  color: Theme.of(context).highlightColor),
              onChanged: (PaymentMethod? v) {
                paymentUPI = false.obs;
                paymentCash = true.obs;
                setState(() {
                  paymentMethod = v;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.ordertype == "Delivery"
                    ? customText("Addresses",
                        color: Theme.of(context).highlightColor, font: 16.0)
                    : const SizedBox.shrink(),
                widget.ordertype == "Delivery"
                    ? ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor),
                        onPressed: () {
                          Get.to(() => AddressPage(
                                customerID: widget.customerId!,
                              ));
                        },
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: customText(
                          "Address",
                          color: Theme.of(context).primaryColor,
                        ))
                    : const SizedBox.shrink()
              ],
            ),
            widget.ordertype == "Delivery"
                ? Divider(
                    color: Theme.of(context).highlightColor,
                  )
                : const SizedBox.shrink(),
            if (widget.ordertype == "Delivery")
              ...customerAddressController.customerAddressList
                  .asMap()
                  .entries
                  .map((entry) {
                final address = entry.value;

                return widget.ordertype == "Delivery"
                    ? RadioListTile(
                        value: address,
                        groupValue: selectedAddress,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value;
                            selectedAddressid = address.id!;
                          });
                        },
                        title: customText("${address.address}",
                            color: Theme.of(context).highlightColor,
                            font: 15.0),
                      )
                    : const SizedBox.shrink();
              }).toList()
          ],
        );
      }),
    );
  }

  Widget orderSummaryWidget(
    total,
    cGst,
    sGst,
  ) {
    discount = discountpercentage == 0
        ? total
        : total - ((discountpercentage * total) / 100);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText("Items Total",
                color: Theme.of(context).highlightColor, font: 16.0),
            customText(
                "${widget.ordertype == "Advance" ? widget.price : widget.ordertype == "Catering" ? widget.price : total}",
                color: Theme.of(context).highlightColor,
                font: 16.0),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText("Item Discount",
                color: Theme.of(context).highlightColor, font: 16.0),
            GestureDetector(
              onTap: () {
                discountcheck = true;
                setState(() {});
              },
              child: SizedBox(
                height: 20.0,
                width: 70.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: discountcheck
                          ? TextField(
                              controller: discountController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: Theme.of(context).highlightColor),
                              onSubmitted: (value) {
                                discountpercentage = int.parse(value);
                                discountcheck = false;
                                setState(() {});
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: customText(
                                  "${discountpercentage.toString()}",
                                  color: Theme.of(context).highlightColor),
                            ),
                    ),
                    // DropdownButton
                    customText("%", color: Theme.of(context).highlightColor)
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText("CGST",
                color: Theme.of(context).highlightColor, font: 16.0),
            customText("$cGst%",
                color: Theme.of(context).highlightColor, font: 16.0),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText("SGST",
                color: Theme.of(context).highlightColor, font: 16.0),
            customText("$sGst%",
                color: Theme.of(context).highlightColor, font: 16.0),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText("Item Subtotal",
                color: Theme.of(context).highlightColor, font: 16.0),
            widget.ordertype == "Advance"
                ? customText("${widget.price}",
                    color: Theme.of(context).highlightColor, font: 16.0)
                : widget.ordertype == "Catering"
                    ? customText("${widget.price}",
                        color: Theme.of(context).highlightColor, font: 16.0)
                    : customText("$discount",
                        color: Theme.of(context).highlightColor, font: 16.0),
          ],
        ),
        Divider(
          color: Theme.of(context).highlightColor,
        ),
        commonRow(
            context,
            "Payable Amount",
            widget.ordertype == "Advance"
                ? widget.price.toString()
                : widget.ordertype == "Catering"
                    ? widget.price.toString()
                    : discount.toString(),
            17.0),
        Divider(
          color: Theme.of(context).highlightColor,
        ),
        widget.ordertype == "Catering"
            ? commonRow(
                context,
                "Remaining Amount",
                widget.ordertype == "Advance"
                    ? widget.price.toString()
                    : widget.ordertype == "Catering"
                        ? widget.price.toString()
                        : discount.toString(),
                17.0)
            : const SizedBox.shrink(),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }

//! Handling the payment gateway------------------>
  void btnCompleteOrderTap(bool advance) async {
    price = priceController.text.isEmpty
        ? "${controller.cartOrder.value!.total}"
        : priceController.text;

    if (paymentUPI == true.obs || paymentCash == true.obs) {
      if (printername != null) {
        await printReceipt(advance, paymentUPI.isTrue ? "online" : "cash");
      } else {
        if (paymentUPI == true.obs) {
          if (advance) {
            await completeAdvanceOrder(advance, "online");
          } else {
            if (widget.ordertype == 'Catering') {
              await updatePendingOrders('online', context);
            } else {
              await completeOrderPost('online', context);
            }
          }
        } else if (paymentCash == true.obs) {
          if (advance) {
            await completeAdvanceOrder(advance, "cash");
          } else {
            if (widget.ordertype == 'Catering') {
              await updatePendingOrders('cash', context);
            } else {
              await completeOrderPost('cash', context);
            }
            snackBarBottom(
                "Error", "Please Define the Printer for Printing", context);
          }
        }
      }
    } else {
      snackBarBottom("Error", "Please Select Payment", context);
    }
  }

  Future<void> printReceipt(bool advance, var paymenttype) async {
    if (Responsive.isDesktop(context)) {
      // final formData = buildDesktopFormData();
      // desktopController.postData(formData);

      advance
          ? completeAdvanceOrder(
              advance, paymentUPI == true.obs ? "online" : "cash")
          : widget.ordertype == 'Catering'
              ? updatePendingOrders(paymenttype, context)
              : completeOrderPost(paymenttype, context);
    } else {
      // final formData = buildFormData();
      // printerController.postData(formData);
      advance
          ? completeAdvanceOrder(
              advance, paymentUPI == true.obs ? "online" : "cash")
          : widget.ordertype == 'Catering'
              ? updatePendingOrders(paymenttype, context)
              : completeOrderPost(paymenttype, context);
    }
  }

  BillPrinterModel buildFormData() {
    final itemsString =
        controller.orderedItems.map((element) => element.name).join('/');
    final itemsquantity = controller.orderedItems
        .map((element) => element.quantity.toString())
        .join('/');
    final itemsprice = controller.orderedItems
        .map((element) => element.price.toString())
        .join('/');
    final itemAmount = controller.orderedItems
        .map((element) => element.productTotal.toString())
        .join('/');
    final invoiceiD = controller.ordernumber.toString();
    final customerName = controller.cartOrder.value!.customer == null
        ? "-"
        : controller.cartOrder.value!.customer!.name.toString();
    final mobileNo = controller.cartOrder.value!.customer == null
        ? "-"
        : controller.cartOrder.value!.customer!.phone.toString();
    final address = controller.cartOrder.value!.customer == null
        ? "-"
        : controller.cartOrder.value!.customer!.address.toString();
    final sGst = controller.cartOrder.value!.taxData!.sgst.toString();
    final cGst = controller.cartOrder.value!.taxData!.cgst.toString();

    final invoiceDate = DateTime.now();
    final catGrandTotal = widget.totalAmount;
    final catPayableAmount = widget.remainingAmount.toString();// "0.0";
    final  catAmountPaid = widget.remainingAmount.toString(); //widget.totalGivenAmount.toString();
    final catRemainingamount =  "0.0";//widget.remainingAmount.toString();

    return BillPrinterModel(
      printerNames: printername.toString(),
      billNo: invoiceiD,
      tableNo: widget.ordertype == 'Dine' ? widget.table.toString() : "00",
      items: itemsString.toString(),
      qty: itemsquantity.toString(),
      billType: '1',
      header:
          "${restaurantName ?? "--"} /${address ?? "---"}/${phone ?? "---"}/****",
      price: itemsprice.toString(),
      amount: itemAmount.toString(),
      dateTime:
          "${invoiceDate.year}-${invoiceDate.month}-${invoiceDate.day} ${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
      lastRecord:
          "${discountpercentage == 0 ? 00.0 : discountpercentage}/$sGst/$cGst/"
          "${discount}",
      ipAddress: '192.168.1.100',
      is3T: invoiceType != null ? invoiceType.toString() : "0",
      iN: '0',
      customerNames: customerName,
      mobileNo: mobileNo,
      address: address,
      NP:"0",
      catGrandTotal: catGrandTotal.toString(),
      catPayableAmount: catPayableAmount,
      catAmountPaid: catAmountPaid,
      catRemainingamount : catRemainingamount 
    );
  }

  BillDesktopModel buildDesktopFormData() {
    final itemsString =
        controller.orderedItems.map((element) => element.name).join('/');
    final itemsquantity = controller.orderedItems
        .map((element) => element.quantity.toString())
        .join('/');
    final itemsprice = controller.orderedItems
        .map((element) => element.price.toString())
        .join('/');
    final itemAmount = controller.orderedItems
        .map((element) => element.productTotal.toString())
        .join('/');
    final invoiceiD = controller.ordernumber.toString();
    final sGst = controller.cartOrder.value!.taxData!.sgst.toString();
    final cGst = controller.cartOrder.value!.taxData!.cgst.toString();
    final invoiceDate = DateTime.now();
    final catGrandTotal = widget.totalAmount;
    final catPayableAmount = widget.remainingAmount.toString();// "0.0";
    final  catAmountPaid = widget.remainingAmount.toString(); //widget.totalGivenAmount.toString();
    final catRemainingamount =  "0.0";//widget.remainingAmount.toString();

    return BillDesktopModel(
        printerNames: printername.toString(),
        billType: "1",
        billNo: invoiceiD.toString(),
        tableNo: widget.ordertype == 'Dine' ? widget.table.toString() : "00",
        items: itemsString.toString(),
        qty: itemsquantity.toString(),
        price: itemsprice.toString(),
        amount: itemAmount.toString(),
        header:
            "${restaurantName ?? "--"} /${address ?? "---"}/${phone ?? "---"}/****",
        dateTime:
            "${invoiceDate.year}-${invoiceDate.month}-${invoiceDate.day} ${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
        lastRecord:
            "${discountpercentage == 0 ? 00.0 : discountpercentage}/$sGst/$cGst/"
            "${controller.cartOrder.value!.grandTotal!}",
        kotNo: invoiceiD.toString(),
        is3T: invoiceType != null ? invoiceType.toString() : "0",
        
        NP: "0",
        catGrandTotal: catGrandTotal.toString(),
      catPayableAmount: catPayableAmount,
      catAmountPaid: catAmountPaid,
      catRemainingamount : catRemainingamount 

        );
        
  }

  Future<void> completeAdvanceOrder(bool advance, String paymentType) async {
    completeOrdercontroller.completeAdvanceOrder(
      widget.tableId,
      1,
      paymentType,
      advance
          ? priceController.text.isEmpty
              ? widget.price
              : int.parse(priceController.text.toString())
          : widget.price,
      fullPayment ? 0 : 1,
      fullPayment ? 1 : 0,
      int.parse(
          discountController.text.isEmpty ? "0" : discountController.text),
      fullPayment,
      context,
    );
  }

  Future<void> updatePendingOrders(
      String paymentType, BuildContext context) async {
    await catOrdercontroller.updatePendingOrders(
      widget.tableId,
      paymentType,
      "0",
      "1",
      widget.price!,
      context,
      controller.orderedItems,
    );
  }

  Future<void> completeOrderPost(
      String paymentType, BuildContext context) async {
    completeOrdercontroller.completeOrderPost(
      widget.tableId,
      0,
      paymentType,
      widget.ordertype,
      1,
      0,
      controller.cartOrder.value!.grandTotal!,
      selectedAddressid,
      int.parse(
          discountController.text.isEmpty ? "0" : discountController.text),
      context,
    );
  }
}

Widget orderSummaryWidget(
  context,
  total,
  List<Items> orderitems,
) {
  return Column(
    children: [
      commonRow(context, "Items Total", "${total.toStringAsFixed(2)}", 16.0),
      commonRow(context, "${00}%", total.toString(), 16.0),
      commonRow(context, "Item Subtotal", total.toString(), 17.0),
      const Divider(),
      commonRow(context, "Payable Amount", total.toString(), 17.0),
    ],
  );
}

Widget commonRow(context, text1, text2, fontValue) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      customText(text1,
          color: Theme.of(context).highlightColor, font: fontValue),
      customText(text2,
          color: Theme.of(context).highlightColor, font: fontValue),
    ],
  );
}
