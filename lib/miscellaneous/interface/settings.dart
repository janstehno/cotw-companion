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
    Locale('en'),
    Locale('ru'),
    Locale('cs'),
    Locale('pl'),
    Locale('de'),
    Locale('fr'),
    Locale('es'),
    Locale('pt', 'BR'),
    Locale('pt', 'PT'),
    Locale('ja'),
    Locale('hu'),
    Locale('tr'),
  ];

  late int _language;
  late int _color;
  late int _compactLogbook;
  late bool _darkMode;
  late bool _imperialUnits;
  late bool _mapZonesType;
  late bool _mapZonesStyle;
  late bool _mapZonesAccuracy;
  late bool _bestWeaponsForAnimal;
  late bool _dateOfRecord;
  late bool _trophyLodgeRecord;
  late bool _furRarityPerCent;
  late SharedPreferences _sharedPreferences;

  Settings(
      {language,
      color,
      fontSize,
      compactLogbook,
      bool darkMode = false,
      bool imperialUnits = false,
      bool mapZonesType = false,
      bool mapZonesStyle = false,
      bool mapZonesAccuracy = false,
      bool bestWeaponsForAnimal = false,
      bool dateOfRecord = false,
      bool trophyLodgeRecord = false,
      bool furRarityPerCent = false}) {
    _language = language;
    _color = color;
    _compactLogbook = compactLogbook;
    _darkMode = darkMode;
    _imperialUnits = imperialUnits;
    _mapZonesType = mapZonesType;
    _mapZonesStyle = mapZonesStyle;
    _mapZonesAccuracy = mapZonesAccuracy;
    _bestWeaponsForAnimal = bestWeaponsForAnimal;
    _dateOfRecord = dateOfRecord;
    _trophyLodgeRecord = trophyLodgeRecord;
    _furRarityPerCent = furRarityPerCent;
  }

  int get getColor => _color;

  int get getCompactLogbook => _compactLogbook;

  bool get getDarkMode => _darkMode;

  bool get getImperialUnits => _imperialUnits;

  bool get getMapZonesType => _mapZonesType;

  bool get getMapZonesStyle => _mapZonesStyle;

  bool get getMapZonesAccuracy => _mapZonesAccuracy;

  bool get getBestWeaponsForAnimal => _bestWeaponsForAnimal;

  bool get getDateOfRecord => _dateOfRecord;

  bool get getTrophyLodgeRecord => _trophyLodgeRecord;

  bool get getFurRarityPerCent => _furRarityPerCent;

  int get getLanguage => _language;

  List<String> get getLanguages => _languages;

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
