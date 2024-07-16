class DashboardData {
  bool? success;
  int? todaySales;
  int? unsettledAmount;
  int? todayOrderCount;
  int? todayinvoices;
  String? yesterdaySaleTotal;
  int? monthlyInvoices;
  int? monthlyOrders;
  String? monthlySales;
  String? totalSaleAmount;

  DashboardData(
      {this.success,
      this.todaySales,
      this.unsettledAmount,
      this.todayOrderCount,
      this.todayinvoices,
      this.yesterdaySaleTotal,
      this.monthlyInvoices,
      this.monthlyOrders,
      this.monthlySales,
      this.totalSaleAmount});

  DashboardData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    todaySales = json['todaySales'];
    unsettledAmount = json['unsettledAmount'];
    todayOrderCount = json['todayOrderCount'];
    todayinvoices = json['todayinvoices'];
    yesterdaySaleTotal = json['yesterdaySaleTotal'];
    monthlyInvoices = json['monthlyInvoices'];
    monthlyOrders = json['monthlyOrders'];
    monthlySales = json['monthlySales'];
    totalSaleAmount = json['totalSaleAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['todaySales'] = this.todaySales;
    data['unsettledAmount'] = this.unsettledAmount;
    data['todayOrderCount'] = this.todayOrderCount;
    data['todayinvoices'] = this.todayinvoices;
    data['yesterdaySaleTotal'] = this.yesterdaySaleTotal;
    data['monthlyInvoices'] = this.monthlyInvoices;
    data['monthlyOrders'] = this.monthlyOrders;
    data['monthlySales'] = this.monthlySales;
    data['totalSaleAmount'] = this.totalSaleAmount;
    return data;
  }
}
