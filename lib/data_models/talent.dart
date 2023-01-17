import 'rank.dart';

class Talent {
  static final columns = ["classId", "specId", "id", "row", "column", "name", "icon", "requires"];

  final int classId;
  final int column;
  final String icon;
  final int id;
  final String name;
  final int requires;
  final int row;
  final int specId;

  List<Rank> ranks = List.empty();
  int index = 0;

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
