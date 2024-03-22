import 'package:easy_localization/easy_localization.dart';

abstract class Translatable {
  final int _id;
  final String _name;

  Translatable({
    required int id,
    required String name,
  })  : _id = id,
        _name = name;

  int get id => _id;

  String get name => tr(_name);

  String get asset => _name;
}
