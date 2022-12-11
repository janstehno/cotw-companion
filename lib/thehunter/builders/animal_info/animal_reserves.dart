// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/thehunter/widgets/entries/entry_with_dlc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';

class BuilderAnimalReserves extends StatefulWidget {
  final int animalID;

  const BuilderAnimalReserves({Key? key, required this.animalID}) : super(key: key);

  @override
  BuilderAnimalReservesState createState() => BuilderAnimalReservesState();
}

class BuilderAnimalReservesState extends State<BuilderAnimalReserves> {
  late final List<Reserve> _reserves = [];

  _getReserves() {
    _reserves.clear();
    for (IDtoID iti in JSONHelper.animalsReserves) {
      if (iti.getFirstID == widget.animalID) {
        for (Reserve r in JSONHelper.reserves) {
          if (r.getID == iti.getSecondID) {
            _reserves.add(r);
            break;
          }
        }
      }
    }
  }

  Widget _buildWidgets() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _reserves.length,
        itemBuilder: (context, index) {
          Reserve reserve = _reserves[index];
          return EntryWithDlc(text: reserve.getName(context.locale), dlc: reserve.getDlc);
        });
  }

  @override
  Widget build(BuildContext context) {
    _getReserves();
    return _buildWidgets();
  }
}
