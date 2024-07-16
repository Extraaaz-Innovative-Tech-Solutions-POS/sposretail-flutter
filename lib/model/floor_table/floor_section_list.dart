class FloorSectionList {
    String id;
    String restaurantId;
    String floorName;
    List<SectionList> sections;

    FloorSectionList({
        required this.id,
        required this.restaurantId,
        required this.floorName,
        required this.sections,
    });


    factory FloorSectionList.fromJson(Map<String, dynamic> json) {

       var list = json['sections'] as List;
    List<SectionList> sectionList = list.map((i) => SectionList.fromJson(i)).toList();

    return FloorSectionList(

      


      id: json['id'].toString(),
      restaurantId: json['restaurant_id'].toString(),
      floorName: json['floor_name'].toString(),
      sections: sectionList, 
      // ( json['sections'] as List).cast<Map<String, dynamic>>(),
    );
  }

}

class SectionList {
    String id;
    String name;
    String tablesCount;

    SectionList({
        required this.id,
        required this.name,
        required this.tablesCount,
    });

    factory SectionList.fromJson(Map<String, dynamic> json) {
    return SectionList(
      id: json['id'].toString(),
      name: json['name'].toString(),
      tablesCount: json['tables_count'].toString(),
    );
  }

}

