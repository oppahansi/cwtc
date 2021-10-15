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

  static final columns = ["classId", "id", "name", "icon"];
  factory Spec.fromMap(Map<dynamic, dynamic> data) {
    return Spec(
      classId: data["classId"],
      id: data["id"],
      name: data["name"],
      icon: data["icon"],
    );
  }
}
