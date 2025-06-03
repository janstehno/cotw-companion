import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/describable.dart';

class Dlc extends Describable {
  final DlcType _type;
  final String _date;
  int? _reserve;
  List<dynamic> _animals;
  List<dynamic> _weapons;
  List<dynamic> _callers;

  Dlc({
    required super.id,
    required super.name,
    required super.description,
    required DlcType type,
    required String date,
    required int? reserve,
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

  DlcType get type => _type;

  int? get reserve => _reserve;

  List<int> get animals => _animals.cast();

  List<int> get weapons => _weapons.cast();

  List<int> get callers => _callers.cast();

  factory Dlc.fromJson(Map<String, dynamic> json) {
    return Dlc(
      id: json['ID'],
      name: json['NAME'],
      date: json['DATE'],
      type: DlcType.values.firstWhere((e) => e.id == json['TYPE']),
      description: json['DESCRIPTION'] ?? [],
      reserve: json['CONTENT']?['RESERVE'],
      animals: json['CONTENT']?['ANIMALS'] ?? [],
      weapons: json['CONTENT']?['WEAPONS'] ?? [],
      callers: json['CONTENT']?['CALLERS'] ?? [],
    );
  }

  static Comparator<Dlc> sortById = (a, b) => a.id.compareTo(b.id);

  static Comparator<Dlc> sortByDate = (a, b) => b.date.compareTo(a.date);
}
