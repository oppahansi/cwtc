import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../data_models/talent.dart';
import '../../../services/tc_service.dart';

class SpentPointsViewModel extends ReactiveViewModel {
  final _tcService = locator<TCService>();

  bool isTalentAvailableAt(int specId, int index) => _tcService.isTalentAvailableAt(specId, index);

  bool isTalentMaxedOutAt(int specId, int index) => _tcService.isTalentMaxedOutAt(specId, index);

  int getInvestedPointsAt(int specId, int index) => _tcService.getInvestedPointsAt(specId, index);

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
