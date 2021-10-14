enum CharClasses {
  druid,
  hunter,
  mage,
  paladin,
  priest,
  rogue,
  shaman,
  warlock,
  warrior,
  deathknight,
}

extension ParseToString on CharClasses {
  String toShortString() {
    return toString().split('.').last;
  }
}
