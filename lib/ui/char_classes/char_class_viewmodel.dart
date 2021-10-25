import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class CharClassViewModel extends BaseViewModel {
  final _tcService = locator<TCService>();
  final _imageService = locator<ImageService>();

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  int get getExpansionId => _tcService.getExpansionId;

  String get getExpansionFull => _tcService.getExpansionFull;

  int get getCharClassCount => _tcService.getCharClassCount;

  Color get getExpansionColor => _tcService.getExpansionColor;

  String getCharClassIconForId(int charClassId) =>
      _imageService.getCharClassIcon(_tcService.getCharClassIcon(charClassId));

  void setCharClassId(int charClassId) =>
      _tcService.setCharClassId(charClassId);

  void navigateToTalentTreeView() =>
      locator<NavigationService>().navigateTo(Routes.talentTreeView);
}
