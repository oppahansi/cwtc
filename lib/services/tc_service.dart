import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:wow_talent_calculator/wow_talent_calculator.dart';

import '../app/app.locator.dart';
import '../constants/constants.dart';
import '../data_models/char_build.dart';
import '../data_models/char_class.dart';
import '../data_models/dependency.dart';
import '../data_models/rank.dart';
import '../data_models/sequence_point.dart' as app_model;
import '../data_models/settings.dart';
import '../data_models/spec.dart';
import '../data_models/talent.dart';
import '../extensions/extensions.dart';
import 'db_service.dart';

@lazySingleton
class TCService with ReactiveServiceMixin {
  final _dbService = locator<DBService>();

  final List<ReactiveList<bool>> _availabilityStates = [];
  final List<ReactiveList<bool>> _maxedOutStates = [];
  final ReactiveValue<bool> _allPointsSpent = ReactiveValue(false);
  final ReactiveValue<bool> _showToolTips = ReactiveValue(false);

  int _expansionId = 0;
  int _charClassId = 0;
  int _specId = 0;
  int _charBuildId = -1;

  Map<int, List<CharClass>> _charClassesMap = {};
  Map<int, List<Spec>> _specsMap = {};
  Map<int, Map<int, Map<int, List<Talent>>>> _talentsMap = {};
  Map<int, List<Rank>> _ranksMap = {};
  Map<int, List<Dependency>> _dependenciesMap = {};
  Map<int, List<CharBuild>> _charBuildsMap = {};
  Map<int, List<app_model.SequencePoint>> _buildSequencesMap = {};

  WowTalentCalculator _wtc = WowTalentCalculator();

  TCService() {
    listenToReactiveValues([_allPointsSpent, _showToolTips]);
  }

  void investPointAt(int specId, int index) {
    _wtc.investPointAt(specId, index);
    _updateStates();
  }

  void removePointAt(int specId, int index) {
    _wtc.removePointAt(specId, index);
    _updateStates();
  }

  void mapData() {
    for (var expansion in Expansions.values) {
      for (var charClass in _charClassesMap[expansion.index]!) {
        List<Spec> specs = _specsMap[expansion.index]!.where((spec) => spec.classId == charClass.id).toList();

        for (var spec in specs) {
          List<Talent> talents = _talentsMap[expansion.index]![charClass.id]![spec.id]!;

          for (var talent in talents) {
            List<Rank> ranks = _ranksMap[expansion.index]!.where((rank) => rank.talentId == talent.id).toList();
            talent.ranks = ranks;
          }

          spec.talents = talents;
        }

        charClass.specs = specs;
      }
    }
  }

  void initTalentCalculator() {
    _charBuildId = -1;
    _wtc = WowTalentCalculator(expansionId: _expansionId, charClassId: _charClassId);
    _initAvailabilityStates();
    _initMaexedOutStates();

    listenToReactiveValues([..._availabilityStates, ..._maxedOutStates]);
  }

  void resetSpec() {
    _wtc.resetSpec(_specId);
    _updateStates();
  }

  void resetAll() {
    _wtc.resetAll();
    _updateStates();
  }

  void saveCharBuild(String title) {
    int spentPointsSpec0 = getSpentPoints(0);
    int spentPointsSpec1 = getSpentPoints(1);
    int spentPointsSpec2 = getSpentPoints(2);
    String summary = "$getCharClassName - $spentPointsSpec0/$spentPointsSpec1/$spentPointsSpec2";

    List<List<int>> treeStates = _wtc.getTreeStates;
    String specState0 = treeStates[0].join(",");
    String specState1 = treeStates[1].join(",");
    String specState2 = treeStates[2].join(",");

    CharBuild charBuild = CharBuild(
      expansionId: _expansionId,
      charClassId: _charClassId,
      buildId: _charBuildsMap[_expansionId]!.length,
      title: title,
      summary: summary,
      specState0: specState0,
      specState1: specState1,
      specState2: specState2,
    );

    List<app_model.SequencePoint> buildSequence = getBuildSequence();

    _dbService.saveBuild(charBuild, buildSequence);
    _charBuildsMap[_expansionId]!.add(charBuild);
    _buildSequencesMap[_expansionId]!.addAll(buildSequence);
  }

  void updateCharBuild(String title) {
    int spentPointsSpec0 = getSpentPoints(0);
    int spentPointsSpec1 = getSpentPoints(1);
    int spentPointsSpec2 = getSpentPoints(2);
    String summary = "$getCharClassName - $spentPointsSpec0/$spentPointsSpec1/$spentPointsSpec2";

    List<List<int>> treeStates = _wtc.getTreeStates;
    String specState0 = treeStates[0].join(",");
    String specState1 = treeStates[1].join(",");
    String specState2 = treeStates[2].join(",");

    CharBuild charBuild = CharBuild(
      expansionId: _expansionId,
      charClassId: _charClassId,
      buildId: _charBuildId,
      title: title,
      summary: summary,
      specState0: specState0,
      specState1: specState1,
      specState2: specState2,
    );

    List<app_model.SequencePoint> buildSequence = getBuildSequence();

    _dbService.updateBuild(charBuild, buildSequence);
    CharBuild charBuildToUpdate = _charBuildsMap[_expansionId]!.firstWhere((element) => element.buildId == _charBuildId);
    int index = _charBuildsMap[_expansionId]!.indexOf(charBuildToUpdate);
    _charBuildsMap[_expansionId]![index] = charBuild;
    _buildSequencesMap[_expansionId]!
        .removeWhere((element) => element.buildId == _charBuildId && element.expansionId == _expansionId && element.charClassId == _charClassId);
    _buildSequencesMap[_expansionId]!.addAll(buildSequence);
  }

  void deleteCharBuild(CharBuild charBuild) {
    _dbService.deleteCharBuild(charBuild);
    _charBuildsMap.remove(charBuild);
  }

  void saveShowTooltips(int showTooltips) {
    _showToolTips.value = showTooltips == 1;
    _dbService.saveShowTooltips(showTooltips);
  }

  bool isPositionEmptyAt(int specId, int index) => _wtc.isPositionEmptyAt(specId, index);

  bool isTalentAvailableAt(int specId, int index) => _availabilityStates[specId][index];

  bool isTalentMaxedOutAt(int specId, int index) => _wtc.isTalentMaxedOutAt(specId, index);

  bool canRemovePointAt(int specId, int index) => _wtc.canRemovePointAt(specId, index);

  String getShareableLink([CharBuild? charBuild]) {
    String baseLink = "";
    String talentPointsPart = "";
    List<List<int>> treeStates = List.empty(growable: true);

    if (charBuild != null) {
      List<String> specState0 = charBuild.specState0.split(",");
      List<String> specState1 = charBuild.specState1.split(",");
      List<String> specState2 = charBuild.specState2.split(",");
      treeStates.add(specState0.map(int.parse).toList());
      treeStates.add(specState1.map(int.parse).toList());
      treeStates.add(specState2.map(int.parse).toList());
    } else {
      treeStates = _wtc.getTreeStates;
    }

    switch (_expansionId) {
      case 0:
      case 1:
        baseLink = Constants.wowHeadBaseUrls[_expansionId] + CharClasses.values[charBuild == null ? _charClassId : charBuild.charClassId].toShortString() + "/";

        for (int specId = 0; specId < treeStates.length; specId++) {
          for (int index = 0; index < treeStates[specId].length; index++) {
            if (treeStates[specId][index] >= 0) {
              talentPointsPart = talentPointsPart + treeStates[specId][index].toString();
            }
          }

          if (specId <= 1) {
            talentPointsPart = talentPointsPart + "-";
          }
        }
        break;
      case 2:
        baseLink = Constants.twinstarBaseUrls[_charClassId];

        for (int specId = 0; specId < treeStates.length; specId++) {
          for (int index = 0; index < treeStates[specId].length; index++) {
            if (treeStates[specId][index] >= 0) {
              talentPointsPart = talentPointsPart + treeStates[specId][index].toString();
            }
          }
        }
        break;
    }

    return baseLink + talentPointsPart;
  }

  Talent getTalentFor(int specId, int index) => _talentsMap[_expansionId]![_charClassId]![specId]![index];

  Talent getTalentForPosition(int specId, int row, int column) =>
      _talentsMap[_expansionId]![_charClassId]![specId]!.firstWhere((talent) => talent.row == row && talent.column == column);

  String getSpecIcon(int specId) => _specsMap[_expansionId]!.firstWhere((spec) => spec.classId == _charClassId && spec.id == specId).icon;

  String getSpecName(int specId) => _specsMap[_expansionId]!.firstWhere((spec) => spec.classId == _charClassId && spec.id == specId).name;

  String getCharClassIcon(int charClassId) => _charClassesMap[_expansionId]![charClassId].icon;

  int getInvestedPointsAt(int specId, int index) => _wtc.getInvestedPointsAt(specId, index);

  int getDependeesAmount(int specId, int index) => _wtc.getDependeesAmount(specId, index);

  List<Dependency> getDependencies(int id) => _dependenciesMap[_expansionId]!.where((dependency) => dependency.requires == id).toList();

  Talent getTalentWithId(int specId, int id) => _talentsMap[_expansionId]![_charClassId]![specId]!.firstWhere((talent) => talent.id == id);

  int getSpentPoints([int specId = -1]) => _wtc.getSpentPoints(specId);

  int get getMaxTalentPoints => _wtc.getMaxTalentPoints;

  String get getClassColor => _charClassesMap[_expansionId]![_charClassId].color;

  int get getTreeLength => Constants.talentTeeLengths[_expansionId];

  int get getExpansionId => _expansionId;

  String get getExpansionFull => Constants.expansionsFull[_expansionId];

  String get getCharClassName => _charClassesMap[_expansionId]![_charClassId].name;

  Color get getExpansionColor => Constants.expansionColors[_expansionId];

  int get getMaxTalentTreeRows => TalentCalculatorConstants.maxTalentTreeRows[_expansionId];

  int get getSpecId => _specId;

  int get getCharBuildId => _charBuildId;

  String getCharBuildTitle() {
    if (_charBuildId < 0) {
      return "";
    }

    return _charBuildsMap[_expansionId]!.firstWhere((element) => element.buildId == _charBuildId).title;
  }

  List<CharBuild> get getCharBuilds => _charBuildsMap[_expansionId]!;

  List<app_model.SequencePoint> getBuildSequence() {
    List<app_model.SequencePoint> buildSequence = List.empty(growable: true);

    for (var sequencePoint in _wtc.getBuildSequence) {
      buildSequence.add(
        app_model.SequencePoint(
          expansionId: sequencePoint.expansionId,
          charClassId: sequencePoint.charClassId,
          specId: sequencePoint.specId,
          talentIndex: sequencePoint.talentIndex,
          buildId: _charBuildId < 0 ? _charBuildsMap[_expansionId]!.length : _charBuildId,
          sequencePoint: sequencePoint.sequencePoint,
          talentIcon: getTalentForPosition(sequencePoint.specId, sequencePoint.talentIndex ~/ 4, sequencePoint.talentIndex % 4).icon,
          rank: sequencePoint.rank,
        ),
      );
    }

    return buildSequence;
  }

  bool get showTooltips => _showToolTips.value;

  bool get areAllPointsSpent => _wtc.areAllPointsSpent();

  set setExpansionId(int expansionId) => _expansionId = expansionId;

  set setCharClassesMap(Map<int, List<CharClass>> charClassesMap) => _charClassesMap = charClassesMap;

  set setSpecsMap(Map<int, List<Spec>> specsMap) => _specsMap = specsMap;

  set setTalentsMap(Map<int, Map<int, Map<int, List<Talent>>>> talentsMap) => _talentsMap = talentsMap;

  set setRanksMap(Map<int, List<Rank>> ranksMap) => _ranksMap = ranksMap;

  set setDependenciesMap(Map<int, List<Dependency>> dependenciesMap) => _dependenciesMap = dependenciesMap;

  set setCharClassId(int charClassId) => _charClassId = charClassId;

  set setSpecId(int specId) => _specId = specId;

  set setCharBuilds(Map<int, List<CharBuild>> charBuildsMap) => _charBuildsMap = charBuildsMap;

  set setBuildSequences(Map<int, List<app_model.SequencePoint>> buildSequencesMap) => _buildSequencesMap = buildSequencesMap;

  set setShowTooltips(Settings settings) => _showToolTips.value = settings.showTooltips == 1;

  set setTreeStates(List<List<int>> treeStates) {
    _wtc.setTreeStates = treeStates;
    _updateStates();
  }

  set setCharBuildId(int charBuildId) => _charBuildId = charBuildId;

  void setBuildSequenceInCalculator(CharBuild charBuild) {
    List<app_model.SequencePoint> buildSequence =
        _buildSequencesMap[charBuild.expansionId]!.where((sequencePoint) => sequencePoint.buildId == charBuild.buildId).toList();

    List<SequencePoint> buildSequenceCalculator = List.empty(growable: true);

    for (var sequencePoint in buildSequence) {
      buildSequenceCalculator.add(
        SequencePoint(
          expansionId: sequencePoint.expansionId,
          charClassId: sequencePoint.charClassId,
          specId: sequencePoint.specId,
          talentIndex: sequencePoint.talentIndex,
          sequencePoint: sequencePoint.sequencePoint,
          rank: sequencePoint.rank,
        ),
      );
    }

    _wtc.setBuildSequence = buildSequenceCalculator;
  }

  void _updateStates() {
    _updateAvailabilityStates();
    _updateMaxedOutStates();
    _updateAllPointsSpent();
  }

  void _initAvailabilityStates() {
    _availabilityStates.clear();
    for (int specId = 0; specId < _wtc.getAvailabilityStates.length; specId++) {
      ReactiveList<bool> spec = ReactiveList();

      for (int index = 0; index < _wtc.getAvailabilityStates[specId].length; index++) {
        spec.add(_wtc.getAvailabilityStateAt(specId, index));
      }

      _availabilityStates.add(spec);
    }
  }

  void _updateAvailabilityStates() {
    for (int specId = 0; specId < _wtc.getAvailabilityStates.length; specId++) {
      for (int index = 0; index < _wtc.getAvailabilityStates[specId].length; index++) {
        _availabilityStates[specId][index] = _wtc.getAvailabilityStateAt(specId, index);
      }
    }
  }

  void _initMaexedOutStates() {
    _maxedOutStates.clear();
    for (int specId = 0; specId < _wtc.getMaxedOutStates.length; specId++) {
      ReactiveList<bool> spec = ReactiveList();

      for (int index = 0; index < _wtc.getMaxedOutStates[specId].length; index++) {
        spec.add(_wtc.getMaxedOutStateAt(specId, index));
      }

      _maxedOutStates.add(spec);
    }
  }

  void _updateMaxedOutStates() {
    for (int specId = 0; specId < _wtc.getMaxedOutStates.length; specId++) {
      for (int index = 0; index < _wtc.getMaxedOutStates[specId].length; index++) {
        _maxedOutStates[specId][index] = _wtc.getMaxedOutStateAt(specId, index);
      }
    }
  }

  void _updateAllPointsSpent() {
    _allPointsSpent.value = _wtc.areAllPointsSpent();
  }
}
