import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:easy_localization/easy_localization.dart';

class Caller extends Translatable {
  final int _rangeM;
  final double _rangeYD;
  final int _duration;
  final int _strength;
  final int _price;
  final int _level;
  final bool _dlc;

  Caller({
    required super.id,
    required super.name,
    required int rangeM,
    required double rangeYD,
    required int duration,
    required int strength,
    required int price,
    required int level,
    required bool dlc,
  })  : _rangeM = rangeM,
        _rangeYD = rangeYD,
        _duration = duration,
        _strength = strength,
        _price = price,
        _level = level,
        _dlc = dlc;

  int get strength => _strength;

  int get duration => _duration;

  int get price => _price;

  int get level => _level;

  int get rangeM => _rangeM;

  double get rangeYD => _rangeYD;

  bool get isFromDlc => _dlc;

  bool get hasRequirements => _level > 0;

  String getRange(bool units) => units ? "$rangeYD ${tr("YARDS")}" : "$rangeM ${tr("METERS")}";

  factory Caller.fromJson(Map<String, dynamic> json) {
    return Caller(
      id: json['ID'],
      name: json['NAME'],
      rangeM: json['RANGE_M'],
      rangeYD: json['RANGE_YD'],
      duration: json['DURATION'],
      strength: json['STRENGTH'],
      price: json['PRICE'],
      level: json['LEVEL'],
      dlc: json['DLC'],
    );
  }

  @override
  String toString() {
    return id.toString();
  }

  static Comparator<Caller> sortByName = (a, b) => a.name.compareTo(b.name);
}
