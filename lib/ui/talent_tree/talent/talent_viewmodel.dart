import 'package:classic_wow_talent_calculator_stacked/app/app.locator.dart';
import 'package:classic_wow_talent_calculator_stacked/data_models/rank.dart';
import 'package:classic_wow_talent_calculator_stacked/data_models/talent.dart';
import '../../../services/db_service.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';
import 'package:stacked/stacked.dart';

class TalentViewModel extends FutureViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();
  final _dbService = locator<DBService>();

  final Talent talent;

  var _talentId = 0;
  var _talentIndex = 0;
  var _talentPoints = 0;

  TalentViewModel(this.talent);

  void setTalentId(int talentId) => _talentId = talentId;

  int get getTalenId => _talentId;

  void setTalentIndex(var talentIndex) => _talentIndex = talentIndex;

  int get getTalentIndex => _talentIndex;

  String getIcon(String icon) => _imageService.getTalentIcon(icon);

  void incrementTalentPoints() {
    if (_talentPoints >= talent.ranks.length) return;

    _talentPoints++;
    notifyListeners();
  }

  void decrementTalentPoints() {
    if (_talentPoints >= 0) return;

    _talentPoints--;
    notifyListeners();
  }

  int get getTalentPoints => _talentPoints;

  @override
  Future futureToRun() => getRanksFuture();

  Future<List<Rank>> getRanksFuture() async {
    List<int> talentIds = List.empty(growable: true);
    for (Talent talent in _tcService.getTalents) {
      talentIds.add(talent.id);
    }

    return await _dbService.getRanks(_tcService.getExpansionShort.toLowerCase(), talentIds);
  }

  @override
  void onData(data) {
    _tcService.setRanks(data);
    super.onData(data);
  }
}
