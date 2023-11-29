// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/model/translatable.dart';
import 'package:flutter/material.dart';

abstract class Describable extends Translatable {
  List<dynamic> _dEn, _dRu, _dCs, _dPl, _dDe, _dFr, _dEs, _dBr, _dJa, _dHu;

  Describable({
    required super.id,
    required super.en,
    super.ru,
    super.cs,
    super.pl,
    super.de,
    super.fr,
    super.es,
    super.br,
    super.ja,
    required dEn,
    required dRu,
    required dCs,
    required dPl,
    required dDe,
    required dFr,
    required dEs,
    required dBr,
    required dJa,
    dHu,
  })  : _dEn = dEn ?? [],
        _dRu = dRu ?? [],
        _dCs = dCs ?? [],
        _dPl = dPl ?? [],
        _dDe = dDe ?? [],
        _dFr = dFr ?? [],
        _dEs = dEs ?? [],
        _dBr = dBr ?? [],
        _dJa = dJa ?? [],
        _dHu = dHu ?? [];

  set setEn(List<dynamic> en) => _dEn = en;

  set setRu(List<dynamic> ru) => _dRu = ru;

  set setCs(List<dynamic> cs) => _dCs = cs;

  set setPl(List<dynamic> pl) => _dPl = pl;

  set setDe(List<dynamic> de) => _dDe = de;

  set setFr(List<dynamic> fr) => _dFr = fr;

  set setEs(List<dynamic> es) => _dEs = es;

  set setBr(List<dynamic> br) => _dBr = br;

  set setJa(List<dynamic> ja) => _dJa = ja;

  set setHu(List<dynamic> hu) => _dHu = hu;

  List<dynamic> getDescription(Locale locale) {
    List<dynamic> result = [];
    switch (locale.languageCode.toString()) {
      case "ru":
        result.addAll(_dRu);
        break;
      case "cs":
        result.addAll(_dCs);
        break;
      case "pl":
        result.addAll(_dPl);
        break;
      case "de":
        result.addAll(_dDe);
        break;
      case "fr":
        result.addAll(_dFr);
        break;
      case "es":
        result.addAll(_dEs);
        break;
      case "br":
        result.addAll(_dBr);
        break;
      case "pt":
        result.addAll(_dBr);
        break;
      case "ja":
        result.addAll(_dJa);
        break;
      case "hu":
        result.addAll(_dHu);
        break;
      default:
        result.addAll(_dEn);
    }
    if (result.isEmpty) result.addAll(_dEn);
    return result;
  }
}
