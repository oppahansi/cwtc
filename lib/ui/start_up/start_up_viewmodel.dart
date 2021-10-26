import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wow_talent_calculator/wow_talent_calculator.dart' as tc;

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../constants/constants.dart';
import '../../data_models/char_class.dart';
import '../../data_models/dependency.dart';
import '../../data_models/rank.dart';
import '../../data_models/spec.dart';
import '../../data_models/talent.dart';
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
    Map<int, List<CharClass>> charClassesMap = {};
    Map<int, List<Spec>> specsMap = {};
    Map<int, List<Talent>> talentsMap = {};
    Map<int, List<Rank>> ranksMap = {};
    Map<int, List<Dependency>> dependenciesMap = {};

    for (var expansion in tc.Expansions.values) {
      var expansionString = expansion.toShortString();
      List<CharClass> charClasses = await _dbService.getCharClasses(expansionString);
      List<Spec> specs = await _dbService.getSpecsByExpansion(expansionString);
      List<Talent> talents = await _dbService.getTalentsByExpansion(expansionString);
      List<Rank> ranks = await _dbService.getRanksByExpansion(expansionString);
      List<Dependency> dependencies = await _dbService.getDependenciesByExpansion(expansionString);

      charClassesMap.putIfAbsent(expansion.index, () => charClasses);
      specsMap.putIfAbsent(expansion.index, () => specs);
      talentsMap.putIfAbsent(expansion.index, () => talents);
      ranksMap.putIfAbsent(expansion.index, () => ranks);
      dependenciesMap.putIfAbsent(expansion.index, () => dependencies);
    }

    _tcService.setCharClassesMap(charClassesMap);
    _tcService.setSpecsMap(specsMap);
    _tcService.setTalentsMap(talentsMap);
    _tcService.setRanksMap(ranksMap);
    _tcService.setDependenciesMap(dependenciesMap);

    _tcService.mapData();
  }

  @override
  Future futureToRun() async {
    //await Future.delayed(const Duration(seconds: 3));
    await init();
    _navigationService.replaceWith(Routes.expansionsView);
  }
}
