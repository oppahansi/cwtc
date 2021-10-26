class Rank {
  Rank({
    required this.talentId,
    required this.rank,
    required this.desc,
  });

  factory Rank.fromMap(Map<dynamic, dynamic> data) {
    return Rank(
      talentId: data["talentId"],
      rank: data["rank"],
      desc: data["desc"],
    );
  }

  static final columns = ["talentId", "rank", "desc"];

  final String desc;
  final int rank;
  final int talentId;
}
//
