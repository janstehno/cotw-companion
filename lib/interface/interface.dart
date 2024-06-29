import 'package:flutter/material.dart';

class Interface {
  static const Color transparent = Colors.transparent;

  static const Color primaryDark = Color(0xFFBF6F06);
  static const Color primary = Color(0xFFF8981D);

  static const Color alwaysDark = ff0d;
  static const Color alwaysLight = fff5;
  static const Color shadow = ff42;

  static Color dark = Colors.transparent;
  static Color light = Colors.transparent;
  static Color accentBorder = Colors.transparent;
  static Color body = Colors.transparent;
  static Color dropDown = Colors.transparent;
  static Color odd = Colors.transparent;
  static Color even = Colors.transparent;
  static Color title = Colors.transparent;
  static Color subtitle = Colors.transparent;
  static Color search = Colors.transparent;
  static Color tag = Colors.transparent;
  static Color disabled = Colors.transparent;
  static Color disabledForeground = Colors.transparent;

  static Color anatomyBody = Colors.transparent;
  static Color anatomyBones = Colors.transparent;
  static Color zoneOther = Colors.transparent;
  static Color zoneNothing = Colors.transparent;
  static Color trophyNone = Colors.transparent;
  static Color trophyGreatOne = Colors.transparent;
  static Color rarityCommon = Colors.transparent;

  static ColorScheme datePickerScheme = const ColorScheme.dark();

  static const Color grey = Color(0xFF9E9E9E);
  static const Color red = Color(0xFFE53935);
  static const Color orange = Color(0xFFFF9800);
  static const Color yellow = Color(0xFFFFC107);
  static const Color lightGreen = Color(0xFF8BC34A);
  static const Color green = Color(0xFF4CAF50);
  static const Color blue = Color(0xFF2196F3);
  static const Color oceanBlue = Color(0xFF1976D2);
  static const Color purple = Color(0xFF7E57C2);
  static const Color lightBrown = Color(0xFF8D6E63);

  static const Color timerStop = red;
  static const Color timerPlay = blue;
  static const Color itemSelected = red;
  static const Color itemUnselected = lightGreen;
  static const Color trophyBronze = lightBrown;
  static const Color trophySilver = grey;
  static const Color trophyGold = orange;
  static const Color trophyDiamond = blue;
  static const Color rarityUncommon = lightGreen;
  static const Color rarityRare = blue;
  static const Color rarityVeryRare = purple;
  static const Color rarityMission = red;
  static const Color rarityGreatOne = orange;
  static const Color zoneFeed = lightGreen;
  static const Color zoneDrink = blue;
  static const Color zoneRest = orange;
  static const Color genderMale = blue;
  static const Color genderFemale = red;
  static const Color environmentSummer = yellow;
  static const Color environmentWinter = blue;
  static const Color environmentField = orange;
  static const Color environmentForest = lightGreen;
  static const Color environmentPlains = orange;
  static const Color environmentLowlands = lightGreen;
  static const Color environmentHills = yellow;
  static const Color environmentMountains = blue;

  static const Color ffff = Color(0xFFFFFFFF);
  static const Color fffe = Color(0xFFFEFEFE); //odd, body
  static const Color fff5 = Color(0xFFF5F5F5); //even, dark, light
  static const Color ffef = Color(0xFFEFEFEF); //subtitle
  static const Color ffee = Color(0xFFEEEEEE); //dropDown, search, nothing, other, common, title
  static const Color ffe0 = Color(0xFFE0E0E0);
  static const Color ffcc = Color(0xFFCCCCCC); //tag
  static const Color ffbd = Color(0xFFBDBDBD); //anatomy
  static const Color ff9e = Color(0xFF9E9E9E); //disabled
  static const Color ff75 = Color(0xFF757575);
  static const Color ff61 = Color(0xFF616161); //disabled
  static const Color ff42 = Color(0xFF424242); //anatomy, shadow
  static const Color ff23 = Color(0xFF232323); //tag
  static const Color ff21 = Color(0xFF212121);
  static const Color ff17 = Color(0xFF171717); //dropDown, search, nothing, other, common, accent, title
  static const Color ff12 = Color(0xFF121212); //subtitle
  static const Color ff0d = Color(0xFF0D0D0D); //even, dark, light
  static const Color ff06 = Color(0xFF060606); //odd, body
  static const Color ff00 = Color(0xFF000000);

  static void setColors(bool darkMode) {
    if (darkMode) {
      body = ff06;
      odd = ff0d;
      even = ff06;
      title = ff17;
      subtitle = ff12;
      light = ff0d;
      dark = fff5;
      search = ff17;
      tag = ff23;
      dropDown = ff06;
      disabled = ff61;
      disabledForeground = alwaysLight.withOpacity(0.5);
      anatomyBones = ffbd;
      anatomyBody = ff42;
      zoneOther = ffee;
      zoneNothing = ff17;
      trophyNone = ffee;
      trophyGreatOne = ffee;
      rarityCommon = ffee;
      datePickerScheme = ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: alwaysDark,
        secondary: body,
        onSecondary: dark,
        surface: subtitle,
        onSurface: dark,
        surfaceContainerHighest: dark,
        surfaceTint: disabled,
        error: body,
        onError: red,
      );
    } else {
      body = fffe;
      odd = fff5;
      even = fffe;
      title = ffee;
      subtitle = ffef;
      light = fff5;
      dark = ff0d;
      search = ffee;
      dropDown = fffe;
      tag = ffcc;
      disabled = ff9e;
      disabledForeground = alwaysDark.withOpacity(0.5);
      anatomyBones = ff42;
      anatomyBody = ffbd;
      zoneOther = ff17;
      zoneNothing = ffee;
      trophyNone = ff17;
      trophyGreatOne = ff17;
      rarityCommon = ff17;
      datePickerScheme = ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: alwaysDark,
        secondary: body,
        onSecondary: dark,
        surface: subtitle,
        onSurface: dark,
        surfaceContainerHighest: dark,
        surfaceTint: disabled,
        error: body,
        onError: red,
      );
    }
  }
}
