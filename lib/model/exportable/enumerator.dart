import 'dart:core';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/exportable/exportable.dart';

class Enumerator extends Exportable {
  String _name;
  int _order;
  final List<dynamic> _counters;

  Enumerator({
    required String name,
    required int order,
    counters,
  })  : _name = name,
        _order = order,
        _counters = counters ?? [];

  String get name => _name;

  int get order => _order;

  List<Counter> get counters => _counters.cast();

  void setName(String name) => _name = name;

  void setOrder(int newOrder) => _order = newOrder;

  void sortCounters() => _counters.sorted(Counter.sortByOrder);

  void addCounter(Counter counter) => _counters.add(counter);

  void removeCounter(Counter counter) => _counters.remove(counter);

  void removeAllCounters() => _counters.clear();

  static Enumerator create(int order, String name, List<Counter> counters) {
    return Enumerator(
      name: name,
      order: order,
      counters: counters,
    );
  }

  factory Enumerator.fromJson(Map<String, dynamic> json) {
    return Enumerator(
      name: json['NAME'],
      order: json['ID'],
      counters: json['COUNTERS'].map((e) => Counter.fromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return '''{
      "NAME":"$_name",
      "ID":$_order,
      "COUNTERS":${HelperJSON.listToJson(_counters)}
      }''';
  }

  static Comparator<Enumerator> sortByOrder = (a, b) => a.order.compareTo(b.order);
}

class Counter extends Exportable {
  String _name;
  int _order;
  int _value;

  Counter({
    required name,
    required order,
    required value,
  })  : _name = name,
        _order = order ?? 0,
        _value = value ?? 0;

  String get name => _name;

  int get order => _order;

  int get value => _value;

  void setName(String name) => _name = name;

  void setOrder(int newOrder) => _order = newOrder;

  void add() => _value++;

  void subtract() => _value--;

  void setValue(int value) => _value = value;

  static Counter create(String name, int order, int value) {
    return Counter(
      name: name,
      order: order,
      value: value,
    );
  }

  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(
      name: json['NAME'],
      order: json['ID'],
      value: json['VALUE'],
    );
  }

  @override
  String toString() {
    return '''{
      "NAME":"$_name",
      "ID":$_order,
      "VALUE":$_value
    }''';
  }

  static Comparator<dynamic> sortByOrder = (a, b) => a.order.compareTo(b.order);
}
