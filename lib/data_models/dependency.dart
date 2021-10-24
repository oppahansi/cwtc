class Dependency {
  final int talentId;
  final int requires;
  final int arrowType;

  Dependency({required this.talentId, required this.requires, required this.arrowType});

  static final columns = ["talentId", "requires", "arrowType"];
  factory Dependency.fromMap(Map<dynamic, dynamic> data) {
    return Dependency(
      talentId: data["talentId"],
      requires: data["requires"],
      arrowType: data["arrowType"],
    );
  }
}
