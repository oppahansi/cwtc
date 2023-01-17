import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class CharClassViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  void navigateToTalentTreeView() => locator<NavigationService>().navigateTo(Routes.treeView);

  void initTalentCalculator() => _tcService.initTalentCalculator();

  String getCharClassIcon(int charClassId) => _imageService.getCharClassIcon(_tcService.getCharClassIcon(charClassId));

  String get getRngBgImageFilePath => _imageService.getRngBgImage;

  int get getExpansionId => _tcService.getExpansionId;

  String get getExpansionFull => _tcService.getExpansionFull;

  Color get getExpansionColor => _tcService.getExpansionColor;

  set setCharClassId(int charClassId) => _tcService.setCharClassId = charClassId;
}
