class TCService {
  static const List<String> _expansionsFull = ["Vanilla", "The Burning Crusade", "Wrath of the Lich King"];
  static const List<String> _expansionsShort = ["Vanilla", "Tbc", "Wotlk"];

  int _expansion = 0;
  int _charClassId = 0;

  int get getExpansion => _expansion;

  String get getExpansionFull => _expansionsFull[_expansion];

  String get getExpansionShort => _expansionsShort[_expansion];

  void setExpansion(int expansion) => _expansion = expansion;

  void setCharClass(int charClassId) => _charClassId = charClassId;
}
