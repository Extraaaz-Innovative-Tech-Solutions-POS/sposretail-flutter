class KotDesktopModel {
  final String printerNames;
  final String billType;
  final String tableNo;
  final String items;
  final String qty;
  final String dateTime;
  final String is3T;
  final String kotNo;

  KotDesktopModel({
    required this.printerNames,
    required this.billType,
    required this.tableNo,
    required this.items,
    required this.qty,
    required this.dateTime,
    required this.is3T,
    required this.kotNo,
  });

  Map<String, String> toJson() {
    return {
      'printerNames': printerNames,
      'bill_type': billType,
      'tableNo': tableNo,
      'items': items,
      'qty': qty,
      'dateTime': dateTime,
      'is3T': is3T,
      'kotNo': kotNo,
    };
  }
}
