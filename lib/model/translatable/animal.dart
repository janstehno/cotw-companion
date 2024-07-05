import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class Animal extends Translatable {
  final int _level;
  final int _difficulty;
  final double _silver;
  final double _gold;
  final double _diamond;
  final double _trophy;
  final double _weightKG;
  final double _weightLB;
  final double _trophyGO;
  final double _weightGOKG;
  final double _weightGOLB;
  final int _sight;
  final int _hearing;
  final int _smell;
  final bool _diamondFemale;
  final bool _grounded;
  final bool _dlc;

  Animal({
    required super.id,
    required super.name,
    required int level,
    required int difficulty,
    required double silver,
    required double gold,
    required double diamond,
    required double trophy,
    required double weightKG,
    required double weightLB,
    required double trophyGO,
    required double weightGOKG,
    required double weightGOLB,
    required int sight,
    required int hearing,
    required int smell,
    required bool diamondFemale,
    required bool grounded,
    required bool dlc,
  })  : _level = level,
        _difficulty = difficulty,
        _silver = silver,
        _gold = gold,
        _diamond = diamond,
        _trophy = trophy,
        _weightKG = weightKG,
        _weightLB = weightLB,
        _trophyGO = trophyGO,
        _weightGOKG = weightGOKG,
        _weightGOLB = weightGOLB,
        _sight = sight,
        _hearing = hearing,
        _smell = smell,
        _diamondFemale = diamondFemale,
        _grounded = grounded,
        _dlc = dlc;

  int get level => _level;

  int get difficulty => _difficulty;

  double get silver => _silver;

  double get gold => _gold;

  double get diamond => _diamond;

  double get trophy => _trophy;

  double get trophyGO => _trophyGO;

  double get weightKG => _weightKG;

  double get weightLB => _weightLB;

  double weight(bool units) => units ? _weightLB : _weightKG;

  double get weightGOKG => _weightGOKG;

  double get weightGOLB => _weightGOLB;

  double weightGO(bool units) => units ? _weightGOLB : _weightGOKG;

  bool get femaleDiamond => _diamondFemale;

  bool get grounded => _grounded;

  bool get isFromDlc => _dlc;

  bool get hasGO => _trophyGO != -1;

  bool get hasSenses => _sight > 0 || _hearing > 0 || _smell > 0;

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['ID'],
      name: json['NAME'],
      level: json['LEVEL'],
      difficulty: json['DIFFICULTY'],
      silver: json['SILVER'],
      gold: json['GOLD'],
      diamond: json['DIAMOND'],
      trophy: json['TROPHY'],
      weightKG: json['WEIGHT_KG'],
      weightLB: json['WEIGHT_LB'],
      trophyGO: json['TROPHY_GO'] ?? -1.0,
      weightGOKG: json['WEIGHT_GO_KG'] ?? -1.0,
      weightGOLB: json['WEIGHT_GO_LB'] ?? -1.0,
      sight: json['SIGHT'],
      hearing: json['HEARING'],
      smell: json['SMELL'],
      diamondFemale: (json['DIAMOND_FEMALE'] ?? 0) == 1,
      grounded: (json['GROUNDED'] ?? 0) == 1,
      dlc: json['DLC'] == 1,
    );
  }

  @override
  String toString() {
    return "$id";
  }

  String getNameByLocale(Locale locale) {
    if (name.split("/").length > 1) {
      return "${name.split("/")[0]} & ${name.split("/")[1]}";
    } else {
      return name;
    }
  }

  String getNameByReserve(Locale locale, Reserve? reserve) {
    if (reserve == null) return getNameByLocale(locale);
    if ((locale.languageCode.toString() == "en" && id == 34 && reserve.id == 5 /*Puma in PF*/) ||
        ((locale.languageCode.toString() == "en" || locale.languageCode.toString() == "cs") &&
            id == 55 &&
            (reserve.id == 9 || reserve.id == 14) /*Feral Pig in TANP & ECA*/) ||
        (locale.languageCode.toString() != "pl" && (id == 60 && reserve.id == 10) /*Mexican Bobcat in RDA*/)) {
      return name.split("/")[0];
    } else if ((locale.languageCode.toString() == "en" && id == 34 && reserve.id == 8 /*Mountain Lion in SRP*/) ||
        ((locale.languageCode.toString() == "en" || locale.languageCode.toString() == "cs") &&
            id == 55 &&
            reserve.id == 11 /*Wild Hog in MAP*/) ||
        (locale.languageCode.toString() != "pl" && (id == 60 && reserve.id == 13) /*Bobcat in NEM*/)) {
      return name.split("/")[1];
    } else {
      return name;
    }
  }

  int senseStrength(SenseType sense) {
    switch (sense) {
      case SenseType.sight:
        return _sight;
      case SenseType.hearing:
        return _hearing;
      case SenseType.smell:
        return _smell;
    }
  }

  Color senseColor(int sense) {
    switch (sense) {
      case 0:
        return Interface.transparent;
      case 1:
        return Interface.red;
      case 2:
        return Interface.orange;
      case 3:
        return Interface.yellow;
      default:
        return Interface.green;
    }
  }

  String trophyAsString(double trophy) => Utils.removePointZero(trophy);

  String weightAsString(bool units) =>
      "${Utils.removePointZero(weight(units))} ${units ? tr("POUNDS") : tr("KILOGRAMS")}";

  String weightGOAsString(bool units) =>
      "${Utils.removePointZero(weightGO(units))} ${units ? tr("POUNDS") : tr("KILOGRAMS")}";

  static Comparator<Animal> sortById = (a, b) => a.id.compareTo(b.id);

  static Comparator<Animal> sortByLevel = (a, b) => a.level.compareTo(b.level);

  static Comparator<Animal> sortByNameByLocale(BuildContext context) =>
      (a, b) => a.getNameByLocale(context.locale).compareTo(b.getNameByLocale(context.locale));

  static Comparator<Animal> sortByNameByReserve(BuildContext context, Reserve? reserve) =>
      (a, b) => a.getNameByReserve(context.locale, reserve).compareTo(b.getNameByReserve(context.locale, reserve));

  static Comparator<Animal> sortByLevelNameByReserve(BuildContext context, Reserve? reserve) => (a, b) {
        if (a.level == b.level) {
          return a.getNameByReserve(context.locale, reserve).compareTo(b.getNameByReserve(context.locale, reserve));
        }
        return a.level.compareTo(b.level);
      };
}
