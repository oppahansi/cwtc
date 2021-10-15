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

  String get getClassName => _tcService.getClassName;

  Color get getClassColor => _tcService.getClassColor.toColor();

  String get getBGImage => _tcService.getSpecBg;

  int get getTreeLength => _tcService.getTreeLength;

  get getTalentIndex => 0;

  bool get showTalentOnIndex => true;

  getTalentForIndex(int index) {}

  void setTalentIndex(param0) {}

  bool get fetchingSpecs => busy(_specsFuture);
  bool get fetchingTalents => busy(_talentFuture);

  List<Spec> get getSpecs => dataMap![_specsFuture];
  List<Talent> get getTalents => dataMap![_talentFuture];

  @override
  Map<String, Future Function()> get futuresMap => {
        _specsFuture: getSpecsFuture,
        _talentFuture: getTalentsFuture,
      };

  Future<List<Spec>> getSpecsFuture() async {
    return await _dbService.getSpecs(_tcService.getExpansionShort.toLowerCase(), _tcService.getCharClassId);
  }

  Future<List<Talent>> getTalentsFuture() async {
    return await _dbService.getTalents(_tcService.getExpansionShort.toLowerCase(), _tcService.getCharClassId, _tcService.getSpecId);
  }

  @override
  void onData(String key) {
    _tcService.setSpecs(dataMap![_specsFuture]);
    _tcService.setTalents(dataMap![_talentFuture]);
  }
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
