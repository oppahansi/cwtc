import 'package:classic_wow_talent_calculator_stacked/services/tc_service.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../services/image_service.dart';

class ExpansionsViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  String getExpansionIcon(String expansion) => _imageService.getExpansionIcon(expansion);

  void setExpansion(int expansion) => _tcService.setExpansion(expansion);
}
