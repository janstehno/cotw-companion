import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/connect/animal_reserve.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';

class Reserve extends Translatable {
  final int _count;
  final int _summer;
  final int _winter;
  final int _plains;
  final int _fields;
  final int _lowlands;
  final int _hills;
  final int _mountains;
  final int _forest;
  final bool _dlc;

  Reserve({
    required super.id,
    required super.name,
    required int count,
    required int summer,
    required int winter,
    required int plains,
    required int fields,
    required int lowlands,
    required int hills,
    required int mountains,
    required int forest,
    required bool dlc,
  })  : _count = count,
        _summer = summer,
        _winter = winter,
        _plains = plains,
        _fields = fields,
        _lowlands = lowlands,
        _hills = hills,
        _mountains = mountains,
        _forest = forest,
        _dlc = dlc;

  int get count => _count;

  bool get isFromDlc => _dlc;

  bool get hasSummer => _summer == 1;

  bool get hasWinter => _winter == 1;

  bool get hasPlains => _plains == 1;

  bool get hasFields => _fields == 1;

  bool get hasLowlands => _lowlands == 1;

  bool get hasHills => _hills == 1;

  bool get hasMountains => _mountains == 1;

  bool get hasForest => _forest == 1;

  List<int> get allClasses {
    List<int> classes = [];
    for (AnimalReserve ar in HelperJSON.animalsReserves) {
      if (ar.reserveId == id) {
        int level = HelperJSON.getAnimal(ar.animalId)!.level;
        if (!classes.contains(level)) {
          classes.add(level);
        }
      }
    }
    return classes;
  }

  factory Reserve.fromJson(Map<String, dynamic> json) {
    return Reserve(
      id: json["ID"],
      name: json["NAME"],
      count: json["COUNT"],
      summer: json["ENVIRONMENT"]["SUMMER"],
      winter: json["ENVIRONMENT"]["WINTER"],
      plains: json["ENVIRONMENT"]["PLAINS"],
      fields: json["ENVIRONMENT"]["FIELDS"],
      lowlands: json["ENVIRONMENT"]["LOWLANDS"],
      hills: json["ENVIRONMENT"]["HILLS"],
      mountains: json["ENVIRONMENT"]["MOUNTAINS"],
      forest: json["ENVIRONMENT"]["FOREST"],
      dlc: json["DLC"] == 1,
    );
  }

  static Comparator<Reserve> sortById = (a, b) => a.id.compareTo(b.id);
}
