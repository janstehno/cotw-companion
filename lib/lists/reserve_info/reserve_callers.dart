// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/detail/caller.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/widgets/entries/reserve/caller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListReserveCallers extends StatefulWidget {
  final int reserveId;

  const ListReserveCallers({
    Key? key,
    required this.reserveId,
  }) : super(key: key);

  @override
  ListReserveCallersState createState() => ListReserveCallersState();
}

class ListReserveCallersState extends State<ListReserveCallers> {
  late final List<Animal> _animals = [];
  late final List<Caller> _callers = [];

  void _getCallers() {
    bool firstCallerAdded = false;
    for (IdtoId ar in HelperJSON.animalsReserves) {
      if (ar.secondId == widget.reserveId) {
        for (Animal animal in HelperJSON.animals) {
          if (animal.id == ar.firstId) {
            _animals.add(animal);
            break;
          }
        }
      }
    }
    for (Animal animal in _animals) {
      for (IdtoId iti in HelperJSON.animalsCallers) {
        if (animal.id == iti.firstId) {
          for (Caller caller in HelperJSON.callers) {
            if (caller.id == iti.secondId) {
              if (!firstCallerAdded && !_callers.contains(caller)) {
                _callers.add(caller);
                firstCallerAdded = true;
              } else {
                if (_callers[_callers.length - 1].strength < caller.strength) {
                  _callers.removeLast();
                  if (!_callers.contains(caller)) _callers.add(caller);
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
          Caller caller = _callers[index];
          return EntryReserveCaller(
              callerId: caller.id,
              color: Interface.dark,
              background: Utils.background(index),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivityDetailCaller(
                              caller: caller,
                            )));
              });
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
