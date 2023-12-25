// Copyright (c) 2023 Jan Stehno

import 'dart:core';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';

class Enumerator {
  int _id;
  String _name;
  List<dynamic> _counters;

  Enumerator({
    required id,
    required name,
    required counters,
  })  : _id = id,
        _name = name,
        _counters = counters;

  int get id => _id;

  String get name => _name;

  List<dynamic> get counters => _counters;

  Counter counterOnIndex(int id) => _counters.elementAt(id);

  set setId(int id) => _id = id;

  void sortCounters() => _counters.sort((a, b) => a.id.compareTo(b.id));

  void addCounter(Counter counter) => _counters.add(counter);

  void removeCounterOnIndex(int id) => _counters.removeAt(id);

  void removeAllCounters() => _counters.clear();

  @override
  String toString() => '{"ID":$_id,"NAME":"$_name","COUNTERS":${HelperJSON.listToJson(_counters)}}';

  factory Enumerator.fromJson(Map<String, dynamic> json) {
    return Enumerator(
      id: json['ID'],
      name: json['NAME'],
      counters: json['COUNTERS'].map((e) => Counter.fromJson(e)).toList(),
    );
  }
}

class Counter {
  int _id;
  String _name;
  int _value;

  Counter({
    required id,
    required name,
    required value,
  })  : _id = id,
        _name = name,
        _value = value;

  int get id => _id;

  String get name => _name;

  int get value => _value;

  set setId(int id) => _id = id;

  void add() => _value++;

  void subtract() => _value--;

  void set(int value) => _value = value;

  @override
  String toString() => '{"ID":$_id,"NAME":"$_name","VALUE":$_value}';

  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(
      id: json['ID'],
      name: json['NAME'],
      value: json['VALUE'],
    );
  }
}
