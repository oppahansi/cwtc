import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../extensions/extensions.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class TalentTreeViewModel extends ReactiveViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  void resetSpec() => _tcService.resetSpec();

  void resetAll() => _tcService.resetAll();

  void saveShowTooltips(bool showTooltips) => _tcService.saveShowTooltips(showTooltips ? 1 : 0);

  String getSpecIcon(int specId) => _imageService.getSpecIcon(_tcService.getSpecIcon(specId));

  int getSpentPoints([int specId = 1]) => _tcService.getSpentPoints(specId);

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_tcService];

  String get getShareableLink => _tcService.getShareableLink();

  bool get showTooltips => _tcService.showTooltips;

  String get getClassName => _tcService.getCharClassName;

  Color get getCharClassColor => _tcService.getClassColor.toColor();

  Color get getExpansionColor => _tcService.getExpansionColor;

  int get getMaxTalentPoints => _tcService.getMaxTalentPoints;

  int get getCharBuildId => _tcService.getCharBuildId;

  set setSpecId(int specId) => _tcService.setSpecId = specId;
}
