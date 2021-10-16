import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../data_models/talent.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';

class TalentViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  final Talent talent;

  var _talentId = 0;
  var _talentIndex = 0;
  var _talentPoints = 0;

  TalentViewModel(this.talent);

  bool isMaxedOut() {
    if (_talentPoints == talent.ranks.length) {
      notifyListeners();
      return true;
    }

    return false;
  }

  void setTalentId(int talentId) => _talentId = talentId;

  int get getTalenId => _talentId;

  void setTalentIndex(var talentIndex) => _talentIndex = talentIndex;

  int get getTalentIndex => _talentIndex;

  String getIcon(String icon) => _imageService.getTalentIcon(icon);

  void incrementTalentPoints() {
    if (_talentPoints >= talent.ranks.length) return;

    _talentPoints++;
    _tcService.incrementSpentPoints();
    notifyListeners();
  }

  void decrementTalentPoints() {
    if (_talentPoints >= 0) return;

    _talentPoints--;
    notifyListeners();
  }

  int get getTalentPoints => _talentPoints;

  bool isTalentDisabled() {
    if (talent.row == 0 && talent.requires == 0) return false;
    if (_tcService.getSpentPoints >= talent.row * 5) return false;

    return true;
  }
}
