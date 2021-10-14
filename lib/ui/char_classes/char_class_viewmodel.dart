import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../data_models/char_class.dart';
import '../../services/db_service.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class CharClassViewModel extends FutureViewModel<List<CharClass>> {
  final _dbService = locator<DBService>();
  final _tcService = locator<TCService>();
  final _imageService = locator<ImageService>();

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  int get getExpansion => _tcService.getExpansion;

  String get getExpansionFull => _tcService.getExpansionFull;

  Future<List<CharClass>> getCharClasses() async {
    return await _dbService.getCharClasses("vanilla");
  }

  @override
  Future<List<CharClass>> futureToRun() => getCharClasses();

  void setClass(int classId) {
    _tcService.setClass(classId);
  }
}
