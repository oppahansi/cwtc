import '../data_models/rank.dart';
import '../constants/constants.dart';
import '../data_models/char_class.dart';
import '../data_models/spec.dart';
import '../data_models/talent.dart';

class TCService {
  Map<int, List<CharClass>> _charClassesMap = {};
  Map<int, List<Spec>> _specsMap = {};
  Map<int, List<Talent>> _talentsMap = {};
  Map<int, List<Rank>> _ranksMap = {};

  final List<List<List<int>>> _talentTreeState = [
    [
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ],
    [
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ],
    [
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ]
  ];

  int _expansionId = 0;
  int _charClassId = 0;
  int _specId = 0;
  int _pointsLeft = 0;
  int _requiredLevel = 10;

  get getCharClassCount => _charClassesMap[_expansionId]!.length;

  void resetTalentTreeState() {
    for (var i = 0; i < _talentTreeState[_expansionId][_specId].length; i++) {
      resetSpecState(i);
    }
  }

  void resetSpecState(int specId) {
    for (var i = 0; i < _talentTreeState[_expansionId][_specId].length; i++) {
      _talentTreeState[_expansionId][_specId][i] = 0;
    }
  }

  String get getClassColor => _charClassesMap[_expansionId]![_charClassId].color;

  int get getTreeLength => Constants.talentTeeLengths[_expansionId];

  void setExpansionId(int expansionId) => _expansionId = expansionId;

  int get getExpansionId => _expansionId;

  String get getExpansionFull => Constants.expansionsFull[_expansionId];

  String get getExpansionShort => Constants.expansionsShort[_expansionId];

  List<String> get getExpansionsShort => Constants.expansionsShort;

  int get getCharClassId => _charClassId;

  String get getCharClassName => _charClassesMap[_expansionId]![_charClassId].name;

  void setSpecId(int specId) => _specId = specId;

  int get getSpecId => _specId;

  void decrementPointsLeft() => _pointsLeft = Constants.availablePoints[_expansionId];

  void incrementPointsLeft() => _pointsLeft++;

  int get getPointsLeft => _pointsLeft;

  void incrementRequiredLevel() => _requiredLevel++;

  void decrementRequiredLevel() => _requiredLevel--;

  int get getRequiredLevel => _requiredLevel;

  Spec get getSpec => _specsMap[_expansionId]!.firstWhere((element) => element.id == _specId);

  Talent getTalentForIndex(int index) =>
      _talentsMap[_expansionId]!.where((element) => element.classId == _charClassId && element.specId == _specId).toList()[index];

  bool showTalentOnIndex(int index) => Constants.talentTreeLayouts[_expansionId][_charClassId][_specId][index] == 1;

  void setCharClassesMap(Map<int, List<CharClass>> charClassesMap) => _charClassesMap = charClassesMap;

  void setSpecsMap(Map<int, List<Spec>> specsMap) => _specsMap = specsMap;

  void setTalentsMap(Map<int, List<Talent>> talentsMap) => _talentsMap = talentsMap;

  void setRanksMap(Map<int, List<Rank>> ranksMap) => _ranksMap = ranksMap;

  String getCharClassIcon(int charClassId) => _charClassesMap[_expansionId]![charClassId].icon;

  void setCharClassId(int charClassId) => _charClassId = charClassId;
}
