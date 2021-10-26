import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../data_models/char_class.dart';
import '../data_models/dependency.dart';
import '../data_models/rank.dart';
import '../data_models/spec.dart';
import '../data_models/talent.dart';

class TCService {
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
      [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ],
      [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ],
      [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ],
    ]
  ];

  Map<int, List<CharClass>> _charClassesMap = {};
  Map<int, List<Spec>> _specsMap = {};
  Map<int, List<Talent>> _talentsMap = {};
  Map<int, List<Rank>> _ranksMap = {};
  Map<int, List<Dependency>> _dependenciesMap = {};

  int _expansionId = 0;
  int _charClassId = 0;
  int _specId = 0;
  int _pointsLeft = 0;
  int _requiredLevel = 10;
  int _spentPoints = 0;
  int _talentIndex = 0;

  int get getCharClassCount => _charClassesMap[_expansionId]!.length;

  Color get getExpansionColor => Constants.expansionColors[_expansionId];

  String getSpecIcon(specId) =>
      _specsMap[_expansionId]!.firstWhere((element) => element.classId == _charClassId && element.id == specId).icon;

  Talent getTalent() => _talentsMap[_expansionId]!
      .where((element) => element.classId == _charClassId && element.specId == _specId)
      .toList()[_talentIndex++];

  String get getClassColor => _charClassesMap[_expansionId]![_charClassId].color;

  int get getTreeLength => Constants.talentTeeLengths[_expansionId];

  void setExpansionId(int expansionId) => _expansionId = expansionId;

  int get getExpansionId => _expansionId;

  String get getExpansionFull => Constants.expansionsFull[_expansionId];

  String get getExpansionShort => Constants.expansionsShort[_expansionId];

  List<String> get getExpansionsShort => Constants.expansionsShort;

  int get getCharClassId => _charClassId;

  String get getCharClassName => _charClassesMap[_expansionId]![_charClassId].name;

  void setSpecId(int specId) {
    _specId = specId;
    _talentIndex = 0;
  }

  int get getSpecId => _specId;

  void decrementPointsLeft() => _pointsLeft--;

  void incrementPointsLeft() => _pointsLeft++;

  int get getPointsLeft => _pointsLeft;

  void incrementSpentPoints() => _spentPoints++;

  int get getSpentPoints => _spentPoints;

  void incrementRequiredLevel() => _requiredLevel++;

  void decrementRequiredLevel() => _requiredLevel--;

  int get getRequiredLevel => _requiredLevel;

  Spec get getSpec => _specsMap[_expansionId]!.firstWhere((element) => element.id == _specId);

  Talent getTalentForIndex(int talentIndex) => _talentsMap[_expansionId]!
      .where((element) => element.classId == _charClassId && element.specId == _specId)
      .toList()[talentIndex];

  bool showTalentOnIndex(int index) => Constants.talentTreeLayouts[_expansionId][_charClassId][_specId][index] == 1;

  void setCharClassesMap(Map<int, List<CharClass>> charClassesMap) => _charClassesMap = charClassesMap;

  void setSpecsMap(Map<int, List<Spec>> specsMap) => _specsMap = specsMap;

  void setTalentsMap(Map<int, List<Talent>> talentsMap) => _talentsMap = talentsMap;

  void setRanksMap(Map<int, List<Rank>> ranksMap) => _ranksMap = ranksMap;

  void setDependenciesMap(Map<int, List<Dependency>> dependenciesMap) => _dependenciesMap = dependenciesMap;

  String getCharClassIcon(int charClassId) => _charClassesMap[_expansionId]![charClassId].icon;

  void setCharClassId(int charClassId) {
    _charClassId = charClassId;
    _specId = 0;
    _specId = 0;
    _pointsLeft = Constants.availablePoints[_expansionId];
    _requiredLevel = 10;
    _spentPoints = 0;

    resetTalentTreeState();
  }

  void mapData() {
    for (var expansion in _charClassesMap.keys) {
      for (var charClass in _charClassesMap[_expansionId]!) {
        List<Spec> specs = _specsMap[expansion]!.where((element) => element.classId == charClass.id).toList();

        for (var spec in specs) {
          List<Talent> talents = _talentsMap[expansion]!
              .where((element) => element.specId == spec.id && element.classId == charClass.id)
              .toList();

          for (var talent in talents) {
            List<Rank> ranks = _ranksMap[expansion]!.where((element) => element.talentId == talent.id).toList();
            talent.ranks = ranks;
          }

          spec.talents = talents;
        }

        charClass.specs = specs;
      }
    }
  }

  bool talentEnablesAnother(int talentId) {
    var dependencies = _dependenciesMap[_expansionId];
    var dependency =
        dependencies!.firstWhere((element) => element.requires == talentId, orElse: () => dependencies.first);

    return dependency.requires == talentId;
  }

  int getTalentPoints(int talentTreePosition) => _talentTreeState[_expansionId][_specId][talentTreePosition];

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

  String getSpecName(int specId) =>
      _specsMap[_expansionId]!.firstWhere((element) => element.classId == _charClassId && element.id == specId).name;
}
