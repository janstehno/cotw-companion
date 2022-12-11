// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  late int _language;
  late int _color;
  late int _fontSize;
  late int _compactLogbook;
  late bool _darkMode;
  late bool _imperialUnits;
  late bool _furRarityPerCent;
  late bool _dateOfRecord;
  late bool _trophyLodgeRecord;
  late bool _bestWeaponsForAnimal;
  late SharedPreferences _sharedPreferences;

  Settings(
      {bool darkMode = false,
      bool imperialUnits = false,
      language,
      color,
      fontSize,
      compactLogbook,
      bool furRarityPerCent = false,
      bool dateOfRecord = false,
      bool trophyLodgeRecord = false,
      bool bestWeaponsForAnimal = false}) {
    _darkMode = darkMode;
    _imperialUnits = imperialUnits;
    _language = language;
    _color = color;
    _fontSize = fontSize;
    _compactLogbook = compactLogbook;
    _furRarityPerCent = furRarityPerCent;
    _dateOfRecord = dateOfRecord;
    _trophyLodgeRecord = trophyLodgeRecord;
    _bestWeaponsForAnimal = bestWeaponsForAnimal;
  }

  //['en', 'ru', 'cs', 'pl', 'de', 'fr', 'es', 'pt', 'ja']
  int get getLanguage => _language;

  int get getColor => _color;

  int get getFontSize => _fontSize;

  int get getCompactLogbook => _compactLogbook;

  bool get getDarkMode => _darkMode;

  bool get getImperialUnits => _imperialUnits;

  bool get getFurRarityPerCent => _furRarityPerCent;

  bool get getDateOfRecord => _dateOfRecord;

  bool get getTrophyLodgeRecord => _trophyLodgeRecord;

  bool get getBestWeaponsForAnimal => _bestWeaponsForAnimal;

  Future<void> changeTheme() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_darkMode == true) {
      _darkMode = false;
      Values.setColors(_darkMode);
      await _sharedPreferences.setBool("darkMode", false);
    } else {
      _darkMode = true;
      Values.setColors(_darkMode);
      await _sharedPreferences.setBool("darkMode", true);
    }
    notifyListeners();
  }

  Future<void> changeUnits() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_imperialUnits == true) {
      _imperialUnits = false;
      await _sharedPreferences.setBool("imperialUnits", false);
    } else {
      _imperialUnits = true;
      await _sharedPreferences.setBool("imperialUnits", true);
    }
    notifyListeners();
  }

  Future<void> changeLanguage(int l) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _language = l;
    await _sharedPreferences.setInt("language", l);
    notifyListeners();
  }

  Future<void> changeColor(int color) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _color = color;
    Values.setPrimaryColor(_color);
    await _sharedPreferences.setInt("color", color);
    notifyListeners();
  }

  Future<void> changeFontSize(int size) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _fontSize = size;
    Values.setFontSize(_fontSize);
    await _sharedPreferences.setInt("fontSize", size);
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
}
