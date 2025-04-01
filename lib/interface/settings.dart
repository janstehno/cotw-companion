import 'package:cotwcompanion/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  static const List<Locale> _languageCodes = [
    Locale("en"),
    Locale("ru"),
    Locale("cs"),
    Locale("pl"),
    Locale("de"),
    Locale("fr"),
    Locale("es"),
    Locale("pt", "BR"),
    Locale("pt", "PT"),
    Locale("ja"),
    Locale("zh"),
    Locale("hu"),
    Locale("tr"),
  ];

  final List<String> _languages = [
    "English",
    "Русский",
    "Čeština",
    "Polski",
    "Deutsch",
    "Français",
    "Español",
    "Português (Brasil)",
    "Português (Portugal)",
    "日本語",
    "中文",
    "Magyar",
    "Türkçe",
  ];

  late int _language;
  late bool _darkMode;
  late bool _imperialUnits;
  late bool _mapZonesType;
  late bool _mapZonesStyle;
  late bool _mapZonesCount;
  late bool _mapPerformanceMode;
  late bool _bestWeaponsForAnimal;
  late bool _trophyWeightDistribution;
  late bool _furRarityPerCent;
  late SharedPreferences _sharedPreferences;

  Settings({
    required language,
    required bool darkMode,
    required imperialUnits,
    required mapZonesType,
    required mapZonesStyle,
    required mapZonesCount,
    required mapPerformanceMode,
    required bestWeaponsForAnimal,
    required trophyWeightDistribution,
    required furRarityPerCent,
  }) {
    _language = language;
    _darkMode = darkMode;
    _imperialUnits = imperialUnits;
    _mapZonesType = mapZonesType;
    _mapZonesStyle = mapZonesStyle;
    _mapZonesCount = mapZonesCount;
    _mapPerformanceMode = mapPerformanceMode;
    _bestWeaponsForAnimal = bestWeaponsForAnimal;
    _trophyWeightDistribution = trophyWeightDistribution;
    _furRarityPerCent = furRarityPerCent;
  }

  bool get darkMode => _darkMode;

  bool get imperialUnits => _imperialUnits;

  bool get mapZonesType => _mapZonesType;

  bool get mapZonesStyle => _mapZonesStyle;

  bool get mapZonesCount => _mapZonesCount;

  bool get mapPerformanceMode => _mapPerformanceMode;

  bool get bestWeaponsForAnimal => _bestWeaponsForAnimal;

  bool get trophyWeightDistribution => _trophyWeightDistribution;

  bool get furRarityPerCent => _furRarityPerCent;

  int get language => _language;

  static List<Locale> get languageCodes => _languageCodes;

  List<String> get languages => _languages;

  Locale getLocale(int i) => _languageCodes.elementAt(i);

  String getLocaleName(int i) => _languages.elementAt(i);

  Future<void> changeTheme(bool darkMode) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _darkMode = darkMode;
    Interface.setColors(darkMode);
    await _sharedPreferences.setBool("darkMode", darkMode);
    notifyListeners();
  }

  Future<void> changeUnits(bool imperialUnits) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _imperialUnits = imperialUnits;
    await _sharedPreferences.setBool("imperialUnits", imperialUnits);
    notifyListeners();
  }

  Future<void> changeLanguage(int languageId) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _language = languageId;
    await _sharedPreferences.setInt("language", languageId);
    notifyListeners();
  }

  Future<void> changeMapZonesType() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_mapZonesType == true) {
      _mapZonesType = false;
      await _sharedPreferences.setBool("mapZonesType", false);
    } else {
      _mapZonesType = true;
      await _sharedPreferences.setBool("mapZonesType", true);
    }
    notifyListeners();
  }

  Future<void> changeMapZonesStyle() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_mapZonesStyle == true) {
      _mapZonesStyle = false;
      await _sharedPreferences.setBool("mapZonesStyle", false);
    } else {
      _mapZonesStyle = true;
      await _sharedPreferences.setBool("mapZonesStyle", true);
    }
    notifyListeners();
  }

  Future<void> changeMapZonesAccuracy() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_mapZonesCount == true) {
      _mapZonesCount = false;
      await _sharedPreferences.setBool("mapZonesCount", false);
    } else {
      _mapZonesCount = true;
      await _sharedPreferences.setBool("mapZonesCount", true);
    }
    notifyListeners();
  }

  Future<void> changeMapPerformanceMode() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_mapPerformanceMode == true) {
      _mapPerformanceMode = false;
      await _sharedPreferences.setBool("mapPerformanceMode", false);
    } else {
      _mapPerformanceMode = true;
      await _sharedPreferences.setBool("mapPerformanceMode", true);
    }
    notifyListeners();
  }

  Future<void> changeBestWeaponsForAnimal() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_bestWeaponsForAnimal == true) {
      _bestWeaponsForAnimal = false;
      await _sharedPreferences.setBool("bestWeaponsForAnimal", false);
    } else {
      _bestWeaponsForAnimal = true;
      await _sharedPreferences.setBool("bestWeaponsForAnimal", true);
    }
    notifyListeners();
  }

  Future<void> changeTrophyWeightDistribution() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_trophyWeightDistribution == true) {
      _trophyWeightDistribution = false;
      await _sharedPreferences.setBool("trophyWeightDistribution", false);
    } else {
      _trophyWeightDistribution = true;
      await _sharedPreferences.setBool("trophyWeightDistribution", true);
    }
    notifyListeners();
  }

  Future<void> changeFurRarityPerCent() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_furRarityPerCent == true) {
      _furRarityPerCent = false;
      await _sharedPreferences.setBool("furRarityPerCent", false);
    } else {
      _furRarityPerCent = true;
      await _sharedPreferences.setBool("furRarityPerCent", true);
    }
    notifyListeners();
  }
}
