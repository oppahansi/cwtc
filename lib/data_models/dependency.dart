class Dependency {
  final int talentId;
  final int requires;

  Dependency({required this.talentId, required this.requires});

  static final columns = ["talentId", "requires"];
  factory Dependency.fromMap(Map<dynamic, dynamic> data) {
    return Dependency(
      talentId: data["talentId"],
      requires: data["requires"],
    );
  }
}
