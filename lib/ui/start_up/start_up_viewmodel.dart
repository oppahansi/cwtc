import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wow_talent_calculator/wow_talent_calculator.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../data_models/char_class.dart';
import '../../data_models/dependency.dart';
import '../../data_models/rank.dart';
import '../../data_models/spec.dart';
import '../../data_models/talent.dart';
import '../../extensions/extensions.dart';
import '../../services/image_service.dart';
import '../../services/db_service.dart';
import '../../services/tc_service.dart';

class StartUpViewModel extends FutureViewModel {
  final _dbService = locator<DBService>();
  final _imageService = locator<ImageService>();
  final _navigationService = locator<NavigationService>();
  final _tcService = locator<TCService>();

  @override
  Future futureToRun() async {
    //await Future.delayed(const Duration(seconds: 3));
    await init();
    _navigationService.replaceWith(Routes.expansionsView);
  }

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  String get getAppIcon => _imageService.getAppIcon;

  Future init() async {
    Map<int, List<CharClass>> charClassesMap = {};
    Map<int, List<Spec>> specsMap = {};
    Map<int, List<Rank>> ranksMap = {};
    Map<int, List<Dependency>> dependenciesMap = {};
    Map<int, Map<int, Map<int, List<Talent>>>> talentsByExpansionMap = {};

    for (var expansion in Expansions.values) {
      var expansionString = expansion.toShortString();
      List<CharClass> charClasses = await _dbService.getCharClasses(expansionString);
      List<Spec> specs = await _dbService.getSpecsByExpansion(expansionString);
      List<Rank> ranks = await _dbService.getRanksByExpansion(expansionString);
      List<Dependency> dependencies = await _dbService.getDependenciesByExpansion(expansionString);

      charClassesMap.putIfAbsent(expansion.index, () => charClasses);
      specsMap.putIfAbsent(expansion.index, () => specs);
      ranksMap.putIfAbsent(expansion.index, () => ranks);
      dependenciesMap.putIfAbsent(expansion.index, () => dependencies);

      Map<int, Map<int, List<Talent>>> talentsByClassMap = {};

      for (int i = 0; i < CharClasses.values.length; i++) {
        Map<int, List<Talent>> talentsBySpecMap = {};

        for (var specId in TalentCalculatorConstants.expansionAndSpecIds) {
          List<Talent> talents = await _dbService.getTalentsByExpansionAndClassAndSpec(expansionString, i, specId);
          talentsBySpecMap.putIfAbsent(specId, () => talents);
        }

        talentsByClassMap.putIfAbsent(i, () => talentsBySpecMap);
      }

      talentsByExpansionMap.putIfAbsent(expansion.index, () => talentsByClassMap);
    }

    _tcService.setCharClassesMap(charClassesMap);
    _tcService.setSpecsMap(specsMap);
    _tcService.setTalentsMap(talentsByExpansionMap);
    _tcService.setRanksMap(ranksMap);
    _tcService.setDependenciesMap(dependenciesMap);

    _tcService.mapData();
  }
}
