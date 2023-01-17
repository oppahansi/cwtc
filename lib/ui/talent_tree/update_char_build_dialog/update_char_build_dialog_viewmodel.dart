import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../extensions/extensions.dart';
import '../../../services/tc_service.dart';

class UpdateCharBuildDialogViewModel extends BaseViewModel {
  final _tcService = locator<TCService>();

  void updateCharBuild(String title) => _tcService.updateCharBuild(title);

  Color get getExpansionColor => _tcService.getExpansionColor;

  Color get getCharClassColor => _tcService.getClassColor.toColor();

  String get getCharBuildTitle => _tcService.getCharBuildTitle();
}
