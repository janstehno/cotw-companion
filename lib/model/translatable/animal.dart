import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class Animal extends Translatable {
  final String _latin;

  final List<dynamic> _reserves;
  final List<dynamic> _callers;

  final int _level;
  final int _difficulty;
  final double _silver;
  final double _gold;
  final double _diamond;

  final double _maxTrophyMale;
  final double _minTrophyMale;
  final double _maxWeightMale;
  final double _minWeightMale;

  final double _maxTrophyFemale;
  final double _minTrophyFemale;
  final double _maxWeightFemale;
  final double _minWeightFemale;

  final double _maxTrophyGO;
  final double _minTrophyGO;
  final double _maxWeightGO;
  final double _minWeightGO;

  final List<dynamic> _taxonomy;
  final List<dynamic> _furGO;
  final int _sight;
  final int _hearing;
  final int _smell;
  final bool _diamondFemale;
  final bool _grounded;
  final bool _dlc;

  Animal({
    required super.id,
    required super.name,
    required String latin,
    required List<dynamic> reserves,
    required List<dynamic> callers,
    required int level,
    required int difficulty,
    required double silver,
    required double gold,
    required double diamond,
    required double maxTrophyMale,
    required double minTrophyMale,
    required double maxWeightMale,
    required double minWeightMale,
    required double maxTrophyFemale,
    required double minTrophyFemale,
    required double maxWeightFemale,
    required double minWeightFemale,
    required double maxTrophyGO,
    required double minTrophyGO,
    required double maxWeightGO,
    required double minWeightGO,
    required List<dynamic> taxonomy,
    required List<dynamic> furGO,
    required int sight,
    required int hearing,
    required int smell,
    required bool diamondFemale,
    required bool grounded,
    required bool dlc,
  })  : _latin = latin,
        _reserves = reserves,
        _callers = callers,
        _level = level,
        _difficulty = difficulty,
        _silver = silver,
        _gold = gold,
        _diamond = diamond,
        _maxTrophyMale = maxTrophyMale,
        _minTrophyMale = minTrophyMale,
        _maxWeightMale = maxWeightMale,
        _minWeightMale = minWeightMale,
        _maxTrophyFemale = maxTrophyFemale,
        _minTrophyFemale = minTrophyFemale,
        _maxWeightFemale = maxWeightFemale,
        _minWeightFemale = minWeightFemale,
        _maxTrophyGO = maxTrophyGO,
        _minTrophyGO = minTrophyGO,
        _maxWeightGO = maxWeightGO,
        _minWeightGO = minWeightGO,
        _taxonomy = taxonomy,
        _furGO = furGO,
        _sight = sight,
        _hearing = hearing,
        _smell = smell,
        _diamondFemale = diamondFemale,
        _grounded = grounded,
        _dlc = dlc;

  String get latin => _latin;

  List<int> get reserves => _reserves.cast();

  List<int> get callers => _callers.cast();

  int get level => _level;

  int get difficulty => _difficulty;

  double get silver => _silver;

  double get gold => _gold;

  double get diamond => _diamond;

  double trophy(ThresholdLevel threshold, CategoryType category) {
    switch (threshold) {
      case ThresholdLevel.min:
        return _minTrophy(category);
      case ThresholdLevel.max:
        return _maxTrophy(category);
    }
  }

  double _minTrophy(CategoryType category) {
    switch (category) {
      case CategoryType.male:
        return _minTrophyMale;
      case CategoryType.female:
        return _minTrophyFemale;
      case CategoryType.go:
        return _minTrophyGO;
    }
  }

  double _maxTrophy(CategoryType category) {
    switch (category) {
      case CategoryType.male:
        return _maxTrophyMale;
      case CategoryType.female:
        return _maxTrophyFemale;
      case CategoryType.go:
        return _maxTrophyGO;
    }
  }

  bool get femaleTrophy => _maxTrophyFemale != 0.0;

  double weight(ThresholdLevel threshold, CategoryType category, Units units) {
    switch (threshold) {
      case ThresholdLevel.min:
        return _minWeight(category, units);
      case ThresholdLevel.max:
        return _maxWeight(category, units);
    }
  }

  double _minWeight(CategoryType category, Units units) {
    switch (category) {
      case CategoryType.male:
        return units == Units.metric ? _minWeightMale : _minWeightMale * 2.2046;
      case CategoryType.female:
        return units == Units.metric ? _minWeightFemale : _minWeightFemale * 2.2046;
      case CategoryType.go:
        return units == Units.metric ? _minWeightGO : _minWeightGO * 2.2046;
    }
  }

  double _maxWeight(CategoryType category, Units units) {
    switch (category) {
      case CategoryType.male:
        return units == Units.metric ? _maxWeightMale : _maxWeightMale * 2.2046;
      case CategoryType.female:
        return units == Units.metric ? _maxWeightFemale : _maxWeightFemale * 2.2046;
      case CategoryType.go:
        return units == Units.metric ? _maxWeightGO : _maxWeightGO * 2.2046;
    }
  }

  List<dynamic> get taxonomy => _taxonomy;

  List<dynamic> get furGO => _furGO;

  bool get femaleDiamond => _diamondFemale;

  bool get grounded => _grounded;

  bool get isFromDlc => _dlc;

  bool get hasUncommonFurs => HelperJSON.getAnimalFurs(id).any((e) => e.rarity == FurRarity.uncommon);

  bool get hasRareFurs => HelperJSON.getAnimalFurs(id).any((e) => e.rarity == FurRarity.rare);

  bool get hasMissionFurs => HelperJSON.getAnimalFurs(id).any((e) => e.rarity == FurRarity.mission);

  bool get hasGO => HelperJSON.getAnimalFurs(id).any((e) => e.rarity == FurRarity.greatOne);

  bool get hasFeedZones => HelperJSON.getAnimalZonesFor(this).entries.any((e) => e.value.any((z) => z.zone == 0));

  bool get hasDrinkZones => HelperJSON.getAnimalZonesFor(this).entries.any((e) => e.value.any((z) => z.zone == 1));

  bool get hasRestZones => HelperJSON.getAnimalZonesFor(this).entries.any((e) => e.value.any((z) => z.zone == 2));

  bool get hasActiveZones => HelperJSON.getAnimalZonesFor(this).entries.any((e) => e.value.any((z) => z.zone == 3));

  bool get hasSenses => _sight > 0 || _hearing > 0 || _smell > 0;

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['ID'],
      name: json['NAME'],
      latin: json['LATIN'],
      reserves: json["RESERVES"] ?? [],
      callers: json["CALLERS"] ?? [],
      level: json['LEVEL'],
      difficulty: json['DIFFICULTY'],
      silver: json['SILVER'],
      gold: json['GOLD'],
      diamond: json['DIAMOND'],
      maxTrophyMale: json['MAX_TROPHY_MALE'] ?? 0.0,
      minTrophyMale: json['MIN_TROPHY_MALE'] ?? 0.0,
      maxWeightMale: json['MAX_WEIGHT_MALE'] ?? 0.0,
      minWeightMale: json['MIN_WEIGHT_MALE'] ?? 0.0,
      maxTrophyFemale: json['MAX_TROPHY_FEMALE'] ?? 0.0,
      minTrophyFemale: json['MIN_TROPHY_FEMALE'] ?? 0.0,
      maxWeightFemale: json['MAX_WEIGHT_FEMALE'] ?? 0.0,
      minWeightFemale: json['MIN_WEIGHT_FEMALE'] ?? 0.0,
      maxTrophyGO: json['MAX_TROPHY_GO'] ?? 0.0,
      minTrophyGO: json['MIN_TROPHY_GO'] ?? 0.0,
      maxWeightGO: json['MAX_WEIGHT_GO'] ?? 0.0,
      minWeightGO: json['MIN_WEIGHT_GO'] ?? 0.0,
      taxonomy: json["TAXONOMY"] ?? [],
      furGO: json["FUR_GO"] ?? [],
      sight: json['SIGHT'],
      hearing: json['HEARING'],
      smell: json['SMELL'],
      diamondFemale: json['DIAMOND_FEMALE'] ?? false,
      grounded: json['GROUNDED'] ?? false,
      dlc: json['DLC'],
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

  int senseStrength(Sense sense) {
    switch (sense) {
      case Sense.sight:
        return _sight;
      case Sense.hearing:
        return _hearing;
      case Sense.smell:
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

  String trophyAsString(double trophy) => Utils.removePointZero(trophy, 2);

  String weightAsString(ThresholdLevel threshold, CategoryType category, Units units) =>
      "${Utils.removePointZero(weight(threshold, category, units), 2)} ${units == Units.metric ? tr("KILOGRAMS") : tr("POUNDS")}";

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
