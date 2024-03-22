import 'package:cotwcompanion/model/describable/describable.dart';

class Dlc extends Describable {
  final int _type;
  final String _date;
  List<dynamic> _reserve;
  List<dynamic> _animals;
  List<dynamic> _weapons;
  List<dynamic> _callers;

  Dlc({
    required super.id,
    required super.name,
    required super.description,
    required int type,
    required String date,
    required List<dynamic> reserve,
    required List<dynamic> animals,
    required List<dynamic> weapons,
    required List<dynamic> callers,
  })  : _type = type,
        _date = date,
        _reserve = reserve,
        _animals = animals,
        _weapons = weapons,
        _callers = callers;

  String get date => _date;

  int get type => _type;

  List<int> get reserve => _reserve.cast();

  List<int> get animals => _animals.cast();

  List<int> get weapons => _weapons.cast();

  List<int> get callers => _callers.cast();

  factory Dlc.fromJson(Map<String, dynamic> json) {
    return Dlc(
      id: json['ID'],
      name: json['NAME'],
      date: json['DATE'],
      type: json['TYPE'],
      description: json['DESCRIPTION'] ?? [],
      reserve: json['CONTENT']['RESERVE'] ?? [],
      animals: json['CONTENT']['ANIMALS'] ?? [],
      weapons: json['CONTENT']['WEAPONS'] ?? [],
      callers: json['CONTENT']['CALLERS'] ?? [],
    );
  }

  static Comparator<Dlc> sortByDate = (a, b) => b.date.compareTo(a.date);
}
