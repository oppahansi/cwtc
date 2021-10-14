import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../services/image_service.dart';

class ExpansionsViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  String get getVanillaIcon => _imageService.getVanillaIcon;

  String get getTbcIcon => _imageService.getTbcIcon;

  String get getWotlkIcon => _imageService.getWotlkIcon;
}
