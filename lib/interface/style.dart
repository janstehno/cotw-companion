import 'package:cotwcompanion/generated/fonts.gen.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:flutter/material.dart';

class $StyleNormal {
  const $StyleNormal();

  $StyleNormalSize8 get s8 => const $StyleNormalSize8();

  $StyleNormalSize10 get s10 => const $StyleNormalSize10();

  $StyleNormalSize12 get s12 => const $StyleNormalSize12();

  $StyleNormalSize14 get s14 => const $StyleNormalSize14();

  $StyleNormalSize16 get s16 => const $StyleNormalSize16();

  $StyleNormalSize18 get s18 => const $StyleNormalSize18();

  $StyleNormalSize22 get s22 => const $StyleNormalSize22();
}

class $StyleNormalSize8 {
  const $StyleNormalSize8();

  TextStyle get w300 => const TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w300,
        fontFamily: FontFamily.normal,
        height: Values.smallLineHeight,
      );

  TextStyle get w500 => w300.copyWith(fontWeight: FontWeight.w500);
}

class $StyleNormalSize10 {
  const $StyleNormalSize10();

  TextStyle get w300 => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w300,
        fontFamily: FontFamily.normal,
        height: Values.smallLineHeight,
      );

  TextStyle get w500 => w300.copyWith(fontWeight: FontWeight.w500);
}

class $StyleNormalSize12 {
  const $StyleNormalSize12();

  TextStyle get w300 => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        fontFamily: FontFamily.normal,
        height: Values.smallLineHeight,
      );

  TextStyle get w500 => w300.copyWith(fontWeight: FontWeight.w500);
}

class $StyleNormalSize14 {
  const $StyleNormalSize14();

  TextStyle get w300 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.normal,
        height: Values.normalLineHeight,
      );

  TextStyle get w500 => w300.copyWith(fontWeight: FontWeight.w500);
}

class $StyleNormalSize16 {
  const $StyleNormalSize16();

  TextStyle get w300 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        fontFamily: FontFamily.normal,
        height: Values.normalLineHeight,
      );

  TextStyle get w500 => w300.copyWith(fontWeight: FontWeight.w500);

  TextStyle get w700 => w300.copyWith(fontWeight: FontWeight.w700);
}

class $StyleNormalSize18 {
  const $StyleNormalSize18();

  TextStyle get w300 => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        fontFamily: FontFamily.normal,
        height: Values.normalLineHeight,
      );

  TextStyle get w500 => w300.copyWith(fontWeight: FontWeight.w500);
}

class $StyleNormalSize22 {
  const $StyleNormalSize22();

  TextStyle get w400 => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.normal,
        height: Values.normalLineHeight,
      );
}

class $StyleCondensed {
  const $StyleCondensed();

  $StyleCondensedSize16 get s16 => const $StyleCondensedSize16();

  $StyleCondensedSize18 get s18 => const $StyleCondensedSize18();

  $StyleCondensedSize20 get s20 => const $StyleCondensedSize20();

  $StyleCondensedSize24 get s24 => const $StyleCondensedSize24();

  $StyleCondensedSize26 get s26 => const $StyleCondensedSize26();

  $StyleCondensedSize28 get s28 => const $StyleCondensedSize28();
}

class $StyleCondensedSize16 {
  const $StyleCondensedSize16();

  TextStyle get w600 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.condensed,
        height: Values.condensedLineHeight,
      );
}

class $StyleCondensedSize18 {
  const $StyleCondensedSize18();

  TextStyle get w400 => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.condensed,
        height: Values.condensedLineHeight,
      );

  TextStyle get w600 => w400.copyWith(fontWeight: FontWeight.w600);
}

class $StyleCondensedSize20 {
  const $StyleCondensedSize20();

  TextStyle get w600 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.condensed,
        height: Values.condensedLineHeight,
      );
}

class $StyleCondensedSize24 {
  const $StyleCondensedSize24();

  TextStyle get w600 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.condensed,
        height: Values.condensedLineHeight,
      );
}

class $StyleCondensedSize26 {
  const $StyleCondensedSize26();

  TextStyle get w600 => const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.condensed,
        height: Values.condensedLineHeight,
      );
}

class $StyleCondensedSize28 {
  const $StyleCondensedSize28();

  TextStyle get w600 => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.condensed,
        height: Values.condensedLineHeight,
      );
}

class Style {
  Style._();

  static const $StyleNormal normal = $StyleNormal();
  static const $StyleCondensed condensed = $StyleCondensed();
}
