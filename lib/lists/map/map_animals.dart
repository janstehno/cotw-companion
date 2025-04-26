import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/helpers/map.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/map/map_zone.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/map/map_animal.dart';
import 'package:flutter/material.dart';

class ListMapAnimals extends StatelessWidget {
  final HelperMap _helperMap;
  final Map<int, Set<MapZone>?> _zones;

  const ListMapAnimals({
    super.key,
    required HelperMap helperMap,
    required Map<int, Set<MapZone>?> zones,
  })  : _helperMap = helperMap,
        _zones = zones;

  Widget _buildAnimal(BuildContext context, int key, int drinkZones, int feedZones, int restZones) {
    return WidgetPadding.all(
      1,
      child: WidgetMapAnimal(
        name: HelperJSON.getAnimal(key)!.name,
        color: _helperMap.getAnimalColor(_helperMap.zonesKeys(context).indexOf(key)),
        drinkZones: drinkZones,
        feedZones: feedZones,
        restZones: restZones,
      ),
    );
  }

  List<Widget> _listAnimals(BuildContext context) {
    return _zones.entries.map(
      (e) {
        if (e.value != null) {
          int feedZones = e.value!.where((e) => e.zone == 0).length;
          int drinkZones = e.value!.where((e) => e.zone == 1).length;
          int restZones = e.value!.where((e) => e.zone == 2).length;
          return _buildAnimal(context, e.key, drinkZones, feedZones, restZones);
        }
        return const SizedBox.shrink();
      },
    ).toList();
  }

  Widget _buildAnimals(BuildContext context, BoxConstraints constraints, Orientation orientation) {
    return WidgetPadding.all(
      15,
      alignment: Alignment.topLeft,
      background: Interface.alwaysDark.withValues(alpha: 0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._listAnimals(context),
          SizedBox(width: orientation == Orientation.portrait ? constraints.maxWidth : null),
        ],
      ),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    if (_zones.isNotEmpty) {
      Orientation orientation = MediaQuery.orientationOf(context);
      return SizedBox(
        width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width : null,
        height: orientation == Orientation.landscape ? MediaQuery.of(context).size.height : null,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return _buildAnimals(context, constraints, orientation);
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
