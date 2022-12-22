// Copyright (c) 2022 Jan Stehno

class Values {
  static const String appVersion = "1.5.1";
  static const int greatOneID = 100;

  static bool darkMode = false;
  static int fontSize = 2;

  static const int colorZero = 0xFFC2185B;
  static const int colorFirst = 0xFFE53935;
  static const int colorSecond = 0xFFFF5722;
  static const int colorThird = 0xFFFF9800;
  static const int colorFourth = 0xFFFFC107;
  static const int colorFifth = 0xFFFDD835;
  static const int colorSixth = 0xFFCDDC39;
  static const int colorSeventh = 0xFF8BC34A;
  static const int colorEighth = 0xFF4CAF50;
  static const int colorNinth = 0xFF009688;
  static const int colorTenth = 0xFF00ACC1;
  static const int colorEleventh = 0xFF2196F3;
  static const int colorTwelfth = 0xFF1976D2;
  static const int colorThirteenth = 0xFF0D47A1;
  static const int colorFourteenth = 0xFF4527A0;
  static const int colorFifteenth = 0xFF9C27B0;
  static const int colorSixteenth = 0xFF4E342E;
  static const int colorSeventeenth = 0xFFBDBDBD;
  static const int colorTransparent = 0x00000000;

  static const int colorFF = 0xFFFFFFFF;
  static const int colorFE = 0xFFFEFEFE;
  static const int colorF5 = 0xFFF5F5F5;
  static const int colorEF = 0xFFEFEFEF;
  static const int colorEE = 0xFFEEEEEE;
  static const int colorE0 = 0xFFE0E0E0;
  static const int colorCC = 0xFFCCCCCC;
  static const int colorBD = 0xFFBDBDBD;
  static const int color9E = 0xFF9E9E9E;
  static const int color75 = 0xFF757575;
  static const int color61 = 0xFF616161;
  static const int color42 = 0xFF424242;
  static const int color23 = 0xFF232323;
  static const int color21 = 0xFF212121;
  static const int color17 = 0xFF171717;
  static const int color12 = 0xFF121212;
  static const int color0D = 0xFF0D0D0D;
  static const int color06 = 0xFF060606;
  static const int color00 = 0xFF000000;

  static const int colorMapOLH = 0xFFEEEEEE;
  static const int colorMapBackground = 0xFF0D0D0D;
  static const int colorMapWater = 0xFF37474F;
  static const int colorMapRoads = 0xFF1D2429;
  static const int colorMapFields = 0xFFFF9800;

  static double fontSize40 = 40.0;
  static double fontSize30 = 30.0;
  static double fontSize28 = 28.0;
  static double fontSize26 = 26.0;
  static double fontSize24 = 24.0;
  static double fontSize22 = 22.0;
  static double fontSize20 = 20.0;
  static double fontSize18 = 18.0;
  static double fontSize16 = 16.0;
  static double fontSize14 = 14.0;
  static double fontSize12 = 12.0;
  static double fontSize10 = 10.0;

  static double textFieldBottom = 10.0;
  static double textFieldNumberBottom = 8.0;

  static int colorShadow = color00;
  static int colorShadowHead = color42;
  static int colorSwitchStop = colorFirst;
  static int colorSwitchPlay = colorEleventh;
  static int colorListSelected = colorFirst;
  static int colorListUnselected = colorSeventh;
  static int colorBronze = 0xFF8D6E63;
  static int colorSilver = colorBD;
  static int colorGold = colorThird;
  static int colorDiamond = colorEleventh;
  static int colorRarityUncommon = colorSeventh;
  static int colorRarityRare = colorEleventh;
  static int colorRarityVeryRare = colorThird;
  static int colorRarityExtremelyRare = colorThird;
  static int colorRarityMission = colorFirst;
  static int colorZoneFeed = colorSeventh;
  static int colorZoneDrink = colorEleventh;
  static int colorZoneRest = colorThird;
  static int colorMale = colorEleventh;
  static int colorFemale = colorFirst;
  static int colorContentIconTintAlwaysDark = color0D;
  static int colorContentIconTintAlwaysLight = colorF5;
  static int colorAlwaysDark = color0D;
  static int colorAlwaysLight = colorF5;
  static int colorContentNumberOfLogsBackground = color17;

  static int colorSummer = colorFifth;
  static int colorWinter = colorEleventh;
  static int colorFields = colorThird;
  static int colorForest = colorSeventh;
  static int colorPlains = colorThird;
  static int colorLowlands = colorSeventh;
  static int colorHills = colorFifth;
  static int colorMountains = colorEleventh;

  static double widthAccentBorder = 0;

  static int colorPrimary = 0;
  static int colorAccent = 0;
  static int colorDark = 0;
  static int colorLight = 0;
  static int colorFilterTint = 0;
  static int colorFilterBackground = 0;
  static int colorMaximum = 0;
  static int colorMaximumIcon = 0;
  static int colorListDlcBackground = 0;
  static int colorSwitchSelected = 0;
  static int colorSwitchUnselected = 0;
  static int colorSliderThumb = 0;
  static int colorSliderTrack = 0;
  static int colorPagerSelected = 0;
  static int colorPagerUnselected = 0;
  static int colorAccentBorder = 0;
  static int colorBody = 0;
  static int colorDropDownBackground = 0;
  static int colorOdd = 0;
  static int colorEven = 0;
  static int colorContentSubTitle = 0;
  static int colorContentSubTitleBackground = 0;
  static int colorContentSubSubTitleBackground = 0;
  static int colorContentIconTintLight = 0;
  static int colorContentIconTintDark = 0;
  static int colorSearch = 0;
  static int colorSearchBackground = 0;
  static int colorTag = 0;
  static int colorMapButton = 0;
  static int colorOLH = 0;
  static int colorNothing = 0;
  static int colorRarityCommon = 0;
  static int colorZoneOther = 0;
  static int colorDisabled = 0;
  static int colorAnatomyBody = 0;
  static int colorAnatomyBones = 0;
  static int colorSwitchTrophyNoneBackground = 0;
  static int colorSwitchTrophyBronzeBackground = 0;
  static int colorSwitchTrophySilverBackground = 0;
  static int colorSwitchTrophyGoldBackground = 0;
  static int colorSwitchTrophyDiamondBackground = 0;

  static setFontSize(int size) {
    fontSize = size;
    switch (fontSize) {
      case 0:
        {
          fontSize40 = 34.0;
          fontSize30 = 24.0;
          fontSize28 = 22.0;
          fontSize26 = 20.0;
          fontSize24 = 18.0;
          fontSize22 = 16.0;
          fontSize20 = 14.0;
          fontSize18 = 12.0;
          fontSize16 = 10.0;
          fontSize14 = 8.0;
          fontSize12 = 6.0;
          fontSize10 = 4.0;
          textFieldBottom = 16.0;
          textFieldNumberBottom = 13.0;
          break;
        }
      case 1:
        {
          fontSize40 = 36.0;
          fontSize30 = 26.0;
          fontSize28 = 24.0;
          fontSize26 = 22.0;
          fontSize24 = 20.0;
          fontSize22 = 18.0;
          fontSize20 = 16.0;
          fontSize18 = 14.0;
          fontSize16 = 12.0;
          fontSize14 = 10.0;
          fontSize12 = 8.0;
          fontSize10 = 6.0;
          textFieldBottom = 14.0;
          textFieldNumberBottom = 12.0;
          break;
        }
      case 2:
        {
          fontSize40 = 38.0;
          fontSize30 = 28.0;
          fontSize28 = 26.0;
          fontSize26 = 24.0;
          fontSize24 = 22.0;
          fontSize22 = 20.0;
          fontSize20 = 18.0;
          fontSize18 = 16.0;
          fontSize16 = 14.0;
          fontSize14 = 12.0;
          fontSize12 = 10.0;
          fontSize10 = 8.0;
          textFieldBottom = 13.0;
          textFieldNumberBottom = 11.0;
          break;
        }
      case 3:
        {
          fontSize40 = 40.0;
          fontSize30 = 30.0;
          fontSize28 = 28.0;
          fontSize26 = 26.0;
          fontSize24 = 24.0;
          fontSize22 = 22.0;
          fontSize20 = 20.0;
          fontSize18 = 18.0;
          fontSize16 = 16.0;
          fontSize14 = 14.0;
          fontSize12 = 12.0;
          fontSize10 = 10.0;
          textFieldBottom = 11.0;
          textFieldNumberBottom = 8.0;
          break;
        }
    }
  }

  static setPrimaryColor(int primaryColor) {
    colorPrimary = primaryColor;
    colorMaximum = colorPrimary;
    colorListDlcBackground = colorPrimary;
    colorSwitchSelected = colorPrimary;
    colorSliderThumb = colorPrimary;
    colorPagerSelected = colorPrimary;
    colorMapButton = colorPrimary;

    colorAccentBorder = colorTransparent;
    widthAccentBorder = 0;

    if (primaryColor == colorZero ||
        primaryColor == colorThirteenth ||
        primaryColor == colorFourteenth ||
        primaryColor == colorFifteenth ||
        primaryColor == colorSixteenth) {
      colorAccent = colorEE;
      if (darkMode) {
        colorAccentBorder = colorEE;
        widthAccentBorder = 1;
      }
    } else {
      colorAccent = color12;
    }
  }

  static setColors(bool b) {
    darkMode = b;
    if (b) {
      //DARK MODE
      colorFilterTint = color0D;
      colorFilterBackground = colorF5;

      colorBody = color06;

      colorOdd = color06;
      colorEven = color0D;
      colorContentSubTitle = colorF5;
      colorContentSubTitleBackground = color12;
      colorContentSubSubTitleBackground = color0D;

      colorLight = color0D;
      colorDark = colorF5;
      colorContentIconTintLight = color0D;
      colorContentIconTintDark = colorF5;

      colorSearch = colorF5;
      colorSearchBackground = color21;

      colorTag = color23;
      colorMaximumIcon = color23;
      colorPagerUnselected = color23;
      colorSwitchUnselected = color23;
      colorDropDownBackground = color17;

      colorOLH = colorF5;

      colorNothing = color17;
      colorZoneOther = colorF5;
      colorRarityCommon = colorF5;

      colorAnatomyBones = colorBD;
      colorAnatomyBody = color42;
      colorSliderTrack = color42;

      colorDisabled = color75;

      colorSwitchTrophyNoneBackground = colorEE;
      colorSwitchTrophyBronzeBackground = colorBronze;
      colorSwitchTrophySilverBackground = colorBD;
      colorSwitchTrophyGoldBackground = colorGold;
      colorSwitchTrophyDiamondBackground = colorDiamond;
    } else {
      //LIGHT MODE
      colorFilterTint = colorF5;
      colorFilterBackground = color0D;

      colorBody = colorFF;

      colorOdd = colorFF;
      colorEven = colorF5;
      colorContentSubTitle = color0D;
      colorContentSubTitleBackground = colorEE;
      colorContentSubSubTitleBackground = colorF5;

      colorLight = colorF5;
      colorDark = color0D;
      colorContentIconTintLight = colorF5;
      colorContentIconTintDark = color0D;

      colorSearch = color0D;
      colorSearchBackground = colorE0;
      colorPagerUnselected = colorEE;
      colorSwitchUnselected = colorEE;
      colorDropDownBackground = colorE0;

      colorTag = colorCC;
      colorMaximumIcon = colorCC;

      colorOLH = color0D;

      colorNothing = colorEE;
      colorZoneOther = color0D;
      colorRarityCommon = color0D;

      colorAnatomyBones = color42;
      colorAnatomyBody = colorBD;
      colorSliderTrack = colorBD;

      colorDisabled = color9E;

      colorSwitchTrophyNoneBackground = color23;
      colorSwitchTrophyBronzeBackground = colorBronze;
      colorSwitchTrophySilverBackground = colorBD;
      colorSwitchTrophyGoldBackground = colorGold;
      colorSwitchTrophyDiamondBackground = colorDiamond;
    }
  }
}
