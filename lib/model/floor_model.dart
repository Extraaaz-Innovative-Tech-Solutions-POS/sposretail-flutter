class FloorModel {
  bool? success;
  String? message;
  List<Floors>? floors;
  List<Tables>? tables;

  FloorModel({this.success, this.message, this.floors, this.tables});

  FloorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['floors'] != null) {
      floors = <Floors>[];
      json['floors'].forEach((v) {
        floors!.add(new Floors.fromJson(v));
      });
    }
    if (json['tables'] != null) {
      tables = <Tables>[];
      json['tables'].forEach((v) {
        tables!.add(new Tables.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.floors != null) {
      data['floors'] = this.floors!.map((v) => v.toJson()).toList();
    }
    if (this.tables != null) {
      data['tables'] = this.tables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Floors {
  int? floor;

  Floors({this.floor});

  Floors.fromJson(Map<String, dynamic> json) {
    floor = json['floor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor'] = this.floor;
    return data;
  }
}

class Tables {
  int? floorNumber;
  int? tables;

  Tables({this.floorNumber, this.tables});

  Tables.fromJson(Map<String, dynamic> json) {
    floorNumber = json['floor_number'];
    tables = json['tables'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor_number'] = this.floorNumber;
    data['tables'] = this.tables;
    return data;
  }
}