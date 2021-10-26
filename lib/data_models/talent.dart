import 'rank.dart';

class Talent {
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

  static final columns = ["classId", "specId", "id", "row", "column", "name", "icon", "requires"];

  final int classId;
  final int column;
  final String icon;
  final int id;
  final String name;
  List<Rank> ranks = List.empty();
  final int requires;
  final int row;
  final int specId;
}
