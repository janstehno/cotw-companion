// Copyright (c) 2023 Jan Stehno

import 'package:flutter/material.dart';

abstract class Translatable {
  final int _id;
  final String _en, _ru, _cs, _pl, _de, _fr, _es, _br, _ja, _zh;

  Translatable({
    required id,
    required en,
    required ru,
    required cs,
    required pl,
    required de,
    required fr,
    required es,
    required br,
    required ja,
    required zh,
  })  : _id = id,
        _en = en,
        _ru = ru ?? "",
        _cs = cs ?? "",
        _pl = pl ?? "",
        _de = de ?? "",
        _fr = fr ?? "",
        _es = es ?? "",
        _br = br ?? "",
        _ja = ja ?? "",
        _zh = zh ?? "";

  int get id => _id;

  String get en => _en;

  String getName(Locale locale) {
    String result;
    switch (locale.languageCode.toString()) {
      case "ru":
        result = _ru;
        break;
      case "cs":
        result = _cs;
        break;
      case "pl":
        result = _pl;
        break;
      case "de":
        result = _de;
        break;
      case "fr":
        result = _fr;
        break;
      case "es":
        result = _es;
        break;
      case "br":
        result = _br;
        break;
      case "pt":
        result = _br;
        break;
      case "ja":
        result = _ja;
        break;
      case "zh":
        result = _zh;
        break;
      default:
        return _en;
    }
    return result.isEmpty ? _en : result;
  }
}
