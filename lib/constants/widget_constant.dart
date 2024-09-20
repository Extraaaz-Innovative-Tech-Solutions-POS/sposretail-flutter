import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spos_retail/views/widgets/export.dart';

Widget search(context, {onchange}) {
  return Container(
    margin: const EdgeInsets.only(top: 12, bottom: 12),
    decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        border: Border.all(color: Theme.of(context).highlightColor)),
    width: double.infinity,
    height: 40,
    child: Center(
      child: TextField(
        style: TextStyle(color: Theme.of(context).highlightColor),
        onChanged: onchange,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "search_for_something".tr,
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          labelStyle: TextStyle(color: Theme.of(context).highlightColor),
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
        ),
      ),
    ),
  );
}

Widget headingTitle(context, title) {
  return Text(
    title,
    style: TextStyle(fontSize: 14, color: Theme.of(context).highlightColor),
  );
}

Widget buildTextFieldWithHeading(key, String heading, BuildContext context,
    TextEditingController controller, String hinttext) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: customText(heading,
              font: 16.0,
              weight: FontWeight.bold,
              color: Theme.of(context).primaryColor)),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: key,
          child: SizedBox(
            height: 55,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                hintText: hinttext,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).focusColor,
                      width: 1.0), // Set border color and width
                ),
                hintStyle: TextStyle(color: Theme.of(context).focusColor),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).highlightColor),
                ),
                errorBorder: OutlineInputBorder(
                  gapPadding: 19,
                  borderSide:
                      BorderSide(color: Theme.of(context).highlightColor),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).highlightColor),
                ),
              ),
              validator: (value) {
                if (value == "") {
                  return 'Please Enter $heading';
                }
                return null; // Return null if the input is valid
              },
            ),
          ),
        ),
      ),
    ],
  );
}

Widget itemForms(
  context,
  titleHeading,
  hint,
  bool number,
  TextEditingController controller, {
  onchanged,
  key,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0, bottom: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(titleHeading,
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ),
      Container(
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 06),
        child: Form(
          key: key,
          child: TextFormField(
            keyboardType:
                number ? TextInputType.number : TextInputType.emailAddress,
                   onChanged: onchanged,
            controller: controller,
            style: TextStyle(color: Theme.of(context).highlightColor),
            // keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            enableSuggestions: true,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                    width: 1.0), // Set border color and width
              ),
              hintStyle: TextStyle(
                  color: Theme.of(context).highlightColor.withOpacity(0.6)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).highlightColor),
              ),
              errorBorder: OutlineInputBorder(
                gapPadding: 19,
                borderSide: BorderSide(color: Theme.of(context).highlightColor),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).highlightColor),
              ),
            ),
            validator: (value) {
              if (value == "") {
                return 'Please Enter $titleHeading';
              }
              return null; // Return null if the input is valid
            },
          ),
        ),
      ),
      spacer(10)
    ],
  );
}

void showAlertDialog({
  required BuildContext context,
  required String title,
  required String description,
}) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text("Dismiss"),
          ),
        ],
      );
    },
  );
}

Widget datePick(context, bool time, {title, onpress, color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).focusColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(02), // Set border radius here
        ),
      ),
      onPressed: onpress,
      icon: Icon(
        time ? CupertinoIcons.clock : Icons.calendar_month,
        color: Theme.of(context).primaryColor,
      ),
      label: Text(
        title != null ? title : "Select Date",
        style: TextStyle(fontSize: 14, color: color),
      ),
    ),
  );
}

Widget customPrimaryButton(context, title, {onpress}) {
  return ElevatedButton(
    onPressed: onpress,
    style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
    child: customText(title, color: Theme.of(context).scaffoldBackgroundColor),
  );
}

void showAdvanceNotify(
    {required BuildContext context, required List<dynamic> orderdata}) {
  bool ordersFound = false; // Flag to check if any orders are found for today

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor)),
        title: Center(
          child: Text("Reminder".toUpperCase(),
              style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).highlightColor)),
        ),
        content: SizedBox(
          height: 300.0,
          width: 200.0,
          child: GetBuilder<DeliveryController>(
              builder: (DeliveryController controller) {
            List<Widget> orderWidgets = [];

            for (int index = 0; index < orderdata.length; index++) {
              DateTime currentDate = DateTime.now();
              DateTime advanceOrderDate = DateTime.parse(
                  orderdata[index].advanceOrderDateTime.toString());

              String formattedCurrentDate =
                  DateFormat('yyyy-MM-dd').format(currentDate);
              String formattedAdvanceOrderDate =
                  DateFormat('yyyy-MM-dd').format(advanceOrderDate);
              if (formattedCurrentDate == formattedAdvanceOrderDate) {
                // Get the time when the popup should stop showing (e.g., 2:00 PM)
                DateTime popupEndTime = DateTime(
                    advanceOrderDate.year,
                    advanceOrderDate.month,
                    advanceOrderDate.day,
                    advanceOrderDate.hour,
                    advanceOrderDate.minute);

                // Show the popup only if the current time is before the popup end time
                if (DateTime.now().isBefore(popupEndTime)) {
                  ordersFound = true; // Set the flag to true as order is found

                  orderWidgets.add(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Order Type: ${orderdata[index].orderType.toString().toUpperCase()}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              letterSpacing: 2,
                              fontSize: 17.0),
                        ),
                        Text(
                          "Total: ₹ ${orderdata[index].total.toString()}",
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 16.0),
                        ),
                        Text(
                          "Pending Amount: ₹ ${orderdata[index].remainingMoney.toString()}",
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 16.0),
                        ),
                        customText(
                          "Money Paid: ₹ ${orderdata[index].totalGivenAmount}",
                          color: Theme.of(context).highlightColor,
                          font: 16.0,
                        ),
                        customText(
                          "Discount: ₹ ${orderdata[index].totalDiscount ?? "0"}",
                          color: Theme.of(context).highlightColor,
                          font: 16.0,
                        ),
                        customText(
                          "Name: ${orderdata[index].customer.name ?? "-"}",
                          color: Theme.of(context).highlightColor,
                          font: 16.0,
                        ),
                        customText(
                          "Address: ${orderdata[index].customer.address ?? "-"}",
                          color: Theme.of(context).highlightColor,
                          font: 16.0,
                        ),
                        customText(
                          "Date/Time: ${orderdata[index].advanceOrderDateTime}",
                          color: Theme.of(context).highlightColor,
                          font: 16.0,
                        ),
                      ],
                    ),
                  );
                }
              }
            }

            if (!ordersFound) {
              orderWidgets.add(
                Center(
                  child: Text(
                    "No order found for today!!",
                    style: TextStyle(color: Theme.of(context).highlightColor),
                  ),
                ),
              );
            }

            return Column(
              children: orderWidgets,
            );
          }),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool("Dismiss", false);
              Get.back();
            },
            child: Text(
              "Dismiss",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16.0),
            ),
          ),
        ],
      );
    },
  );
}

Widget textButton(title, color, {onpress}) {
  return TextButton(onPressed: onpress, child: customText(title, color: color));
}
