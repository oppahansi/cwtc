import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../data_models/talent.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';

class TalentImageViewModel extends ReactiveViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  bool isTalentAvailableAt(int specId, int index) => _tcService.isTalentAvailableAt(specId, index);

  bool isTalentMaxedOutAt(int specId, int index) => _tcService.isTalentMaxedOutAt(specId, index);

  int getInvestedPointsAt(int specId, int index) => _tcService.getInvestedPointsAt(specId, index);

  String getTalentIcon(String icon) => _imageService.getTalentIcon(icon);

  ColorFilter? getColorFilter(Talent talent) {
    if (areAllPointsSpent && getInvestedPointsAt(talent.specId, talent.index) == 0) {
      return const ColorFilter.mode(Colors.grey, BlendMode.saturation);
    } else if (isTalentAvailableAt(talent.specId, talent.index)) {
      return null;
    } else {
      return const ColorFilter.mode(Colors.grey, BlendMode.saturation);
    }
  }

  Color getStateColor(Talent talent) {
    if (areAllPointsSpent && getInvestedPointsAt(talent.specId, talent.index) == 0) {
      return Colors.grey;
    } else if (areAllPointsSpent && getInvestedPointsAt(talent.specId, talent.index) > 0) {
      return Colors.yellow.shade600;
    } else if (isTalentMaxedOutAt(talent.specId, talent.index)) {
      return Colors.yellow.shade600;
    } else if (isTalentAvailableAt(talent.specId, talent.index)) {
      return Colors.green.shade400;
    } else {
      return Colors.grey;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_tcService];

  bool get areAllPointsSpent => _tcService.areAllPointsSpent;
}
