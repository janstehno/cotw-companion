// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/info_caller.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/widgets/entries/reserve_caller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderReserveCallers extends StatefulWidget {
  final int reserveId;

  const BuilderReserveCallers({
    Key? key,
    required this.reserveId,
  }) : super(key: key);

  @override
  BuilderReserveCallersState createState() => BuilderReserveCallersState();
}

class BuilderReserveCallersState extends State<BuilderReserveCallers> {
  late final List<Animal> _animals = [];
  late final List<Caller> _callers = [];

  void _getCallers() {
    bool firstCallerAdded = false;
    for (IdtoId ar in HelperJSON.animalsReserves) {
      if (ar.secondId == widget.reserveId) {
        for (Animal a in HelperJSON.animals) {
          if (a.id == ar.firstId) {
            _animals.add(a);
            break;
          }
        }
      }
    }
    for (Animal a in _animals) {
      for (IdtoId ac in HelperJSON.animalsCallers) {
        if (a.id == ac.firstId) {
          for (Caller c in HelperJSON.callers) {
            if (c.id == ac.secondId) {
              if (!firstCallerAdded && !_callers.contains(c)) {
                _callers.add(c);
                firstCallerAdded = true;
              } else {
                if (_callers[_callers.length - 1].strength < c.strength) {
                  _callers.removeLast();
                  if (!_callers.contains(c)) _callers.add(c);
                }
              }
              break;
            }
          }
        }
      }
      firstCallerAdded = false;
    }
    _callers.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
  }

  Widget _buildWidgets() {
    _getCallers();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _callers.length,
        itemBuilder: (context, index) {
          int callerId = _callers[index].id;
          return EntryReserveCaller(
              background: index % 2 == 0 ? Interface.even : Interface.odd,
              color: Interface.dark,
              callerId: callerId,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivityCallerInfo(
                              callerId: callerId,
                            )));
              });
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
