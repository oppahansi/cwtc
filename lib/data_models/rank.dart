class Rank {
  final int talentId;
  final int rank;
  final String desc;

  Rank({
    required this.talentId,
    required this.rank,
    required this.desc,
  });

  static final columns = ["talentId", "rank", "desc"];
  factory Rank.fromMap(Map<dynamic, dynamic> data) {
    return Rank(
      talentId: data["talentId"],
      rank: data["rank"],
      desc: data["desc"],
    );
  }
}
//
