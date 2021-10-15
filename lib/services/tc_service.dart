import 'package:classic_wow_talent_calculator_stacked/data_models/char_class.dart';

import '../../app/app.locator.dart';
import '../../data_models/spec.dart';
import '../../data_models/talent.dart';
import '../../services/db_service.dart';

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

  final _dbService = locator<DBService>();

  int _expansionId = 0;
  int _specId = 0;
  int _pointsLeft = 0;
  int _requiredLevel = 10;

  CharClass? _charClass;
  List<Spec> _specs = List.empty(growable: true);
  List<Talent> _talents = List.empty(growable: true);

  String get getClassColor => _charClass!.color;

  void resetTalentTreeState() {
    for (var i = 0; i < _talentTreeState[_expansionId][_specId].length; i++) {
      resetSpecState(i);
    }
  }

  void resetSpecState(int specId) {
    for (var i = 0; i < _talentTreeState[_expansionId][_specId].length; i++) {
      _talentTreeState[_expansionId][_charClass!.id][_specId][i] = 0;
    }
  }

  void setExpansionId(int expansionId) => _expansionId = expansionId;

  int get getExpansionId => _expansionId;

  String get getExpansionFull => _expansionsFull[_expansionId];

  String get getExpansionShort => _expansionsShort[_expansionId];

  void setCharClass(CharClass charClass) => _charClass = charClass;

  int get getCharClassId => _charClass!.id;

  get getClassName => _charClass!.name;

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

  String get getSpecBg => "assets/images/bgs/${_charClass!.name.toLowerCase()}$_specId.png";
}
