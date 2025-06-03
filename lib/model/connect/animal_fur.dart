import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';

class AnimalFur {
  final int _id;
  final int _animalId;
  final int _furId;
  final FurRarity _rarity;
  final double _perCent;
  final bool _male;
  final bool _female;

  AnimalFur({
    required int id,
    required int animalId,
    required int furId,
    required FurRarity rarity,
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

  FurRarity get rarity => _rarity;

  double get perCent => _perCent;

  bool get male => _male && !_female;

  bool get female => _female && !_male;

  String get animalName {
    return HelperJSON.getAnimal(_animalId)!.name;
  }

  String get furName {
    return HelperJSON.getFur(_furId)!.name;
  }

  factory AnimalFur.fromJson(Map<String, dynamic> json) {
    return AnimalFur(
      id: json['ID'],
      animalId: json['ANIMAL_ID'],
      furId: json['FUR_ID'],
      rarity: FurRarity.values.firstWhere((e) => e.id == json['RARITY']),
      perCent: json['PERCENT'],
      male: json['MALE'],
      female: json['FEMALE'],
      chosen: false,
    );
  }

  static Comparator<AnimalFur> sortByAnimalName = (a, b) => a.animalName.compareTo(b.animalName);

  static Comparator<AnimalFur> sortByFurName = (a, b) => a.furName.compareTo(b.furName);

  static Comparator<AnimalFur> sortByRarityFurName = (a, b) {
    if (a.rarity == b.rarity) return a.furName.compareTo(b.furName);
    return a.rarity.index.compareTo(b.rarity.index);
  };

  static Comparator<AnimalFur> sortByPercentAnimalName = (a, b) {
    if (a.perCent == b.perCent) return a.animalName.compareTo(b.animalName);
    return b.perCent.compareTo(a.perCent);
  };

  static Comparator<AnimalFur> sortByGenderRarityPercentFurName = (a, b) {
    if (a.male && a.female && (!b.male || !b.female)) return 1;
    if (!a.male && !a.female && (b.male || b.female)) return -1;
    if (a.male && !b.male) return -1;
    if (a.female && !b.female) return -1;
    if (a.rarity != b.rarity) return b.rarity.index.compareTo(a.rarity.index);
    if (a.perCent != b.perCent) return a.perCent.compareTo(b.perCent);
    return a.furName.compareTo(b.furName);
  };
}
