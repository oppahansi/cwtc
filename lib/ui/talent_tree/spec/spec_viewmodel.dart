import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../data_models/dependency.dart';
import '../../../data_models/talent.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';
import '../../../ui/talent_tree/talent/talent_view.dart';

class SpecViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  int _talentIndex = 0;

  void resetTalentIndex() => _talentIndex = 0;

  bool isPositionEmptyAt(int specId, int index) => _tcService.isPositionEmptyAt(specId, index);

  Widget getTalentViewForIndex(int specId, int index, double length) {
    if (isPositionEmptyAt(specId, index)) {
      return SizedBox(height: length, width: length);
    }

    Talent talent = _tcService.getTalentFor(specId, _talentIndex++);
    talent.index = index;

    return TalentView(talent: talent);
  }

  Talent getTalentForIndex(int specId, int index) => _tcService.getTalentFor(specId, index);

  Talent getTalentWithId(int specId, int id) => _tcService.getTalentWithId(specId, id);

  List<Dependency> getDependencies(int id) => _tcService.getDependencies(id);

  String getSpecBGImage(int specId) => _imageService.getSpecBgImage(_tcService.getCharClassName.toLowerCase(), specId);

  int get getMaxTalentTreeRows => _tcService.getMaxTalentTreeRows;

  int get getTreeLength => _tcService.getTreeLength;
}
