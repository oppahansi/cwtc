class Dependency {
  static final columns = ["talentId", "requires", "arrowType"];

  final int talentId;
  final int requires;
  final int arrowType;

  Dependency({
    required this.talentId,
    required this.requires,
    required this.arrowType,
  });

  factory Dependency.fromMap(Map<dynamic, dynamic> data) {
    return Dependency(
      talentId: data["talentId"],
      requires: data["requires"],
      arrowType: data["arrowType"],
    );
  }
}
