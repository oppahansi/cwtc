import 'package:classic_wow_talent_calculator_stacked/ui/start_up/start_up_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/db_service.dart';
import '../services/image_service.dart';
import '../services/tc_service.dart';
import '../ui/char_classes/char_class_view.dart';
import '../ui/expansions/expansions_view.dart';
import '../ui/talent_tree/talent_tree_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: ExpansionsView),
    MaterialRoute(page: CharClassView),
    MaterialRoute(page: TalentTreeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DBService),
    LazySingleton(classType: ImageService),
    LazySingleton(classType: TCService),
  ],
)
class AppSetup {}
