import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/parts/reserve/animal.dart';
import 'package:flutter/material.dart';

class ListReserveAnimals extends StatelessWidget {
  final Reserve _reserve;

  const ListReserveAnimals(
    Reserve reserve, {
    super.key,
  }) : _reserve = reserve;

  List<Animal> get _animals => HelperJSON.getReserveAnimals(_reserve.id);

  void _onTap(BuildContext context, Animal animal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => ActivityDetailAnimal(animal, reserve: _reserve)),
    );
  }

  Widget _buildEntry(int i, Animal animal, BuildContext context) {
    return WidgetReserveAnimal(
      animal,
      reserve: _reserve,
      background: Utils.backgroundAt(i),
      context: context,
      indicatorColor: Interface.primary,
      isShown: animal.isFromDlc,
      onTap: () => _onTap(context, animal),
    );
  }

  List<Widget> _listAnimals(BuildContext context) {
    return _animals
        .sorted(Animal.sortByLevelNameByReserve(context, _reserve))
        .mapIndexed((i, animal) => _buildEntry(i, animal, context))
        .toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(children: _listAnimals(context));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
