import 'spec.dart';

class CharClass {
  CharClass({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  factory CharClass.fromMap(Map<dynamic, dynamic> data) {
    return CharClass(
      id: data["id"],
      name: data["name"],
      color: data["color"],
      icon: data["icon"],
    );
  }

  static final columns = ["id", "name", "color", "icon"];

  final String color;
  final String icon;
  final int id;
  final String name;
  List<Spec> specs = List.empty(growable: true);
}
