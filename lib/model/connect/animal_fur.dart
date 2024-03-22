import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AnimalFur {
  final int _id;
  final int _animalId;
  final int _furId;
  final int _rarity;
  final double _perCent;
  final bool _male;
  final bool _female;

  AnimalFur({
    required int id,
    required int animalId,
    required int furId,
    required int rarity,
    required double perCent,
    required bool male,
    required bool female,
    required bool chosen,
  })  : _id = id,
        _animalId = animalId,
        _furId = furId,
        _rarity = rarity,
        _perCent = perCent,
        _male = male,
        _female = female;

  int get id => _id;

  int get animalId => _animalId;

  int get furId => _furId;

  int get rarity => _rarity;

  double get perCent => _perCent;

  bool get male => _male;

  bool get female => _female;

  Color get color {
    switch (_rarity) {
      case 0:
        return Interface.rarityCommon;
      case 1:
        return Interface.rarityUncommon;
      case 2:
        return Interface.rarityRare;
      case 3:
        return Interface.rarityVeryRare;
      case 4:
        return Interface.rarityMission;
      case 5:
        return Interface.rarityGreatOne;
      default:
        return Interface.disabled;
    }
  }

  static String rarityName(int rarity) {
    switch (rarity) {
      case 0:
        return tr("RARITY_COMMON");
      case 1:
        return tr("RARITY_UNCOMMON");
      case 2:
        return tr("RARITY_RARE");
      case 3:
        return tr("RARITY_VERY_RARE");
      default:
        return tr("RARITY_MISSION");
    }
  }

  String get furName {
    return _rarity == 5 ? HelperJSON.getFur(_furId)!.name : HelperJSON.getFur(_furId)!.name;
  }

  factory AnimalFur.fromJson(Map<String, dynamic> json) {
    return AnimalFur(
      id: json['ID'],
      animalId: json['ANIMAL_ID'],
      furId: json['FUR_ID'],
      rarity: json['RARITY'],
      perCent: json['PERCENT'],
      male: json['MALE'] == 1,
      female: json['FEMALE'] == 1,
      chosen: false,
    );
  }

  static Comparator<AnimalFur> sortByPercent = (a, b) => a.perCent.compareTo(b.perCent);

  static Comparator<AnimalFur> sortByGenderRarityPercentName = (a, b) {
    if (a.male && a.female && (!b.male || !b.female)) return 1;
    if (!a.male && !a.female && (b.male || b.female)) return -1;
    if (a.male && !b.male) return -1;
    if (a.female && !b.female) return -1;
    if (a.rarity != b.rarity) return b.rarity.compareTo(a.rarity);
    if (a.perCent != b.perCent) return a.perCent.compareTo(b.perCent);
    return a.furName.compareTo(b.furName);
  };
}
