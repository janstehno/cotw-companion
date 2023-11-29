// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/model/translatable.dart';

class Multimount extends Translatable {
  final int _price;
  final int _size;
  final List<dynamic> _animals;

  Multimount({
    required super.id,
    required super.en,
    required super.ru,
    required super.cs,
    required super.pl,
    required super.de,
    required super.fr,
    required super.es,
    required super.br,
    required super.ja,
    required price,
    required size,
    required animals,
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
      en: json['EN'],
      ru: json['RU'],
      cs: json['CS'],
      pl: json['PL'],
      de: json['DE'],
      fr: json['FR'],
      es: json['ES'],
      br: json['BR'],
      ja: json['JA'],
      price: json['PRICE'],
      size: json['SIZE'],
      animals: json['ANIMALS'].map((e) => MultimountAnimal.fromJson(e)).toList(),
    );
  }
}

class MultimountAnimal {
  final int _id;
  final int _gender;
  final int _count;

  MultimountAnimal({
    required id,
    required gender,
    required count,
  })  : _id = id,
        _gender = gender,
        _count = count;

  int get id => _id;

  int get gender => _gender;

  bool get isFemale => _gender == 0;

  bool get isMale => _gender == 1;

  int get count => _count;

  factory MultimountAnimal.fromJson(Map<String, dynamic> json) {
    return MultimountAnimal(
      id: json['ID'],
      gender: json['GENDER'],
      count: json['COUNT'],
    );
  }
}
