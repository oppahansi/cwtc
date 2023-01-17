import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/tc_service.dart';

class TalentButtonViewModel extends ReactiveViewModel {
  final _tcService = locator<TCService>();

  void investPointAt(int specId, int index) {
    _tcService.investPointAt(specId, index);
    notifyListeners();
  }

  void removePointAt(int specId, int index) {
    _tcService.removePointAt(specId, index);
    notifyListeners();
  }

  bool get showToolTips => _tcService.showTooltips;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_tcService];
}
