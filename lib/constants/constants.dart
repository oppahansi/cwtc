import 'package:flutter/material.dart';

class Constants {
  static const List<int> availablePoints = [51, 61, 71];

  static final List<Color> expansionColors = [Colors.yellow.shade400, Colors.green.shade400, Colors.blue.shade400];

  static const List<String> expansionsFull = ["Vanilla", "The Burning Crusade", "Wrath of the Lich King"];

  static const List<String> expansionsShort = ["Vanilla", "Tbc", "Wotlk"];

  static const List<String> wowHeadBaseUrls = [
    "https://classic.wowhead.com/talent-calc/",
    "https://tbc.wowhead.com/talent-calc/",
  ];

  static const List<String> twinstarBaseUrls = [
    "http://armory.twinstar.cz/talent-calc.php?cid=11&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=3&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=8&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=2&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=5&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=4&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=7&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=9&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=1&d=wotlk&tal=",
    "http://armory.twinstar.cz/talent-calc.php?cid=6&d=wotlk&tal="
  ];

  static const List<int> talentTeeLengths = [28, 36, 44];

  static BoxDecoration getBgDecoration(String bgFilePath) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(bgFilePath),
        fit: BoxFit.fill,
      ),
    );
  }

  static const greyScaleColorFilter =
      ColorFilter.matrix(<double>[0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0, 0, 0, 1, 0]);
}

enum ArrowTypes {
  short,
  shortRight,
  shortLeft,
  medium,
  mediumRight,
  mediumLeft,
  long,
  longRight,
  longLeft,
  longest,
}
