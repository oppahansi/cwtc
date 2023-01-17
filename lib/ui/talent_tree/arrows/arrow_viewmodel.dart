import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../constants/constants.dart';
import '../../../data_models/talent.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';

class ArrowViewModel extends ReactiveViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  bool isTalentAvailable(int specId, int index) => _tcService.isTalentAvailableAt(specId, index);

  bool isDependencyMet(int specId, Talent talent, Talent dependee) {
    return _tcService.isTalentMaxedOutAt(specId, talent.index) && isTalentAvailable(specId, dependee.index);
  }

  bool areAllPointsSpent() => _tcService.areAllPointsSpent;

  int getInvestedPointsAt(int specId, int index) => _tcService.getInvestedPointsAt(specId, index);

  ColorFilter? getStateColor(Talent talent, Talent dependee) {
    bool dependencyMet = isDependencyMet(talent.specId, talent, dependee);
    if (areAllPointsSpent() && dependencyMet && getInvestedPointsAt(dependee.specId, dependee.index) == 0) {
      return Constants.greyScaleColorFilter;
    } else if (dependencyMet) {
      return null;
    } else {
      return Constants.greyScaleColorFilter;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_tcService];

  String get getArrowShortImage => _imageService.getArrowShortImage;

  String get getArrowRightShortImage => _imageService.getArrowRightShortImage;

  String get getArrowLeftShortImage => _imageService.getArrowLeftShortImage;

  String get getArrowMediumImage => _imageService.getArrowMediumImage;

  String get getArrowRightMediumImage => _imageService.getArrowRightMediumImage;

  String get getArrowLeftMediumImage => _imageService.getArrowLeftMediumImage;

  String get getArrowLongImage => _imageService.getArrowLongImage;

  String get getArrowRightLongImage => _imageService.getArrowRightLongImage;

  String get getArrowLeftLongImage => _imageService.getArrowLeftLongImage;

  String get getArrowLongestImage => _imageService.getArrowLeftLongestImage;
}
