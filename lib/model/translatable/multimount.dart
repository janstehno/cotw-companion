import 'package:cotwcompanion/helpers/log.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';

class Multimount extends Translatable {
  final int _price;
  final int _size;
  final List<dynamic> _animals;

  Multimount({
    required super.id,
    required super.name,
    required int price,
    required int size,
    required List<dynamic> animals,
  })  : _price = price,
        _size = size,
        _animals = animals;

  int get price => _price;

  int get size => _size;

  String get sizeAsString => _size.toString().toUpperCase();

  List<dynamic> get animals => _animals;

  factory Multimount.fromJson(Map<String, dynamic> json) {
    return Multimount(
      id: json['ID'],
      name: json['NAME'],
      price: json['PRICE'],
      size: json['SIZE'],
      animals: json['ANIMALS'].map((e) => MultimountAnimal.fromJson(e)).toList(),
    );
  }

  static Comparator<Multimount> sortByName = (a, b) => a.name.compareTo(b.name);
}

class MultimountAnimal {
  final int _id;
  final bool _gender;
  final int _count;

  MultimountAnimal({
    required id,
    required gender,
    required count,
  })  : _id = id,
        _gender = gender,
        _count = count;

  int get id => _id;

  bool get isFemale => !_gender;

  bool get isMale => _gender;

  int get count => _count;

  bool isInTrophyLodge(Set<Log> usedLogs) {
    Log? log = HelperLog.isMultimountAnimalInTrophyLodge(this, usedLogs);
    if (log == null) {
      return false;
    }
    usedLogs.add(log);
    return true;
  }

  factory MultimountAnimal.fromJson(Map<String, dynamic> json) {
    return MultimountAnimal(
      id: json['ID'],
      gender: json['GENDER'] == 1,
      count: json['COUNT'],
    );
  }
}
