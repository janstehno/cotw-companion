import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/detail/caller.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/parts/reserve/caller.dart';
import 'package:flutter/material.dart';

class ListReserveCallers extends StatelessWidget {
  final Reserve _reserve;

  const ListReserveCallers(
    Reserve reserve, {
    super.key,
  }) : _reserve = reserve;

  List<Animal> get _animals => HelperJSON.getReserveAnimals(_reserve.id);

  void _onTap(BuildContext context, Caller caller) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => ActivityDetailCaller(caller)),
    );
  }

  List<Caller> _initializeCallers() {
    Set<Caller> callers = {};
    bool firstCallerAdded = false;
    for (Animal animal in _animals) {
      List<Caller> animalCallers = HelperJSON.getAnimalCallers(animal);
      for (Caller caller in animalCallers) {
        if (!firstCallerAdded) {
          callers.add(caller);
          firstCallerAdded = true;
        } else if (callers.last.strength < caller.strength) {
          callers.remove(callers.last);
          callers.add(caller);
        }
        break;
      }
      firstCallerAdded = false;
    }
    return callers.sorted(Caller.sortByName);
  }

  Widget _buildEntry(int i, Caller caller, BuildContext context) {
    return WidgetReserveCaller(
      caller,
      background: Utils.backgroundAt(i),
      indicatorColor: Interface.primary,
      isShown: caller.isFromDlc,
      onTap: () => _onTap(context, caller),
    );
  }

  List<Widget> _listCallers(BuildContext context) {
    List<Caller> callers = _initializeCallers();
    return callers.mapIndexed((i, caller) => _buildEntry(i, caller, context)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(children: _listCallers(context));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
