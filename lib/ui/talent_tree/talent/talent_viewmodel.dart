import 'package:stacked/stacked.dart';

class TalentViewModel extends BaseViewModel {
  var _talentId = 0;
  var _talentIndex = 0;

  void setTalentIndex(var talentIndex) => _talentIndex = talentIndex;

  int get getTalentIndex => _talentIndex;

  void setTalentId(int talentId) => _talentId = talentId;

  int get getTalenId => _talentId;
}
