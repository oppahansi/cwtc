import 'package:classic_wow_talent_calculator_stacked/services/tc_service.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../services/image_service.dart';

class ExpansionsViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  String get getVanillaIcon => _imageService.getVanillaIcon;

  String get getTbcIcon => _imageService.getTbcIcon;

  String get getWotlkIcon => _imageService.getWotlkIcon;

  void set
}

enum Expansions { 
   vanilla, 
   tbc, 
   wotlk, 
}