import 'package:classic_wow_talent_calculator_stacked/app/app.locator.dart';
import 'package:classic_wow_talent_calculator_stacked/app/app.router.dart';
import 'package:classic_wow_talent_calculator_stacked/constants/constants.dart';
import 'package:classic_wow_talent_calculator_stacked/data_models/char_class.dart';
import 'package:classic_wow_talent_calculator_stacked/data_models/rank.dart';
import 'package:classic_wow_talent_calculator_stacked/data_models/spec.dart';
import 'package:classic_wow_talent_calculator_stacked/data_models/talent.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../services/image_service.dart';
import '../../services/db_service.dart';
import '../../services/tc_service.dart';

class StartUpViewModel extends FutureViewModel {
  final _dbService = locator<DBService>();
  final _tcService = locator<TCService>();
  final _imageService = locator<ImageService>();
  final _navigationService = locator<NavigationService>();

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  String get getAppIcon => _imageService.getAppIcon;

  Future init() async {
    await Future.delayed(const Duration(seconds: 3));
    Map<int, List<CharClass>> charClassesMap = {};
    Map<int, List<Spec>> specsMap = {};
    Map<int, List<Talent>> talentsMap = {};
    Map<int, List<Rank>> ranksMap = {};

    for (var expansion in Expansions.values) {
      List<CharClass> charClasses = await _dbService.getCharClasses(expansion.toShortString());
      List<Spec> specs = await _dbService.getSpecsByExpansion(expansion.toShortString());
      List<Talent> talents = await _dbService.getTalentsByExpansion(expansion.toShortString());
      List<Rank> ranks = await _dbService.getRanksByExpansion(expansion.toShortString());

      charClassesMap.putIfAbsent(expansion.index, () => charClasses);
      specsMap.putIfAbsent(expansion.index, () => specs);
      talentsMap.putIfAbsent(expansion.index, () => talents);
      ranksMap.putIfAbsent(expansion.index, () => ranks);
    }

    _tcService.setCharClassesMap(charClassesMap);
    _tcService.setSpecsMap(specsMap);
    _tcService.setTalentsMap(talentsMap);
    _tcService.setRanksMap(ranksMap);
  }

  @override
  Future futureToRun() async {
    await init();
    _navigationService.replaceWith(Routes.expansionsView);
  }
}
