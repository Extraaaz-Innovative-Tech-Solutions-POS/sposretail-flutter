import 'package:spos_retail/views/widgets/export.dart';

class CateringOrderConfirmScreen extends StatefulWidget {
  dynamic selectedMenuList;
  String advanceId;
  String customerId;
  CateringOrderConfirmScreen(
      {super.key,
      required this.selectedMenuList,
      required this.advanceId,
      required this.customerId,
      });

  @override
  State<CateringOrderConfirmScreen> createState() =>
      _CateringOrderConfirmScreenState();
}

class _CateringOrderConfirmScreenState
    extends State<CateringOrderConfirmScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Order Confirm", ""),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: widget.selectedMenuList.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                decoration: cardBorder(context),
                width: double.infinity,
                margin:
                    const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
               // color: Theme.of(context).focusColor,
                child: ListTile(
                  title: Text(
                    widget.selectedMenuList[i].name,
                    style: TextStyle(color: Theme.of(context).highlightColor),
                  ),
                  leading: Text("${i + 1}",
                      style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: 16.0)),
                  // trailing: Icon(
                  //   Icons.cancel,
                  //   color: Theme.of(context).highlightColor,
                  // ),
                ),
              );
            },
          )),
          Container(
            margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            height: 50.0,
            width: 200.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {

                  Get.to(CateringCustomerDetails(
                    tableId: widget.advanceId,
                    items: widget.selectedMenuList,
                    customerId: widget.customerId,
                  ));
                },
                child: customText(
                  "Confirm",
                  color: Theme.of(context).scaffoldBackgroundColor,
                )),
          )
        ],
      ),
    );
  }
}
