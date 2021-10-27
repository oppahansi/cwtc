import 'package:flutter/material.dart';

class Constants {
  static const List<int> availablePoints = [51, 61, 71];

  static final List<Color> expansionColors = [Colors.yellow.shade400, Colors.green.shade400, Colors.blue.shade400];

  static const List<String> expansionsFull = ["Vanilla", "The Burning Crusade", "Wrath of the Lich King"];

  static const List<String> expansionsShort = ["Vanilla", "Tbc", "Wotlk"];

  static const List<int> talentTeeLengths = [28, 36, 44];

  static BoxDecoration getBgDecoration(String bgFilePath) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(bgFilePath),
        fit: BoxFit.fill,
      ),
    );
  }
}
