import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/tc_service.dart';

class TalentViewModel extends ReactiveViewModel {
  final _tcService = locator<TCService>();

  bool isTalentAvailableAt(int specId, int index) => _tcService.isTalentAvailableAt(specId, index);

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_tcService];
}
