class SequencePoint {
  static const columns = ["expansionId", "charClassId", "specId", "talentIndex", "buildId", "sequencePoint", "talentIcon", "rank"];

  final int expansionId;
  final int charClassId;
  final int specId;
  final int talentIndex;
  final int buildId;
  final int sequencePoint;
  final String talentIcon;
  final int rank;

  SequencePoint({
    required this.expansionId,
    required this.charClassId,
    required this.specId,
    required this.talentIndex,
    required this.buildId,
    required this.sequencePoint,
    required this.talentIcon,
    required this.rank,
  });

  factory SequencePoint.fromMap(Map<dynamic, dynamic> data) {
    return SequencePoint(
      expansionId: data["expansionId"],
      charClassId: data["charClassId"],
      specId: data["specId"],
      talentIndex: data["talentIndex"],
      buildId: data["buildId"],
      sequencePoint: data["sequencePoint"],
      talentIcon: data["talentIcon"],
      rank: data["rank"],
    );
  }
}
