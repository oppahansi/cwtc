import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../extensions/extensions.dart';
import '../../../services/tc_service.dart';

class SaveCharBuildDialogViewModel extends BaseViewModel {
  final _tcService = locator<TCService>();

  void saveCharBuild(String title) => _tcService.saveCharBuild(title);

  Color get getExpansionColor => _tcService.getExpansionColor;

  Color get getCharClassColor => _tcService.getClassColor.toColor();
}
