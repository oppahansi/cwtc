import 'talent.dart';

class Spec {
  final int classId;
  final int id;
  final String name;
  final String icon;
  List<Talent> talents = List.empty();

  Spec({
    required this.classId,
    required this.id,
    required this.name,
    required this.icon,
  });
}
