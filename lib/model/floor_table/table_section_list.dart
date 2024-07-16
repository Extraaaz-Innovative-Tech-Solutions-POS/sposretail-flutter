class TableSectionList {
  String floorNumber;
  String sectionId;
  String sectionName;
  String ?tables;

  TableSectionList({
    required this.floorNumber,
    required this.sectionId,
    required this.sectionName,
    required this.tables,
  });

  factory TableSectionList.fromJson(Map<String, dynamic> json) {
    return TableSectionList(
      floorNumber: json['floor_number'].toString(),
      sectionId: json['section_id'].toString(),
      sectionName: json['section_name'].toString(),
      tables: json['tables'].toString(),
    );
  }
}
