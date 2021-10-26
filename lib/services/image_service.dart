import 'dart:math';

class ImageService {
  static const _backgroundImages = [
    "assets/images/bgs/deathknight0.png",
    "assets/images/bgs/deathknight1.png",
    "assets/images/bgs/deathknight2.png",
    "assets/images/bgs/druid0.png",
    "assets/images/bgs/druid1.png",
    "assets/images/bgs/druid2.png",
    "assets/images/bgs/hunter0.png",
    "assets/images/bgs/hunter1.png",
    "assets/images/bgs/hunter2.png",
    "assets/images/bgs/mage0.png",
    "assets/images/bgs/mage1.png",
    "assets/images/bgs/mage2.png",
    "assets/images/bgs/paladin0.png",
    "assets/images/bgs/paladin1.png",
    "assets/images/bgs/paladin2.png",
    "assets/images/bgs/priest0.png",
    "assets/images/bgs/priest1.png",
    "assets/images/bgs/priest2.png",
    "assets/images/bgs/rogue1.png",
    "assets/images/bgs/rogue2.png",
    "assets/images/bgs/rogue0.png",
    "assets/images/bgs/shaman0.png",
    "assets/images/bgs/shaman1.png",
    "assets/images/bgs/shaman2.png",
    "assets/images/bgs/warlock0.png",
    "assets/images/bgs/warlock1.png",
    "assets/images/bgs/warlock2.png",
    "assets/images/bgs/warrior0.png",
    "assets/images/bgs/warrior1.png",
    "assets/images/bgs/warrior2.png",
  ];

  static final Random _random = Random();

  String get getAppIcon => "assets/images/icons/app_icon.png";

  String get getEmptyTalentIcon => "assets/images/icons/empty.png";

  String getSpecIcon(String specIcon) => "assets/images/icons/$specIcon.png";

  String getExpansionIcon(String expansion) => "assets/images/icons/${expansion}_icon.png";

  String get getRngBgImageFilePath => _backgroundImages[_random.nextInt(_backgroundImages.length)];

  String getSpecBg(String charClass, int specId) => "assets/images/bgs/$charClass$specId.png";

  String getTalentIcon(String icon) => "assets/images/icons/$icon.png";

  String getCharClassIcon(String charClassIcon) => "assets/images/icons/$charClassIcon.png";
}
