class CharClass {
  final int id;
  final String name;
  final String color;
  final String icon;

  CharClass({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  static final columns = ["id", "name", "color", "icon"];
  factory CharClass.fromMap(Map<dynamic, dynamic> data) {
    return CharClass(
      id: data["id"],
      name: data["name"],
      color: data["color"],
      icon: data["icon"],
    );
  }
}
