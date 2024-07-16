import 'dart:convert';

Graph graphFromJson(String str) => Graph.fromJson(json.decode(str));

String graphToJson(Graph data) => json.encode(data.toJson());

class Graph {
    DateTime date;
    String totalPayment;

    Graph({
        required this.date,
        required this.totalPayment,
    });

    factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        date: DateTime.parse(json["date"]),
        totalPayment: json["total_payment"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "total_payment": totalPayment,
    };
}
