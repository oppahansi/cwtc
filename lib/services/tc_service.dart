import 'package:classic_wow_talent_calculator_stacked/data_models/rank.dart';

import '../constants/constants.dart';
import '../data_models/char_class.dart';
import '../data_models/spec.dart';
import '../data_models/talent.dart';

class TCService {
  static const List<String> _expansionsFull = ["Vanilla", "The Burning Crusade", "Wrath of the Lich King"];
  static const List<String> _expansionsShort = ["Vanilla", "Tbc", "Wotlk"];
  static const List<int> _availablePoints = [51, 61, 71];

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
  int _specId = 0;
  int _pointsLeft = 0;
  int _requiredLevel = 10;

  CharClass? _charClass;
  List<Spec> _specs = List.empty(growable: true);
  List<Talent> _talents = List.empty(growable: true);
  List<Rank> _ranks = List.empty(growable: true);

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

  String get getClassColor => _charClass!.color;

  int get getTreeLength => _talentTreeState[_expansionId][_specId].length;

  void setExpansionId(int expansionId) => _expansionId = expansionId;

  int get getExpansionId => _expansionId;

  String get getExpansionFull => _expansionsFull[_expansionId];

  String get getExpansionShort => _expansionsShort[_expansionId];

  void setCharClass(CharClass charClass) => _charClass = charClass;

  int get getCharClassId => _charClass!.id;

  String get getCharClassName => _charClass!.name;

  void setSpecId(int specId) => _specId = specId;

  int get getSpecId => _specId;

  void setPointsLeft() => _pointsLeft = _availablePoints[_expansionId];

  int get getPointsLeft => _pointsLeft;

  void setRequiredLevel(int requiredLevel) => _requiredLevel = requiredLevel;

  int get getRequiredLevel => _requiredLevel;

  void setSpecs(List<Spec> specs) => _specs = specs;

  Spec get getSpec => _specs[_specId];

  void setTalents(List<Talent> talents) => _talents = talents;

  List<Talent> get getTalents => _talents;

  void setRanks(List<Rank> ranks) {
    _ranks = ranks;
    assignRanksToTalents();
  }

  void assignRanksToTalents() {
    for (Talent talent in _talents) {
      List<Rank> ranks = _ranks.where((element) => element.talentId == talent.id).toList();
      talent.ranks = ranks;
    }
  }

  Talent getTalentForIndex(int index) => _talents[index];

  bool showTalentOnIndex(int index) => Constants.talentTreeLayouts[_expansionId][_charClass!.id][_specId][index] == 1;
}
