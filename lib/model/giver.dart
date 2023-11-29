// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/model/translatable.dart';

class Giver extends Translatable {
  Giver({
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
  });

  factory Giver.fromJson(Map<String, dynamic> json) {
    return Giver(
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
    );
  }
}
