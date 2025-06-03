import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text_indicator.dart';
import 'package:flutter/material.dart';

class ListAnimalReserves extends StatelessWidget {
  final Animal _animal;

  const ListAnimalReserves(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  List<Reserve> get _reserves => HelperJSON.getAnimalReserves(_animal).sorted(Reserve.sortById);

  Widget _buildReserve(Reserve reserve) {
    return WidgetTextIndicator(
      reserve.name,
      indicatorColor: Interface.primary,
      isShown: reserve.isFromDlc,
    );
  }

  List<Widget> _listReserves() {
    return _reserves.map((e) => _buildReserve(e)).toList();
  }

  Widget _buildWidgets() {
    return WidgetPadding.a30(child: Column(children: _listReserves()));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
