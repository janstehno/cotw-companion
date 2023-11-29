// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListAnimalReserves extends StatefulWidget {
  final int animalId;

  const ListAnimalReserves({
    Key? key,
    required this.animalId,
  }) : super(key: key);

  @override
  ListAnimalReservesState createState() => ListAnimalReservesState();
}

class ListAnimalReservesState extends State<ListAnimalReserves> {
  late final List<Reserve> _reserves = [];

  void _getReserves() {
    _reserves.clear();
    for (IdtoId iti in HelperJSON.animalsReserves) {
      if (iti.firstId == widget.animalId) {
        for (Reserve reserve in HelperJSON.reserves) {
          if (reserve.id == iti.secondId) {
            _reserves.add(reserve);
            break;
          }
        }
      }
    }
  }

  Widget _buildWidgets() {
    _getReserves();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _reserves.length,
        itemBuilder: (context, index) {
          Reserve reserve = _reserves[index];
          return WidgetTextDlc(
            text: reserve.getName(context.locale),
            dlc: reserve.isFromDlc,
          );
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
