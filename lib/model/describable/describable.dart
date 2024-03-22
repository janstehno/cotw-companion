import 'package:cotwcompanion/model/translatable/translatable.dart';

abstract class Describable extends Translatable {
  final List<dynamic> _description;

  Describable({
    required super.id,
    required super.name,
    required List<dynamic> description,
  }) : _description = description;

  List<dynamic> get description => _description;
}
