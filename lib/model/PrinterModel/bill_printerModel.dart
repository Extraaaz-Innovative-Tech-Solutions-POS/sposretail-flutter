class BillPrinterModel {
  final String printerNames;
  final String customerNames;
  final String mobileNo;
  final String address;
  final String billNo;
  final String tableNo;
  final String items;
  final String qty;
  final String billType;
  final String header;
  final String price;
  final String amount;
  final String dateTime;
  final String lastRecord;
  final String ipAddress;
  final String is3T;
  final String iN;
   final String NP;
  final String catRemainingamount;
  final String catGrandTotal;
  final String catPayableAmount;
  final String catAmountPaid;
  final dynamic boxes;
  final dynamic pieces;

  BillPrinterModel({
    required this.printerNames,
    required this.customerNames,
    required this.mobileNo,
    required this.address,
    required this.billNo,
    required this.tableNo,
    required this.items,
    required this.qty,
    required this.billType,
    required this.header,
    required this.price,
    required this.amount,
    required this.dateTime,
    required this.lastRecord,
    required this.ipAddress,
    required this.is3T,
    required this.iN,
    required this.NP,
    required this.catAmountPaid,
    required this.catGrandTotal,
    required this.catPayableAmount,
    required this.catRemainingamount,
    this.boxes,
    this.pieces
  });

  Map<String, String> toJson() {
    return {
      'printerNames': printerNames,
      'bill_no': billNo,
      'CName':customerNames,
      'CMobile':mobileNo,
      'CAddress':customerNames,
      'tableNo': tableNo,
      'items': items,
      'qty': qty,
      'bill_type': billType,
      'header': header,
      'price': price,
      'amount': amount,
      'dateTime': dateTime,
      'last_record': lastRecord,
      'ipAddress': ipAddress,
      'is3T': is3T,
      'IN': iN,"NP": NP,
      'CatAmountPaid': catAmountPaid,
      'CatGrandTotal': catGrandTotal,
      'CatPayableAmount': catPayableAmount,
      'CatRemainingAmount': catRemainingamount,
      'boxes': boxes,
      'pieces': pieces,
    };
  }
}
