import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';

class Reserve extends Translatable {
  final int _count;
  final bool _summer;
  final bool _winter;
  final bool _plains;
  final bool _fields;
  final bool _lowlands;
  final bool _hills;
  final bool _mountains;
  final bool _forest;
  final bool _dlc;

  Reserve({
    required super.id,
    required super.name,
    required int count,
    required bool summer,
    required bool winter,
    required bool plains,
    required bool fields,
    required bool lowlands,
    required bool hills,
    required bool mountains,
    required bool forest,
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

  bool get hasSummer => _summer;

  bool get hasWinter => _winter;

  bool get hasPlains => _plains;

  bool get hasFields => _fields;

  bool get hasLowlands => _lowlands;

  bool get hasHills => _hills;

  bool get hasMountains => _mountains;

  bool get hasForest => _forest;

  List<int> get allClasses {
    List<int> classes = [];
    for (Animal animal in HelperJSON.getReserveAnimals(id)) {
      if (animal.reserves.contains(id)) {
        int level = animal.level;
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
      dlc: json["DLC"],
    );
  }

  static Comparator<Reserve> sortById = (a, b) => a.id.compareTo(b.id);
}
