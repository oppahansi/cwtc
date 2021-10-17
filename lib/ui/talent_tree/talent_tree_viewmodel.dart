import 'package:classic_wow_talent_calculator_stacked/app/size_config.dart';
import 'package:classic_wow_talent_calculator_stacked/ui/talent_tree/talent/talent_view.dart';
import 'package:classic_wow_talent_calculator_stacked/ui/talent_tree/talent_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../data_models/talent.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class TalentTreeViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  int _talentIndex = 0;

  String get getClassName => _tcService.getCharClassName;

  Color get getClassColor => _tcService.getClassColor.toColor();

  String get getBGImage => _imageService.getSpecBg(_tcService.getCharClassName.toLowerCase(), _tcService.getSpecId);

  int get getTreeLength => _tcService.getTreeLength;

  int get getTalentIndex => 0;

  String get getEmptyTalentIcon => _imageService.getEmptyTalentIcon;

  bool showTalentOnTalentTreePosition(int index) => _tcService.showTalentOnIndex(index);

  Talent getCurrentTalent(int talentIndex) => _tcService.getTalentForIndex(talentIndex);

  Widget getTalentForTreePosition(int talentTreePosition, BuildContext context) {
    if (!showTalentOnTalentTreePosition(talentTreePosition)) {
      SizeConfig().init(context);
      return SizedBox(height: SizeConfig.safeBlockVertical! * 20, width: SizeConfig.safeBlockHorizontal! * 20);
    }

    return TalentView(talent: _tcService.getTalent);
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
