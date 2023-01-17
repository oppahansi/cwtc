class Settings {
  static final columns = ["showToolTips"];

  int showTooltips;

  Settings({required this.showTooltips});

  factory Settings.fromMap(Map<dynamic, dynamic> data) {
    return Settings(
      showTooltips: data["showTooltips"],
    );
  }
}
