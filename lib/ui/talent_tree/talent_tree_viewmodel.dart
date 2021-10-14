import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../services/image_service.dart';
import '../../services/tc_service.dart';

class TalentTreeViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _tcService = locator<TCService>();

  String get getClassName => "Class";

  get getClassColor => null;

  String get getBGImage => "";

  int get getTreeLength => 0;

  get getTalentIndex => null;

  bool get showTalentOnIndex => true;

  getTalentForIndex(int index) {}

  void setTalentIndex(param0) {}
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
