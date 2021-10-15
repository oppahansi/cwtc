import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../data_models/char_class.dart';
import '../../services/db_service.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class CharClassViewModel extends BaseViewModel {
  final _dbService = locator<DBService>();
  final _tcService = locator<TCService>();
  final _imageService = locator<ImageService>();

  String get getRngBgImageFilePath => _imageService.getRngBgImageFilePath;

  int get getExpansion => _tcService.getExpansionId;

  String get getExpansionFull => _tcService.getExpansionFull;

  int get getCharClassCount => _tcService.getCharClassCount;

  String getCharClassIconForId(int charClassId) => _imageService.getCharClassIcon(_tcService.getCharClassIcon(charClassId));

  Future<List<CharClass>> getCharClasses() async {
    return await _dbService.getCharClasses(_tcService.getExpansionShort.toLowerCase());
  }
}
