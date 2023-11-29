// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  static const List<Locale> languageCodes = [
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
    "Magyar",
    "Türkçe",
  ];

  late int _language;
  late int _color;
  late int _compactLogbook;
  late bool _darkMode;
  late bool _imperialUnits;
  late bool _mapZonesType;
  late bool _mapZonesStyle;
  late bool _mapZonesAccuracy;
  late bool _mapPerformanceMode;
  late bool _bestWeaponsForAnimal;
  late bool _entryDate;
  late bool _trophyLodgeEntry;
  late bool _furRarityPerCent;
  late SharedPreferences _sharedPreferences;

  Settings({
    required language,
    required color,
    required compactLogbook,
    required bool darkMode,
    required imperialUnits,
    required mapZonesType,
    required mapZonesStyle,
    required mapZonesAccuracy,
    required mapPerformanceMode,
    required bestWeaponsForAnimal,
    required entryDate,
    required trophyLodgeEntry,
    required furRarityPerCent,
  }) {
    _language = language;

    _color = color;

    _compactLogbook = compactLogbook;

    _darkMode = darkMode;

    _imperialUnits = imperialUnits;

    _mapZonesType = mapZonesType;

    _mapZonesStyle = mapZonesStyle;

    _mapZonesAccuracy = mapZonesAccuracy;

    _mapPerformanceMode = mapPerformanceMode;

    _bestWeaponsForAnimal = bestWeaponsForAnimal;

    _entryDate = entryDate;

    _trophyLodgeEntry = trophyLodgeEntry;

    _furRarityPerCent = furRarityPerCent;
  }

  int get color => _color;

  int get compactLogbook => _compactLogbook;

  bool get darkMode => _darkMode;

  bool get imperialUnits => _imperialUnits;

  bool get mapZonesType => _mapZonesType;

  bool get mapZonesStyle => _mapZonesStyle;

  bool get mapZonesAccuracy => _mapZonesAccuracy;

  bool get mapPerformanceMode => _mapPerformanceMode;

  bool get bestWeaponsForAnimal => _bestWeaponsForAnimal;

  bool get entryDate => _entryDate;

  bool get trophyLodgeEntry => _trophyLodgeEntry;

  bool get furRarityPerCent => _furRarityPerCent;

  int get language => _language;

  List<String> get languages => _languages;

  Locale getLocale(int index) => languageCodes[index];

  String getLocaleName(int index) => _languages[index];

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

  Future<void> changeColor(Color color) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final int hex = color.value;
    Interface.setPrimaryColor(color);
    await _sharedPreferences.setInt("color", hex);
    notifyListeners();
  }

  Future<void> changeCompactLogbook() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _compactLogbook--;
    if (_compactLogbook == 0) {
      _compactLogbook = 3;
      await _sharedPreferences.setInt("compactLogbook", _compactLogbook);
    } else {
      await _sharedPreferences.setInt("compactLogbook", _compactLogbook);
    }
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
    if (_mapZonesAccuracy == true) {
      _mapZonesAccuracy = false;
      await _sharedPreferences.setBool("mapZonesAccuracy", false);
    } else {
      _mapZonesAccuracy = true;
      await _sharedPreferences.setBool("mapZonesAccuracy", true);
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

  Future<void> changeEntryDate() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_entryDate == true) {
      _entryDate = false;
      await _sharedPreferences.setBool("entryDate", false);
    } else {
      _entryDate = true;
      await _sharedPreferences.setBool("entryDate", true);
    }
    notifyListeners();
  }

  Future<void> changeTrophyLodgeEntry() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_trophyLodgeEntry == true) {
      _trophyLodgeEntry = false;
      await _sharedPreferences.setBool("trophyLodgeEntry", false);
    } else {
      _trophyLodgeEntry = true;
      await _sharedPreferences.setBool("trophyLodgeEntry", true);
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
