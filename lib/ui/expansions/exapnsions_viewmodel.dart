import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class ExpansionsViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  String getExpansionIcon(String expansion) =>
      _imageService.getExpansionIcon(expansion);

  void setExpansion(int expansion) => _tcService.setExpansionId(expansion);

  void navigateToCharClassView() =>
      locator<NavigationService>().navigateTo(Routes.charClassView);
}
