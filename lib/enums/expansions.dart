enum Expansions {
  vanilla,
  tbc,
  wotlk,
}

extension ParseToString on Expansions {
  String toShortString() {
    return toString().split('.').last;
  }
}
