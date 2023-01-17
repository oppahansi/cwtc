import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../data_models/char_build.dart';
import '../../../services/image_service.dart';
import '../../../services/tc_service.dart';

class CharBuildsViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  void loadCharBuild(CharBuild charBuild) {
    List<List<int>> treeStates = List.empty(growable: true);
    List<String> specState0 = charBuild.specState0.split(",");
    List<String> specState1 = charBuild.specState1.split(",");
    List<String> specState2 = charBuild.specState2.split(",");
    treeStates.add(specState0.map(int.parse).toList());
    treeStates.add(specState1.map(int.parse).toList());
    treeStates.add(specState2.map(int.parse).toList());

    _tcService.setExpansionId = charBuild.expansionId;
    _tcService.setCharClassId = charBuild.charClassId;
    _tcService.initTalentCalculator();
    _tcService.setTreeStates = treeStates;
    _tcService.setBuildSequenceInCalculator(charBuild);
    _tcService.setCharBuildId = charBuild.buildId;

    locator<NavigationService>().navigateTo(Routes.treeView);
  }

  void deleteCharBuild(CharBuild charBuild) => _tcService.deleteCharBuild(charBuild);

  String getShareableLink(CharBuild charBuild) => _tcService.getShareableLink(charBuild);

  String getCharClassIcon(int charClassId) => _imageService.getCharClassIcon(_tcService.getCharClassIcon(charClassId));

  Color get getExpansionColor => _tcService.getExpansionColor;

  List<CharBuild> get getCharBuilds => _tcService.getCharBuilds;

  int get getExpansionId => _tcService.getExpansionId;
}
