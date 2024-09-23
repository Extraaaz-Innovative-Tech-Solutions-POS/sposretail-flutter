import 'package:flutter/cupertino.dart';
import 'package:spos_retail/model/cart_respose_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

enum PaymentMethod { card, cash }

// ignore: must_be_immutable
class CateringOngoingOrder extends StatefulWidget {
  final String? ordertype;
  //final dynamic orderData;
  List<Items>? item;
  final int? price;
  final String table_id;
  final int? paymentcount;
  final int? customerId;
  CateringOngoingOrder({
    Key? key,
    this.ordertype,
    this.item,
    this.price,
    required this.table_id,
    this.paymentcount,
    this.customerId,
  }) : super(key: key);

  @override
  State<CateringOngoingOrder> createState() => _ShowOngoingOrderState();
}

class _ShowOngoingOrderState extends State<CateringOngoingOrder> {
  int? data;
  late InvoiceManager invoiceManager;
  var currentInvoiceId, checkBoxindex;
  int? ratesprice;
  bool discountcheck = false;
  var discountpercentage = 0;

  var discount;
  TextEditingController discountController = TextEditingController();
  String dropdownValue = '%';
  bool disablebutton = false;
  var selectedAddressid;
  CustomerAddressData? selectedAddress;
  final printerController = Get.put(PrinterController());
  final printerUtlityController = Get.put(PrinterController());
  final priceController = TextEditingController();
  final oneplatePriceController = TextEditingController();
  final discountTextController = TextEditingController(text: "0");
  final noofPlatesController = TextEditingController();
  var printername;
  DateTime invoiceDate = DateTime.now();
  final CateringOrderController controller = Get.put(CateringOrderController());
  PaymentMethod? paymentMethod;
  PaymentOptions? paymentOptions;

  static RxBool paymentUPI = false.obs;
  static bool fullPayment = false;
  RxBool paymentCash = true.obs;
  var selectedPaymentOption,
      restaurantName,
      address,
      phone,
      onplatePrice,
      finalTotal,
      noOfPlates;

  @override
  void initState() {
    super.initState();
    paymentCash = false.obs;
    paymentUPI = false.obs;
    sharedPrefrence();
    paymentOptions = PaymentOptions.partial;
    finalTotal = 0;
  }

  Future<void> sharedPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    printername = pref.getString("BillingPrinter");
    restaurantName = pref.getString("RestaurantName");
    address = pref.getString("Address");
    phone = pref.getString("Phone");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Catering Advance", ""),
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
        return GetBuilder<CateringOrderController>(
            builder: (CateringOrderController controller) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // orderSummaryWidget(controller.cartOrder.value!.total,
                    //     controller.cartOrder.value!.items),
                    const SizedBox(height: 10),
                    orderedItemsListWidget(controller.orderedItems, context),
                    const SizedBox(height: 20),
                    platesCount(),
                    const SizedBox(height: 20),
                    _buildPaymentOption(),

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
                                    if (int.parse(v) >
                                        int.parse(finalTotal.toString())) {
                                      snackBarBottom(
                                          "Error", "Invalid Amount", context);
                                      disablebutton = true;
                                      setState(() {});
                                    } else {
                                      // priceController.text = v;
                                      // disablebutton = false;
                                      // setState(() {});
                                    }
                                  },
                                  onChanged: (v) {
                                    if (int.parse(v) >
                                        int.parse(finalTotal.toString())) {
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
                                          color:
                                              Theme.of(context).highlightColor,
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
                    //  _buildPaymentMethodSelection(),// not accepted
                    // SizedBox(
                    //   height: screenHeight(context, dividedBy: 3.5),
                    // ),
                  ],
                ),
              ),
              //  Container(
              //   height: 200,
              //   child: _buildPaymentMethodSelection()),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //  _buildFloatingActionButton(),
                  Expanded(
                    child: GestureDetector(
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

                                // title: Text('Logout',style:TextStyle(color:Theme.of(context).highlightColor)),
                                content: Text(
                                    'Are you Sure, you want to Cancel Order?',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).highlightColor)),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        // controller.cancelCatAdvOrder(
                                        //     widget.table_id,
                                        //     widget.item,
                                        //     widget.customerId);
                                        // cancelOrderController.cancelorderMethod(
                                        //     widget.table_id, "Not Cooked");
                                        // Update the state of the app.
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).hoverColor),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                ],
                              );
                            });
                      },
                      child: Container(
                        height: 48.0,
                        //width: 150.0,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        //////////////
                        if (printername == null) {
                          try {
                            Get.put(CartController()).getTakewaRunningOrder();
                            DateTime invoiceDate = DateTime.now();
                            // final invoicePDF = generatekotpdf(
                            //     orderType: widget.ordertype.toString(),
                            //     orderId: controller.kot,
                            //     kotId: controller.orderedItems,
                            //     date: DateTime.now(),
                            //     table: 0,
                            //     floor: 0,
                            //     orders: widget.items, //widget.orderedItems
                            //     rebuildStatus: true,
                            //     rebuildItems: controller.orderedItems);
                            // await Printing.layoutPdf(
                            //   onLayout: (format) {
                            //     return Future(() => invoicePDF);
                            //   },
                            //   format: PdfPageFormat.roll80,
                            //   name:
                            //       "${invoiceDate.day}-${invoiceDate.month}${invoiceDate.year}Time:- ${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
                            // );
                            if (widget.ordertype == "Dine") {
                              Get.back();
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        }
                        // else {
                        //   String itemsString = widget.items
                        //       .map((element) => element.name)
                        //       .join('/'); // Joining all elements with '/'
                        //   String itemsquantity = widget.items
                        //       .map((element) => element.quantity.toString())
                        //       .join('/');
                        //   var formData = KOTPrinterModel(
                        //       printerNames: printername.toString(),
                        //       billNo: '101',
                        //       tableNo: '0',
                        //       items: itemsString,
                        //       qty: itemsquantity,
                        //       billType: '0',
                        //       dateTime:
                        //           "${invoiceDate.year}-${invoiceDate.month}-${invoiceDate.day} "
                        //           "${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
                        //       ipAddress: '192.168.1.100',
                        //       is3T: "0",
                        //       kotNo: '6',
                        //       iN: '0');
                        //   printerController.kotPrinterPost(formData);
                        // }
                      },
                      child: Container(
                        height: 48.0,
                        //width: 150.0,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Rebuilt KOT",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        disablebutton == false ? btnCompleteOrderTap() : null;
                      },
                      child: Container(
                        height: 48.0,
                        //width: 150.0,
                        decoration: BoxDecoration(
                            color: disablebutton
                                ? Theme.of(context).hintColor
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: Center(
                          child: Text(
                            "Complete",
                            style: TextStyle(
                                fontSize: 17.0,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      }
    });
  }

  void btnCompleteOrderTap() async {
    price = priceController.text.isEmpty
        ? "${controller.cartOrder.value!.total}"
        : priceController.text;
    print(price);
    if (paymentUPI == true.obs) {
      if (printername != null) {
        String itemsString = controller.orderedItems
            .map((element) => element.name)
            .join('/'); // Joining all elements with '/'
        String itemsquantity = controller.orderedItems
            .map((element) => element.quantity.toString())
            .join('/');
        String itemsprice = controller.orderedItems
            .map((element) => element.price.toString())
            .join('/');
        String itemAmount = controller.orderedItems
            .map((element) => element.productTotal.toString())
            .join('/');
        String invoiceiD = controller.ordernumber.toString();
  final customerName = controller.cartOrder.value!.customer!.name.toString();

  print("complete order customer testing :${customerName}");
    final mobileNo = controller.cartOrder.value!.customer!.phone.toString();
    //final address = controller.cartOrder.value!.customer!.address.toString();
    final catGrandTotal = controller.cartOrder.value!.grandTotal == null
            ? ""
            : controller.cartOrder.value!.grandTotal.toString();
        final catPayableAmount = controller.cartOrder.value!.grandTotal == null
            ? ""
            : controller.cartOrder.value!.grandTotal.toString();
        final catAmountPaid =
            controller.cartOrder.value!.totalGivenAmount == null
                ? ""
                : controller.cartOrder.value!.totalGivenAmount.toString();
        final catRemainingamount =
            controller.cartOrder.value!.remainingMoney == null
                ? ""
                : controller.cartOrder.value!.remainingMoney.toString();
        DateTime invoiceDate = DateTime.now();
        final formData = BillPrinterModel(
          printerNames: printername.toString(),
          billNo: invoiceiD,
          tableNo: "00",
          items: itemsString.toString(),
          qty: itemsquantity.toString(),
          billType: '1',
          header:
              "${restaurantName ?? "--"} /${address ?? "---"}/${phone ?? "---"}/****",
          price: itemsprice.toString(),
          amount: itemAmount.toString(),
          dateTime:
              "${invoiceDate.year}-${invoiceDate.month}-${invoiceDate.day} "
              "${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
          //dropdownValue == '%' ? total - discount : discount
          lastRecord: "",
          // "${discountpercentage == 0 ? 00.0 : discountpercentage}/00.00/00.00/${dropdownValue == '%' ? controller.cartOrder.value!.total! - discount : discount}",
          ipAddress: '192.168.1.100',
          is3T: '0',
          iN: '0', customerNames: customerName, mobileNo: mobileNo, address: address,
          NP: "0",
          catGrandTotal: catGrandTotal,
            catPayableAmount: catPayableAmount,
            catAmountPaid: catAmountPaid,
            catRemainingamount: catRemainingamount
        );

        printerUtlityController
            .postData(formData)
            .whenComplete(() => controller.completeCatAdvOrder(
                widget.table_id,
                "online",

                //"online",
                fullPayment ? 0 : 1,
                fullPayment ? 1 : 0,
                "0",
                oneplatePriceController.text,
                noofPlatesController.text,
                price,
                context,
                widget.item!));
      } else {
        controller.completeCatAdvOrder(
            widget.table_id,
            "online",
            fullPayment ? 0 : 1,
            fullPayment ? 1 : 0,
            "0",
            oneplatePriceController.text,
            noofPlatesController.text,
            price,
            context,
            widget.item!);
      }
    } else if (paymentCash == true.obs) {
      if (printername != null) {
        String itemsString = controller.orderedItems
            .map((element) => element.name)
            .join('/'); // Joining all elements with '/'
        String itemsquantity = controller.orderedItems
            .map((element) => element.quantity.toString())
            .join('/');
        String itemsprice = controller.orderedItems
            .map((element) => element.price.toString())
            .join('/');
        String itemAmount = controller.orderedItems
            .map((element) => element.productTotal.toString())
            .join('/');
        String invoiceiD = controller.ordernumber.toString();
  final customerName = controller.cartOrder.value!.customer!.name.toString();
  print("complete order customer cash testing :${customerName}");
    final mobileNo = controller.cartOrder.value!.customer!.phone.toString();
    // final address = controller.cartOrder.value!.customer!.address.toString();
    final catGrandTotal = controller.cartOrder.value!.grandTotal == null
            ? ""
            : controller.cartOrder.value!.grandTotal.toString();
        final catPayableAmount = controller.cartOrder.value!.grandTotal == null
            ? ""
            : controller.cartOrder.value!.grandTotal.toString();
        final catAmountPaid =
            controller.cartOrder.value!.totalGivenAmount == null
                ? ""
                : controller.cartOrder.value!.totalGivenAmount.toString();
        final catRemainingamount =
            controller.cartOrder.value!.remainingMoney == null
                ? ""
                : controller.cartOrder.value!.remainingMoney.toString();
// Print the resulting string
        //  print(itemsString);
        DateTime invoiceDate = DateTime.now();
        final formData = BillPrinterModel(
          printerNames: printername.toString(),
          billNo: invoiceiD,
          tableNo: "00",
          items: itemsString.toString(),
          qty: itemsquantity.toString(),
          billType: '1',
          header:
              "${restaurantName ?? "--"} /${address ?? "---"}/${phone ?? "---"}/****",
          price: itemsprice.toString(),
          amount: itemAmount.toString(),
          dateTime:
              "${invoiceDate.year}-${invoiceDate.month}-${invoiceDate.day} "
              "${invoiceDate.hour}:${invoiceDate.minute}:${invoiceDate.second}",
          lastRecord:
              "${discountpercentage == 0 ? 00.0 : discountpercentage}/00.00/00.00/${dropdownValue == '%' ? controller.cartOrder.value!.total! - discount : discount}",
          ipAddress: '192.168.1.100',
          is3T: '0',
          iN: '0', 
          customerNames: customerName, mobileNo: mobileNo, address: address,
          NP:"0",
          catAmountPaid: catAmountPaid,
          catGrandTotal: catGrandTotal,
          catPayableAmount: catPayableAmount,
          catRemainingamount: catRemainingamount
        );
      } else {
        controller.completeCatAdvOrder(
            widget.table_id,
            "cash",
            fullPayment ? 0 : 1,
            fullPayment ? 1 : 0,
            "0",
            oneplatePriceController.text,
            noofPlatesController.text,
            price,
            context,
            widget.item!);
        snackBarBottom(
            "Error", "Please Define the Printer for Printing", context);
      }
    } else {
      controller.completeCatAdvOrder(
          widget.table_id,
          "cash",
          fullPayment ? 0 : 1,
          fullPayment ? 1 : 0,
          "0",
          oneplatePriceController.text,
          noofPlatesController.text,
          price,
          context,
          widget.item!);
      //  snackBarBottom("Error", "Please Select Payment", context);
    }
  }

  Widget orderedItemsListWidget(List<Items> orders, BuildContext context) {
    //checktheInvoice();
    return DataTable(
      showCheckboxColumn: true,
      //dataRowHeight: 60.0,
      columnSpacing: 14.0,
      border: TableBorder(
          horizontalInside:
              BorderSide(color: Theme.of(context).highlightColor)),
      columns: [
        DataColumn(
            label: Center(
              child: Text("items".tr,
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: 16.0)),
            ),
            numeric: false),
        const DataColumn(label: Text(""), numeric: true),
      ],
      rows: orders.asMap().entries.map<DataRow>((entry) {
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
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            DataCell(Center(
                child: InkWell(
                    onTap: () async {
                      controller.cancelItemCatAdvOrder(widget.table_id,
                          int.parse(entry.value.itemId.toString()));

                      setState(() {});

                      // setState(() {});
                    },
                    child: Icon(
                      CupertinoIcons.delete,
                      color: Theme.of(context).hoverColor,
                      size: 20.0,
                    )))),
          ],
        );
      }).toList(),
    );
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
            Expanded(
              child: RadioListTile<PaymentMethod>(
                value: PaymentMethod.card,
                groupValue: paymentMethod,
                activeColor: Theme.of(context).primaryColor,
                title: Text(
                  "UPI",
                  style: TextStyle(color: Theme.of(context).highlightColor),
                ),
                onChanged: (v) {
                  setState(() {
                    paymentUPI = true.obs;
                    paymentCash = false.obs;
                    setState(() {
                      paymentMethod = v;
                    });
                    paymentMethod = v;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<PaymentMethod>(
                value: PaymentMethod.cash,
                groupValue: paymentMethod,
                activeColor: Theme.of(context).primaryColor,
                title:
                  Text("Cash", style: TextStyle(color: Theme.of(context).highlightColor)),
                onChanged: (v) {
                  setState(() {
                    fullPayment = false;
                    paymentMethod = v;
                  });
                },
              ),
            ),
          ],
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RadioListTile<PaymentOptions>(
                value: PaymentOptions.partial,
                groupValue: paymentOptions,
                activeColor: Theme.of(context).primaryColor,
                title: Text(
                  "Pay Partial",
                  style: TextStyle(color: Theme.of(context).highlightColor),
                ),
                onChanged: (v) {
                  setState(() {
                    fullPayment = false;
                    paymentOptions = v;
                    print("Options------------>" + paymentOptions.toString());
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<PaymentOptions>(
                value: PaymentOptions.full,
                groupValue: paymentOptions,
                activeColor: Theme.of(context).primaryColor,
                title: Text("Pay Full",
                    style: TextStyle(color: Theme.of(context).highlightColor)),
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

        // Row(children: [

        //   RadioListTile<PaymentMethod>(
        //       value: PaymentMethod.card,
        //       groupValue: paymentMethod,
        //       activeColor: Theme.of(context).primaryColor,
        //       title: Text(
        //         "Paid by UPI",
        //         style: TextStyle(color: Theme.of(context).highlightColor),
        //       ),
        //       onChanged: (PaymentMethod? v) {
        //         paymentUPI = true.obs;
        //         paymentCash = false.obs;
        //         setState(() {
        //           paymentMethod = v;
        //         });
        //         print(paymentMethod);
        //       },
        //     ),

        //     RadioListTile<PaymentMethod>(
        //       value: PaymentMethod.cash,
        //       activeColor: Theme.of(context).primaryColor,
        //       groupValue: paymentMethod,
        //       title: const Text("Paid by Cash",
        //           style: TextStyle(color: Colors.white)),
        //       onChanged: (PaymentMethod? v) {
        //         paymentUPI = false.obs;
        //         paymentCash = true.obs;
        //         setState(() {
        //           paymentMethod = v;
        //         });
        //       },
        //     ),

        // ],),

        //////////////
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
            Text("Payment",
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: 16.0)),
            Divider(
              color: Theme.of(context).highlightColor,
            ),
            RadioListTile<PaymentMethod>(
              value: PaymentMethod.card,
              groupValue: paymentMethod,
              activeColor: Theme.of(context).primaryColor,
              title: Text(
                "Paid by UPI",
                style: TextStyle(color: Theme.of(context).highlightColor),
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
              title: Text("Paid by Cash",
                  style: TextStyle(color: Theme.of(context).highlightColor)),
              onChanged: (PaymentMethod? v) {
                paymentUPI = false.obs;
                paymentCash = true.obs;
                setState(() {
                  paymentMethod = v;
                });
              },
            ),
          ],
        );
      }),
    );
  }

  Widget platesCount() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customText("Price of one plate:",
                color: Theme.of(context).highlightColor, font: 16.0),
            Container(
                height: 40.0,
                width: 120.0,
                margin: const EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    border:
                        Border.all(color: Theme.of(context).highlightColor)),
                child: TextField(
                  controller: oneplatePriceController,
                  style: TextStyle(color: Theme.of(context).highlightColor),
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    onplatePrice = value;
                    setState(() {});
                  },
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customText("Number of plates:",
                color: Theme.of(context).highlightColor, font: 16.0),
            Container(
                height: 40.0,
                width: 120.0,
                margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    border:
                        Border.all(color: Theme.of(context).highlightColor)),
                child: TextField(
                  controller: noofPlatesController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Theme.of(context).highlightColor),
                  onSubmitted: (value) {
                    noOfPlates = value;
                    finalTotal =
                        "${int.parse(onplatePrice ?? "0") * int.parse(noOfPlates ?? "0")}";
                    setState(() {});
                  },
                ))
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     customText("Discount:",
        //         color: Theme.of(context).highlightColor, font: 16.0),
        //     Container(
        //         height: 40.0,
        //         width: 120.0,
        //         margin: const EdgeInsets.only(left: 80.0, top: 10.0),
        //         decoration: BoxDecoration(
        //             color: Theme.of(context).focusColor,
        //             border:
        //                 Border.all(color: Theme.of(context).highlightColor)),
        //         child: TextField(
        //           controller: discountTextController,
        //           style: TextStyle(color: Theme.of(context).highlightColor),
        //           onSubmitted: (value) {
        //             finalTotal = "${int.parse(onplatePrice ?? "0") * int.parse(noOfPlates ?? "0")}";
        //             setState(() {});
        //           },
        //         ))
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customText("Total:",
                color: Theme.of(context).highlightColor, font: 16.0),
            Container(
                height: 40.0,
                width: 120.0,
                margin: const EdgeInsets.only(left: 100.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    border:
                        Border.all(color: Theme.of(context).highlightColor)),
                child: Center(
                    child: customText(finalTotal,
                        // "${int.parse(onplatePrice ?? "0") * int.parse(noOfPlates ?? "0")}",
                        color: Theme.of(context).highlightColor)))
          ],
        ),
      ],
    );
  }
}
