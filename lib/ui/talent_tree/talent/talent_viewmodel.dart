import 'package:classic_wow_talent_calculator_stacked/app/app.locator.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';
import 'package:stacked/stacked.dart';

class TalentViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  var _talentId = 0;
  var _talentIndex = 0;
  var _talentPoints = 0;

  void setTalentId(int talentId) => _talentId = talentId;

  int get getTalenId => _talentId;

  void setTalentIndex(var talentIndex) => _talentIndex = talentIndex;

  int get getTalentIndex => _talentIndex;

  String getIcon(String icon) => _imageService.getTalentIcon(icon);

  void incrementTalentPoints() => _talentPoints++;

  void decrementTalentPoints() => _talentPoints > 0 ? _talentPoints-- : _talentPoints;

  int get getTalentPoints => _talentPoints;
}
