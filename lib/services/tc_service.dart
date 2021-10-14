class TCService {
  static const List<String> _expansionsFull = ["Vanilla", "The Burning Crusade", "Wrath of the Lich King"];
  static const List<String> _expansionsShort = ["Vanilla", "Tbc", "Wotlk"];
  static const List<int> _availablePoints = [51, 61, 71];

  final List<List<List<List<int>>>> _talentTreeState = [
    [
      [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      ]
    ],
    [
      [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      ]
    ],
    [
      [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      ]
    ],
  ];

  int _expansionId = 0;
  int _charClassId = 0;
  int _specId = 0;
  int _pointsLeft = 0;
  int _requiredLevel = 10;

  int get getExpansion => _expansionId;

  String get getExpansionFull => _expansionsFull[_expansionId];

  String get getExpansionShort => _expansionsShort[_expansionId];

  void setExpansion(int expansionId) => _expansionId = expansionId;

  void setCharClass(int charClassId) => _charClassId = charClassId;

  int get charClassId => _charClassId;

  void setSpecId(int specId) => _specId = specId;

  int get getSpecId => _specId;

  void setPointsLeft() => _pointsLeft = _availablePoints[_expansionId];

  int get getPointsLeft => _pointsLeft;

  void setRequiredLevel(int requiredLevel) => _requiredLevel = requiredLevel;

  int get getRequiredLevel => _requiredLevel;

  void resetTalentTreeState() {
    for (var i = 0; i < _talentTreeState[_expansionId][_specId].length; i++) {
      for (var j = 0; j < _talentTreeState[_expansionId][_specId].length; j++) {
        _talentTreeState[_expansionId][_charClassId][i][j] = 0;
      }
    }
  }
}
