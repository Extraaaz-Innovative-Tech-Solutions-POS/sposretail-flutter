class ActiveTables {
  bool? success;
  List<Data>? data;

  ActiveTables({this.success, this.data});

  ActiveTables.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? floorId;
  int? sectionId;
  String? sectionName;
  int? tableNumber;
  int? dividedBy;
  List<TableData>? tableData;

  Data(
      {this.floorId,
      this.sectionId,
      this.sectionName,
      this.tableNumber,
      this.dividedBy,
      this.tableData});

  Data.fromJson(Map<String, dynamic> json) {
    floorId = json['floor_id'];
    sectionId = json['section_id'];
    sectionName = json['section_name'];
    tableNumber = json['table_number'];
    dividedBy = json['divided_by'];
    if (json['table_data'] != null) {
      tableData = <TableData>[];
      json['table_data'].forEach((v) {
        tableData!.add(TableData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['floor_id'] = floorId;
    data['section_id'] = sectionId;
    data['section_name'] = sectionName;
    data['table_number'] = tableNumber;
    data['divided_by'] = dividedBy;
    if (tableData != null) {
      data['table_data'] = tableData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableData {
  int? id;
  String? tableId;
  String? splitTableNumber;
  int? dividedBy;
  Null? coverCount;
  String? createdAt;
  String? updatedAt;

  TableData(
      {this.id,
      this.tableId,
      this.splitTableNumber,
      this.dividedBy,
      this.coverCount,
      this.createdAt,
      this.updatedAt});

  TableData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableId = json['table_id'];
    splitTableNumber = json['split_table_number'];
    dividedBy = json['divided_by'];
    coverCount = json['cover_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['table_id'] = tableId;
    data['split_table_number'] = splitTableNumber;
    data['divided_by'] = dividedBy;
    data['cover_count'] = coverCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
