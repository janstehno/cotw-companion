import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:easy_localization/easy_localization.dart';

class Ammo extends Translatable {
  final int _min;
  final int _max;
  final int _rangeM;
  final double _rangeYD;
  final int _penetration;
  final int _expansion;
  final int _price;
  final int _score;
  final bool _dlc;

  Ammo({
    required super.id,
    required super.name,
    required int min,
    required int max,
    required int rangeM,
    required double rangeYD,
    required int penetration,
    required int expansion,
    required int price,
    required int score,
    required bool dlc,
  })  : _min = min,
        _max = max,
        _rangeM = rangeM,
        _rangeYD = rangeYD,
        _penetration = penetration,
        _expansion = expansion,
        _price = price,
        _score = score,
        _dlc = dlc;

  int get min => _min;

  int get max => _max;

  int get penetration => _penetration;

  int get expansion => _expansion;

  int get price => _price;

  int get score => _score;

  bool get isFromDlc => _dlc;

  bool get hasRequirements => _score > 0;

  String get classRange => _min == _max ? _min.toString() : "$_min - $_max";

  double range(bool units) => units ? _rangeYD : _rangeM.toDouble();

  String getRange(bool units) => units ? "$_rangeYD ${tr("YARDS")}" : "$_rangeM ${tr("METERS")}";

  List<int> get levels {
    List<int> levels = [];
    for (int level = min; level <= max; level++) {
      levels.add(level);
    }
    return levels;
  }

  factory Ammo.fromJson(Map<String, dynamic> json) {
    return Ammo(
      id: json['ID'],
      name: json['NAME'],
      min: json['MIN_LEVEL'],
      max: json['MAX_LEVEL'],
      rangeM: json['RANGE_M'],
      rangeYD: json['RANGE_YD'],
      penetration: json['PENETRATION'],
      expansion: json['EXPANSION'],
      price: json['PRICE'],
      score: json['SCORE'],
      dlc: json['DLC'] == 1,
    );
  }

  static Comparator<Ammo> sortByName = (a, b) => a.name.compareTo(b.name);
}
