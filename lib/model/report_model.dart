class ResultsData {
  dynamic totalInvoice;
  dynamic totalSale;
  dynamic products;

  ResultsData(
      {required this.totalInvoice,
      required this.totalSale,
      required this.products});

  factory ResultsData.fromJson(Map<String, dynamic> json) {
    return ResultsData(
      totalInvoice: json['total_invoice'],
      totalSale: json['total_sale'],
      products: json['products'],
    );
  }
}
