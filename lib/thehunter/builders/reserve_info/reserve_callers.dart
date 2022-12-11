// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/caller_info.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/widgets/reserve_caller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderReserveCallers extends StatefulWidget {
  final int reserveID;

  const BuilderReserveCallers({Key? key, required this.reserveID}) : super(key: key);

  @override
  BuilderReserveCallersState createState() => BuilderReserveCallersState();
}

class BuilderReserveCallersState extends State<BuilderReserveCallers> {
  late final List<Animal> _animals = [];
  late final List<Caller> _callers = [];

  _getCallers() {
    bool firstCallerAdded = false;
    for (IDtoID ar in JSONHelper.animalsReserves) {
      if (ar.getSecondID == widget.reserveID) {
        for (Animal a in JSONHelper.animals) {
          if (a.getID == ar.getFirstID) {
            _animals.add(a);
            break;
          }
        }
      }
    }
    for (Animal a in _animals) {
      for (IDtoID ac in JSONHelper.animalsCallers) {
        if (a.getID == ac.getFirstID) {
          for (Caller c in JSONHelper.callers) {
            if (c.getID == ac.getSecondID) {
              if (!firstCallerAdded) {
                _callers.add(c);
                firstCallerAdded = true;
              } else {
                if (_callers[_callers.length - 1].getStrength < c.getStrength) {
                  _callers.removeLast();
                  _callers.add(c);
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
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _callers.length,
        itemBuilder: (context, index) {
          int callerID = _callers[index].getID;
          return EntryReserveCaller(
              background: index % 2 == 0 ? Values.colorEven : Values.colorOdd,
              color: Values.colorDark,
              callerID: callerID,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityCallerInfo(callerID: callerID)));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    _getCallers();
    return _buildWidgets();
  }
}
