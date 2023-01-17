import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class ExpansionsViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  void navigateToCharClassView() => locator<NavigationService>().navigateTo(Routes.charClassView);

  String getExpansionIcon(String expansion) => _imageService.getExpansionIcon(expansion);

  String get getRngBgImage => _imageService.getRngBgImage;

  set setExpansion(int expansion) => _tcService.setExpansionId = expansion;
}
