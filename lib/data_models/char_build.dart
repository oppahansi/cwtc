class CharBuild {
  static const columns = ["expansionId", "charClassId", "specId", "title", "summary", "specState0", "specState1", "specState2"];

  final int expansionId;
  final int charClassId;
  final int buildId;
  final String title;
  final String summary;
  final String specState0;
  final String specState1;
  final String specState2;

  CharBuild({
    required this.expansionId,
    required this.charClassId,
    required this.buildId,
    required this.title,
    required this.summary,
    required this.specState0,
    required this.specState1,
    required this.specState2,
  });

  factory CharBuild.fromMap(Map<dynamic, dynamic> data) {
    return CharBuild(
      expansionId: data["expansionId"],
      charClassId: data["charClassId"],
      buildId: data["buildId"],
      title: data["title"],
      summary: data["summary"],
      specState0: data["specState0"],
      specState1: data["specState1"],
      specState2: data["specState2"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "expansionId": expansionId,
      "charClassId": charClassId,
      "buildId": buildId,
      "title": title,
      "summary": summary,
      "specState0": specState0,
      "specState1": specState1,
      "specState2": specState2,
    };
  }
}
