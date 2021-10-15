import 'package:classic_wow_talent_calculator_stacked/data_models/rank.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../data_models/spec.dart';
import '../../data_models/talent.dart';
import '../../services/db_service.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class TalentTreeViewModel extends MultipleFutureViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();
  final _dbService = locator<DBService>();

  static const String _specsFuture = 'specs';
  static const String _talentFuture = 'talents';
  //static const String _ranksFuture = "ranks";

  int _talentIndex = 0;

  @override
  void onData(String key) {
    switch (key) {
      case _specsFuture:
        _tcService.setSpecs(dataMap![_specsFuture]);
        break;
      case _talentFuture:
        _tcService.setTalents(dataMap![_talentFuture]);
        break;
      // case _ranksFuture:
      //   _tcService.setRanks(dataMap![_ranksFuture]);
      //   break;
      default:
    }
  }

  String get getClassName => _tcService.getCharClassName;

  Color get getClassColor => _tcService.getClassColor.toColor();

  String get getBGImage => _imageService.getSpecBg(_tcService.getCharClassName.toLowerCase(), _tcService.getSpecId);

  int get getTreeLength => _tcService.getTreeLength;

  int get getTalentIndex => 0;

  bool showTalentOnIndex(int index) => _tcService.showTalentOnIndex(index);

  Talent get getCurrentTalent {
    var currentTalent = _tcService.getTalentForIndex(_talentIndex);
    _talentIndex++;
    return currentTalent;
  }

  bool get fetchingSpecs => busy(_specsFuture);

  bool get fetchingTalents => busy(_talentFuture);

  //bool get fetchingRanks => busy(_ranksFuture);

  List<Spec> get getSpecs => dataMap![_specsFuture];

  List<Talent> get getTalents => dataMap![_talentFuture];

  //List<Rank> get getRanks => dataMap![_ranksFuture];

  @override
  Map<String, Future Function()> get futuresMap => {
        _specsFuture: getSpecsFuture,
        _talentFuture: getTalentsFuture,
        //  _ranksFuture: getRanksFuture,
      };

  Future<List<Spec>> getSpecsFuture() async {
    return await _dbService.getSpecs(_tcService.getExpansionShort.toLowerCase(), _tcService.getCharClassId);
  }

  Future<List<Talent>> getTalentsFuture() async {
    return await _dbService.getTalents(_tcService.getExpansionShort.toLowerCase(), _tcService.getCharClassId, _tcService.getSpecId);
  }

  // Future<List<Rank>> getRanksFuture() async {
  //   List<int> talentIds = List.empty(growable: true);
  //   for (Talent talent in getTalents) {
  //     talentIds.add(talent.id);
  //   }

  //   return await _dbService.getRanks(_tcService.getExpansionShort.toLowerCase(), talentIds);
  // }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
