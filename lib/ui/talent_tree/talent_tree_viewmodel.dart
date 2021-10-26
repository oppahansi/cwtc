import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../data_models/talent.dart';
import '../../extensions/extensions.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';
import 'talent/talent_view.dart';

class TalentTreeViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final List<Talent> _talents = List.empty(growable: true);
  final _tcService = locator<TCService>();

  String getSpecIcon(int specId) => _imageService.getSpecIcon(_tcService.getSpecIcon(specId));

  String getIcon(String icon) => _imageService.getTalentIcon(icon);

  void addTalent(Talent talent) => _talents.add(talent);

  // TODO correct implementation needed
  bool isTalentDisabled(int talentId) {
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

    Talent talent = _tcService.getTalent();

    return TalentView(talentTreePosition: talentTreePosition, talent: talent);
  }

  int getTalentPoints(int talentTreePosition) => _tcService.getTalentPoints(talentTreePosition);

  String getSpecName(int specId) => _tcService.getSpecName(specId);

  void setSpecId(int specId) => _tcService.setSpecId(specId);

  Color get getExpansionColor => _tcService.getExpansionColor;
}
