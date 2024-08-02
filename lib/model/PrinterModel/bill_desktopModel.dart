class BillDesktopModel {
  final String printerNames;
  final String billType;
  final String billNo;
  final String tableNo;
  final String items;
  final String qty;
  final String price;
  final String amount;
  final String header;
  final String dateTime;
  final String lastRecord;
  final String is3T;
  final String kotNo;
  final String NP;
  final String catRemainingamount;
  final String catGrandTotal;
  final String catPayableAmount;
  final String catAmountPaid;

  BillDesktopModel({
    required this.printerNames,
    required this.billType,
    required this.billNo,
    required this.tableNo,
    required this.items,
    required this.qty,
    required this.price,
    required this.amount,
    required this.header,
    required this.dateTime,
    required this.lastRecord,
    required this.is3T,
    required this.kotNo,
     required this.NP,
    required this.catAmountPaid,
    required this.catGrandTotal,
    required this.catPayableAmount,
    required this.catRemainingamount,
  });

  Map<String, String> toJson() {
    return {
      'printerNames': printerNames,
      'bill_type': billType,
      'bill_no': billNo,
      'tableNo': tableNo,
      'items': items,
      'qty': qty,
      'price': price,
      'amount': amount,
      'header': header,
      'dateTime': dateTime,
      'last_record': lastRecord,
      'is3T': is3T,
      'kotNo': kotNo,
      "NP": NP,
      'CatAmountPaid': catAmountPaid,
      'CatGrandTotal': catGrandTotal,
      'CatPayableAmount': catPayableAmount,
      'CatRemainingAmount': catRemainingamount,
    };
  }
}
