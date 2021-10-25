import 'rank.dart';

class Talent {
  final int classId;
  final int specId;
  final int id;
  final int row;
  final int column;
  final String name;
  final String icon;
  List<Rank> ranks = List.empty();
  final int requires;

  Talent({
    required this.classId,
    required this.specId,
    required this.id,
    required this.row,
    required this.column,
    required this.name,
    required this.icon,
    required this.requires,
  });

  static final columns = [
    "classId",
    "specId",
    "id",
    "row",
    "column",
    "name",
    "icon",
    "requires"
  ];
  factory Talent.fromMap(Map<dynamic, dynamic> data) {
    return Talent(
      classId: data["classId"],
      specId: data["specId"],
      id: data["id"],
      row: data["row"],
      column: data["column"],
      name: data["name"],
      icon: data["icon"],
      requires: data["requires"],
    );
  }
}
