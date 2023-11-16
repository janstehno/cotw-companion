// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
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
  final List<Locale> _languageCodes = const [
    Locale("en"),
    Locale("ru"),
    Locale("cs"),
    Locale("pl"),
    Locale("de"),
    Locale("fr"),
    Locale("es"),
    Locale("pt', 'BR"),
    Locale("pt', 'PT"),
    Locale("ja"),
    Locale("hu"),
    Locale("tr"),
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
  late bool _dateOfRecord;
  late bool _trophyLodgeRecord;
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
    required dateOfRecord,
    required trophyLodgeRecord,
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

    _dateOfRecord = dateOfRecord;

    _trophyLodgeRecord = trophyLodgeRecord;

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

  bool get dateOfRecord => _dateOfRecord;

  bool get trophyLodgeRecord => _trophyLodgeRecord;

  bool get furRarityPerCent => _furRarityPerCent;

  int get language => _language;

  List<String> get languages => _languages;

  Locale getLocale(int index) => _languageCodes[index];

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

  Future<void> changeDateOfRecord() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_dateOfRecord == true) {
      _dateOfRecord = false;
      await _sharedPreferences.setBool("dateOfRecord", false);
    } else {
      _dateOfRecord = true;
      await _sharedPreferences.setBool("dateOfRecord", true);
    }
    notifyListeners();
  }

  Future<void> changeTrophyLodgeRecord() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_trophyLodgeRecord == true) {
      _trophyLodgeRecord = false;
      await _sharedPreferences.setBool("trophyLodgeRecord", false);
    } else {
      _trophyLodgeRecord = true;
      await _sharedPreferences.setBool("trophyLodgeRecord", true);
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
