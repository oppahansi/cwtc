import 'package:align_positioned/align_positioned.dart';
import 'package:classic_wow_talent_calculator_stacked/app/size_config.dart';
import 'package:classic_wow_talent_calculator_stacked/constants/arrow_painters.dart';
import 'package:classic_wow_talent_calculator_stacked/ui/talent_tree/talent/talent_view.dart';
import 'package:classic_wow_talent_calculator_stacked/ui/talent_tree/talent_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:widget_finder/widget_finder.dart';

import '../../app/app.locator.dart';
import '../../data_models/talent.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class TalentTreeViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  final List<Talent> _talents = List.empty(growable: true);

  String getIcon(String icon) => _imageService.getTalentIcon(icon);

  void addTalent(Talent talent) => _talents.add(talent);

  bool isTalentDisabled(int talentId) {
    var talent = _talents.firstWhere((element) => element.id == talentId);
    if (talent.row == 0 && talent.requires == 0) return false;
    if (_tcService.getSpentPoints >= talent.row * 5) return false;

    return true;
  }

  String get getClassName => _tcService.getCharClassName;

  Color get getClassColor => _tcService.getClassColor.toColor();

  String get getBGImage => _imageService.getSpecBg(_tcService.getCharClassName.toLowerCase(), _tcService.getSpecId);

  int get getTreeLength => _tcService.getTreeLength;

  int get getTalentIndex => 0;

  String get getEmptyTalentIcon => _imageService.getEmptyTalentIcon;

  bool showTalentOnTalentTreePosition(int index) => _tcService.showTalentOnIndex(index);

  Talent getCurrentTalent(int talentIndex) => _tcService.getTalentForIndex(talentIndex);

  bool talentEnablesAnother(int talentId) => _tcService.talentEnablesAnother(talentId);

  Widget getTalentForTreePosition(int talentTreePosition, double length) {
    if (!showTalentOnTalentTreePosition(talentTreePosition)) return SizedBox(height: length, width: length);

    Talent talent = _tcService.getTalent;

    return TalentView(talentTreePosition: talentTreePosition, talent: talent);
  }

  int getTalentPoints(int talentTreePosition) => _tcService.getTalentPoints(talentTreePosition);
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
