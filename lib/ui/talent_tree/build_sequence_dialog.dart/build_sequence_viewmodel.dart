import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../data_models/sequence_point.dart';
import '../../../data_models/talent.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';

class BuildSequenceViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  Talent getTalentForPosition(int specId, int row, int column) => _tcService.getTalentForPosition(specId, row, column);

  String getTalentIcon(String icon) => _imageService.getTalentIcon(icon);

  String getSpecName(int specId) => _tcService.getSpecName(specId);

  List<SequencePoint> getBuildSequence() => _tcService.getBuildSequence();

  Color get getExpansionColor => _tcService.getExpansionColor;
}
