// Copyright (c) 2022 Jan Stehno

import 'package:flutter/material.dart';

class Interface {
  static const String version = "1.6.3";
  static const int greatOneId = 100;

  static bool _darkMode = false;
  static int _fontSize = 2;

  static double s40 = 40.0;
  static double s30 = 30.0;
  static double s28 = 28.0;
  static double s26 = 26.0;
  static double s24 = 24.0;
  static double s22 = 22.0;
  static double s20 = 20.0;
  static double s18 = 18.0;
  static double s16 = 16.0;
  static double s14 = 14.0;
  static double s12 = 12.0;
  static double s10 = 10.0;

  static double textFieldBottomPadding = 10.0;
  static double textFieldNumberBottom = 8.0;
  static double accentBorderWidth = 0;

  static const Color pink = Color(0xFFC2185B);
  static const Color red = Color(0xFFE53935);
  static const Color redorange = Color(0xFFFF5722);
  static const Color orange = Color(0xFFFF9800);
  static const Color yellow = Color(0xFFFFC107);
  static const Color lightyellow = Color(0xFFFDD835);
  static const Color grassgreen = Color(0xFFCDDC39);
  static const Color lightgreen = Color(0xFF8BC34A);
  static const Color green = Color(0xFF4CAF50);
  static const Color teal = Color(0xFF009688);
  static const Color lightblue = Color(0xFF00ACC1);
  static const Color blue = Color(0xFF2196F3);
  static const Color darkblue = Color(0xFF1976D2);
  static const Color deepblue = Color(0xFF0D47A1);
  static const Color purple = Color(0xFF4527A0);
  static const Color darkpink = Color(0xFF9C27B0);
  static const Color lightbrown = Color(0xFF8D6E63);
  static const Color brown = Color(0xFF4E342E);
  static const Color grey = Color(0xFFBDBDBD);

  static const Color ffff = Color(0xFFFFFFFF);
  static const Color fffe = Color(0xFFFEFEFE);
  static const Color fff5 = Color(0xFFF5F5F5);
  static const Color ffef = Color(0xFFEFEFEF);
  static const Color ffee = Color(0xFFEEEEEE);
  static const Color ffe0 = Color(0xFFE0E0E0);
  static const Color ffcc = Color(0xFFCCCCCC);
  static const Color ffbd = Color(0xFFBDBDBD);
  static const Color ff9e = Color(0xFF9E9E9E);
  static const Color ff75 = Color(0xFF757575);
  static const Color ff61 = Color(0xFF616161);
  static const Color ff42 = Color(0xFF424242);
  static const Color ff23 = Color(0xFF232323);
  static const Color ff21 = Color(0xFF212121);
  static const Color ff17 = Color(0xFF171717);
  static const Color ff12 = Color(0xFF121212);
  static const Color ff0d = Color(0xFF0D0D0D);
  static const Color ff06 = Color(0xFF060606);
  static const Color ff00 = Color(0xFF000000);

  static const Color shadow = ff00;
  static const Color shadowAnimalHead = ff42;
  static const Color stop = red;
  static const Color play = blue;
  static const Color selected = red;
  static const Color unselected = lightgreen;
  static const Color trophyBronze = lightbrown;
  static const Color trophySilver = ffbd;
  static const Color trophyGold = orange;
  static const Color trophyDiamond = blue;
  static const Color uncommon = lightgreen;
  static const Color rare = blue;
  static const Color veryrare = orange;
  static const Color extremelyRare = orange;
  static const Color mission = red;
  static const Color feed = lightgreen;
  static const Color drink = blue;
  static const Color rest = orange;
  static const Color male = blue;
  static const Color female = red;
  static const Color alwaysDark = ff0d;
  static const Color alwaysLight = fff5;
  static const Color logsInfoBackground = ff17;
  static const Color colorMapOLH = ffee;
  static const Color colorMapBackground = ff0d;
  static const Color summer = yellow;
  static const Color winter = blue;
  static const Color field = orange;
  static const Color forest = lightgreen;
  static const Color plains = orange;
  static const Color lowlands = lightgreen;
  static const Color hills = yellow;
  static const Color mountains = blue;

  static Color primary = Colors.transparent;
  static Color accent = Colors.transparent;
  static Color dark = Colors.transparent;
  static Color light = Colors.transparent;
  static Color maximum = Colors.transparent;
  static Color maximumIcon = Colors.transparent;
  static Color accentBorder = Colors.transparent;
  static Color mainBody = Colors.transparent;
  static Color dropDownBody = Colors.transparent;
  static Color odd = Colors.transparent;
  static Color even = Colors.transparent;
  static Color title = Colors.transparent;
  static Color subTitleBackground = Colors.transparent;
  static Color subSubTitleBackground = Colors.transparent;
  static Color search = Colors.transparent;
  static Color searchBackground = Colors.transparent;
  static Color tag = Colors.transparent;
  static Color nothing = Colors.transparent;
  static Color common = Colors.transparent;
  static Color other = Colors.transparent;
  static Color disabled = Colors.transparent;
  static Color anatomyBody = Colors.transparent;
  static Color anatomyBones = Colors.transparent;
  static Color trophyNoneBackground = Colors.transparent;
  static Color trophyBronzeBackground = Colors.transparent;
  static Color trophySilverBackground = Colors.transparent;
  static Color trophyGoldBackground = Colors.transparent;
  static Color trophyDiamondBackground = Colors.transparent;

  static void setFontSize(int size) {
    _fontSize = size;
    switch (_fontSize) {
      case 0:
        {
          s40 = 34.0;
          s30 = 24.0;
          s28 = 22.0;
          s26 = 20.0;
          s24 = 18.0;
          s22 = 16.0;
          s20 = 14.0;
          s18 = 12.0;
          s16 = 10.0;
          s14 = 8.0;
          s12 = 6.0;
          s10 = 4.0;
          textFieldBottomPadding = 16.0;
          textFieldNumberBottom = 13.0;
          break;
        }
      case 1:
        {
          s40 = 36.0;
          s30 = 26.0;
          s28 = 24.0;
          s26 = 22.0;
          s24 = 20.0;
          s22 = 18.0;
          s20 = 16.0;
          s18 = 14.0;
          s16 = 12.0;
          s14 = 10.0;
          s12 = 8.0;
          s10 = 6.0;
          textFieldBottomPadding = 14.0;
          textFieldNumberBottom = 12.0;
          break;
        }
      case 2:
        {
          s40 = 38.0;
          s30 = 28.0;
          s28 = 26.0;
          s26 = 24.0;
          s24 = 22.0;
          s22 = 20.0;
          s20 = 18.0;
          s18 = 16.0;
          s16 = 14.0;
          s14 = 12.0;
          s12 = 10.0;
          s10 = 8.0;
          textFieldBottomPadding = 13.0;
          textFieldNumberBottom = 11.0;
          break;
        }
      case 3:
        {
          s40 = 40.0;
          s30 = 30.0;
          s28 = 28.0;
          s26 = 26.0;
          s24 = 24.0;
          s22 = 22.0;
          s20 = 20.0;
          s18 = 18.0;
          s16 = 16.0;
          s14 = 14.0;
          s12 = 12.0;
          s10 = 10.0;
          textFieldBottomPadding = 11.0;
          textFieldNumberBottom = 8.0;
          break;
        }
    }
  }

  static void setPrimaryColor(Color primaryColor) {
    primary = primaryColor;
    maximum = primary;

    accentBorder = Colors.transparent;
    accentBorderWidth = 0;

    if (primaryColor == pink || primaryColor == deepblue || primaryColor == purple || primaryColor == darkpink || primaryColor == brown) {
      accent = ffee;
      if (_darkMode) {
        accentBorder = ffee;
        accentBorderWidth = 1;
      }
    } else {
      accent = ff12;
    }
  }

  static void setColors(bool darkMode) {
    _darkMode = darkMode;
    if (darkMode) {
      //DARK MODE
      mainBody = ff06;

      odd = ff06;
      even = ff0d;
      title = fff5;
      subTitleBackground = ff12;
      subSubTitleBackground = ff0d;

      light = ff0d;
      dark = fff5;

      search = fff5;
      searchBackground = ff21;

      tag = ff23;
      maximumIcon = ff23;
      dropDownBody = ff17;

      nothing = ff17;
      other = fff5;
      common = fff5;

      anatomyBones = ffbd;
      anatomyBody = ff42;

      disabled = ff75;

      trophyNoneBackground = ffee;
      trophyBronzeBackground = trophyBronze;
      trophySilverBackground = ffbd;
      trophyGoldBackground = trophyGold;
      trophyDiamondBackground = trophyDiamond;
    } else {
      //LIGHT MODE
      mainBody = ffff;

      odd = ffff;
      even = fff5;
      title = ff0d;
      subTitleBackground = ffee;
      subSubTitleBackground = fff5;

      light = fff5;
      dark = ff0d;

      search = ff0d;
      searchBackground = ffe0;
      dropDownBody = ffe0;

      tag = ffcc;
      maximumIcon = ffcc;

      nothing = ffee;
      other = ff0d;
      common = ff0d;

      anatomyBones = ff42;
      anatomyBody = ffbd;

      disabled = ff9e;

      trophyNoneBackground = ff23;
      trophyBronzeBackground = trophyBronze;
      trophySilverBackground = ffbd;
      trophyGoldBackground = trophyGold;
      trophyDiamondBackground = trophyDiamond;
    }
  }
}
