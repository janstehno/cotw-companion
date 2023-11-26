import 'package:flutter/material.dart';

abstract class Translatable {
  final int id;
  final String en, ru, cs, pl, de, fr, es, br, ja;

  Translatable({
    required this.id,
    required this.en,
    required this.ru,
    required this.cs,
    required this.pl,
    required this.de,
    required this.fr,
    required this.es,
    required this.br,
    required this.ja,
  });

  String getName(Locale locale) {
    switch (locale.languageCode.toString()) {
      case "ru":
        return ru.isEmpty ? en : ru;
      case "cs":
        return cs.isEmpty ? en : cs;
      case "pl":
        return pl.isEmpty ? en : pl;
      case "de":
        return de.isEmpty ? en : de;
      case "fr":
        return fr.isEmpty ? en : fr;
      case "es":
        return es.isEmpty ? en : es;
      case "br":
        return br.isEmpty ? en : br;
      case "pt":
        return br.isEmpty ? en : br;
      case "ja":
        return ja.isEmpty ? en : ja;
      case "sk":
        return cs.isEmpty ? en : cs;
      default:
        return en;
    }
  }
}
