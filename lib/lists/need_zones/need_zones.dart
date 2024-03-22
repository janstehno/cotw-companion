import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/connect/animal_zone.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/parts/need_zones/need_zone.dart';
import 'package:flutter/material.dart';

class ListNeedZones extends StatelessWidget {
  final Reserve _reserve;
  final Map<int, bool> _classes;
  final int _hour;
  final bool _compact, _classSwitches;

  const ListNeedZones(
    Reserve reserve, {
    super.key,
    required Map<int, bool> classes,
    required int hour,
    required bool compact,
    required bool classSwitches,
  })  : _reserve = reserve,
        _classes = classes,
        _hour = hour,
        _compact = compact,
        _classSwitches = classSwitches;

  List<Animal> get _animals =>
      HelperJSON.getReserveAnimals(_reserve.id).where((e) => _classes[e.level - 1]!).toList();

  Widget _buildEntry(int i, Animal animal) {
    List<AnimalZone> zones = HelperJSON.getAnimalZones(animal.id, _reserve.id);

    return WidgetNeedZone(
      i,
      animal: animal,
      reserve: _reserve,
      hour: _hour,
      count: _animals.length,
      compact: _compact,
      classSwitches: _classSwitches,
      zones: zones,
    );
  }

  List<Widget> _listNeedZones(BuildContext context) {
    return _animals
        .sorted(Animal.sortByLevelNameByReserve(context, _reserve))
        .mapIndexed((i, animal) => _buildEntry(i, animal))
        .toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(children: _listNeedZones(context));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
