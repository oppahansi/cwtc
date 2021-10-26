import 'talent.dart';

class Spec {
  Spec({
    required this.classId,
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Spec.fromMap(Map<dynamic, dynamic> data) {
    return Spec(
      classId: data["classId"],
      id: data["id"],
      name: data["name"],
      icon: data["icon"],
    );
  }

  static final columns = ["classId", "id", "name", "icon"];

  final int classId;
  final String icon;
  final int id;
  final String name;
  List<Talent> talents = List.empty();
}
