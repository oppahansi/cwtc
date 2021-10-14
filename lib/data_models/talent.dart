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
}
