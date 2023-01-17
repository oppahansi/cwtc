import 'dart:math';

import 'package:injectable/injectable.dart';

@lazySingleton
class ImageService {
  static const _backgroundImages = [
    "assets/images/bgs/deathknight0.webp",
    "assets/images/bgs/deathknight1.webp",
    "assets/images/bgs/deathknight2.webp",
    "assets/images/bgs/druid0.webp",
    "assets/images/bgs/druid1.webp",
    "assets/images/bgs/druid2.webp",
    "assets/images/bgs/hunter0.webp",
    "assets/images/bgs/hunter1.webp",
    "assets/images/bgs/hunter2.webp",
    "assets/images/bgs/mage0.webp",
    "assets/images/bgs/mage1.webp",
    "assets/images/bgs/mage2.webp",
    "assets/images/bgs/paladin0.webp",
    "assets/images/bgs/paladin1.webp",
    "assets/images/bgs/paladin2.webp",
    "assets/images/bgs/priest0.webp",
    "assets/images/bgs/priest1.webp",
    "assets/images/bgs/priest2.webp",
    "assets/images/bgs/rogue1.webp",
    "assets/images/bgs/rogue2.webp",
    "assets/images/bgs/rogue0.webp",
    "assets/images/bgs/shaman0.webp",
    "assets/images/bgs/shaman1.webp",
    "assets/images/bgs/shaman2.webp",
    "assets/images/bgs/warlock0.webp",
    "assets/images/bgs/warlock1.webp",
    "assets/images/bgs/warlock2.webp",
    "assets/images/bgs/warrior0.webp",
    "assets/images/bgs/warrior1.webp",
    "assets/images/bgs/warrior2.webp",
  ];

  static final Random _random = Random();

  String getSpecIcon(String specIcon) => "assets/images/icons/$specIcon.webp";

  String getExpansionIcon(String expansion) => "assets/images/icons/${expansion}_icon.webp";

  String getSpecBgImage(String charClass, int specId) => "assets/images/bgs/$charClass$specId.webp";

  String getTalentIcon(String icon) => "assets/images/icons/$icon.webp";

  String getCharClassIcon(String charClassIcon) => "assets/images/icons/$charClassIcon.webp";

  String get getAppIcon => "assets/images/icons/app_icon.webp";

  String get getEmptyTalentIcon => "assets/images/icons/empty.webp";

  String get getRngBgImage => _backgroundImages[_random.nextInt(_backgroundImages.length)];

  String get getArrowShortImage => "assets/images/arrows/arrowShort.webp";

  String get getArrowRightShortImage => "assets/images/arrows/arrowRightShort.webp";

  String get getArrowLeftShortImage => "assets/images/arrows/arrowLeftShort.webp";

  String get getArrowMediumImage => "assets/images/arrows/arrowMedium.webp";

  String get getArrowRightMediumImage => "assets/images/arrows/arrowRightMedium.webp";

  String get getArrowLeftMediumImage => "assets/images/arrows/arrowLeftMedium.webp";

  String get getArrowLongImage => "assets/images/arrows/arrowLong.webp";

  String get getArrowRightLongImage => "assets/images/arrows/arrowRightLong.webp";

  String get getArrowLeftLongImage => "assets/images/arrows/arrowLeftLong.webp";

  String get getArrowLeftLongestImage => "assets/images/arrows/arrowLongest.webp";
}
