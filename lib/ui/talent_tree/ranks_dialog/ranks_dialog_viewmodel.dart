import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../extensions/extensions.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';

class RanksDialogViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  void investPointAt(int specId, int index) {
    _tcService.investPointAt(specId, index);
    notifyListeners();
  }

  void removePointAt(int specId, int index) {
    _tcService.removePointAt(specId, index);
    notifyListeners();
  }

  bool isTalentAvailableAt(int specId, int index) => _tcService.isTalentAvailableAt(specId, index);

  bool isTalentMaxedOutAt(int specId, int index) => _tcService.isTalentMaxedOutAt(specId, index);

  bool areAllPointsSpent() => _tcService.areAllPointsSpent;

  bool canRemovePointAt(int specId, int index) => _tcService.canRemovePointAt(specId, index);

  int getInvestedPointsAt(int specId, int index) => _tcService.getInvestedPointsAt(specId, index);

  String getTalentIcon(String icon) => _imageService.getTalentIcon(icon);

  Color get getCharClassColor => _tcService.getClassColor.toColor();

  Color get getExpansionColor => _tcService.getExpansionColor;
}
