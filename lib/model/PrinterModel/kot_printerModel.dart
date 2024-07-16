class KOTPrinterModel {
  final String printerNames;
  final String billNo;
  final String tableNo;
  final String items;
  final String qty;
  final String billType;
  final String dateTime;
  final String ipAddress;
  final String is3T;
  final String kotNo;
  final String iN;

  KOTPrinterModel({
    required this.printerNames,
    required this.billNo,
    required this.tableNo,
    required this.items,
    required this.qty,
    required this.billType,
    required this.dateTime,
    required this.ipAddress,
    required this.is3T,
    required this.kotNo,
    required this.iN,
  });



  Map<String, dynamic> toJson() {
    return {
      'printerNames': printerNames,
      'bill_no': billNo,
      'tableNo': tableNo,
      'items': items,
      'qty': qty,
      'bill_type': billType,
      'dateTime': dateTime,
      'ipAddress': ipAddress,
      'is3T': is3T,
      'kotNo': kotNo,
      'IN': iN,
    };
  }
}
