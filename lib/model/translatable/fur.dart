import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';

class Fur extends Translatable {
  Fur({
    required super.id,
    required super.name,
  });

  factory Fur.fromJson(Map<String, dynamic> json) {
    return Fur(
      id: json['ID'],
      name: json['NAME'],
    );
  }

  bool get isMission => HelperJSON.animalsFurs.any((f) => f.furId == id && f.rarity == FurRarity.mission);

  bool get isGreatOne => asset.contains("FABLED") || id == Values.greatOneId;

  static Comparator<Fur> sortByName = (a, b) => a.name.compareTo(b.name);
}
