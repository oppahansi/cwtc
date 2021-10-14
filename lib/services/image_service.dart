import 'dart:math';

class ImageService {
  static final Random _random = Random();
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

  static const String _vanillaIconFilePath = "assets/images/icons/vanilla_icon.png";
  static const String _tbcIconFilePath = "assets/images/icons/tbc_icon.png";
  static const String _wotlkIconFilePath = "assets/images/icons/wotlk_icon.png";

  String get getVanillaIcon => _vanillaIconFilePath;

  String get getTbcIcon => _tbcIconFilePath;

  String get getWotlkIcon => _wotlkIconFilePath;

  String get getRngBgImageFilePath {
    return _backgroundImages[_random.nextInt(_backgroundImages.length)];
  }
}
