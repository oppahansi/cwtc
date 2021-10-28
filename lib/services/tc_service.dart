import 'package:flutter/material.dart';
import 'package:wow_talent_calculator/wow_talent_calculator.dart';

import '../constants/constants.dart';
import '../data_models/char_class.dart';
import '../data_models/dependency.dart';
import '../data_models/rank.dart';
import '../data_models/spec.dart';
import '../data_models/talent.dart';

class TCService {
  int _charClassId = 0;
  int _expansionId = 0;

  Map<int, List<CharClass>> _charClassesMap = {};
  Map<int, List<Spec>> _specsMap = {};
  Map<int, Map<int, Map<int, List<Talent>>>> _talentsMap = {};
  Map<int, List<Rank>> _ranksMap = {};
  Map<int, List<Dependency>> _dependenciesMap = {};

  WowTalentCalculator _wtc = WowTalentCalculator();

  int get getCharClassCount => _charClassesMap[_expansionId]!.length;

  Color get getExpansionColor => Constants.expansionColors[_expansionId];

  int get getMaxTalentTreeRows => TalentCalculatorConstants.maxTalentTreeRows[_expansionId];

  String getSpecIcon(specId) => _specsMap[_expansionId]!.firstWhere((element) => element.classId == _charClassId && element.id == specId).icon;

  Talent getTalentFor(int index) => _talentsMap[_expansionId]![_charClassId]![_wtc.getSpecId]![index];

  String get getClassColor => _charClassesMap[_expansionId]![_charClassId].color;

  int get getTreeLength => Constants.talentTeeLengths[_expansionId];

  void setExpansionId(int expansionId) => _expansionId = expansionId;

  int get getExpansionId => _expansionId;

  String get getExpansionFull => Constants.expansionsFull[_expansionId];

  String get getExpansionShort => Constants.expansionsShort[_expansionId];

  List<String> get getExpansionsShort => Constants.expansionsShort;

  int get getCharClassId => _charClassId;

  String get getCharClassName => _charClassesMap[_expansionId]![_charClassId].name;

  void setSpecId(int specId) => _wtc.setSpecId(specId);

  int get getSpecId => _wtc.getSpecId;

  bool showTalentOnIndex(int index) => !_wtc.isPositionEmptyAt(index);

  void setCharClassesMap(Map<int, List<CharClass>> charClassesMap) => _charClassesMap = charClassesMap;

  void setSpecsMap(Map<int, List<Spec>> specsMap) => _specsMap = specsMap;

  void setTalentsMap(Map<int, Map<int, Map<int, List<Talent>>>> talentsMap) => _talentsMap = talentsMap;

  void setRanksMap(Map<int, List<Rank>> ranksMap) => _ranksMap = ranksMap;

  void setDependenciesMap(Map<int, List<Dependency>> dependenciesMap) => _dependenciesMap = dependenciesMap;

  String getCharClassIcon(int charClassId) => _charClassesMap[_expansionId]![charClassId].icon;

  void setCharClassId(int charClassId) {
    _charClassId = charClassId;
    resetTalentTreeState();
  }

  void mapData() {
    for (var expansion in Expansions.values) {
      for (var charClass in _charClassesMap[_expansionId]!) {
        List<Spec> specs = _specsMap[expansion.index]!.where((element) => element.classId == charClass.id).toList();

        for (var spec in specs) {
          List<Talent> talents = _talentsMap[expansion.index]![charClass.id]![spec.id]!;

          for (var talent in talents) {
            List<Rank> ranks = _ranksMap[expansion.index]!.where((element) => element.talentId == talent.id).toList();
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
    var dependency = dependencies!.firstWhere((element) => element.requires == talentId, orElse: () => dependencies.first);

    return dependency.requires == talentId;
  }

  int getTalentPoints(int talentTreeIndex) => _wtc.getInvestedPointsAt(talentTreeIndex);

  void resetTalentTreeState() {
    _wtc.resetAll();
  }

  void resetSpecState({int specId = -1}) {
    _wtc.resetSpec(specId: specId < 0 ? _wtc.getSpecId : specId);
  }

  String getSpecName(int specId) => _specsMap[_expansionId]!.firstWhere((element) => element.classId == _charClassId && element.id == specId).name;

  void initTalentCalculator() => _wtc = WowTalentCalculator(expansionId: _expansionId, charClassId: _charClassId);
}
