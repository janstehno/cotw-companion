// Copyright (c) 2022 Jan Stehno

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_with_dlc.dart';

class BuilderAnimalCallers extends StatefulWidget {
  final int animalID;

  const BuilderAnimalCallers({Key? key, required this.animalID}) : super(key: key);

  @override
  BuilderAnimalCallersState createState() => BuilderAnimalCallersState();
}

class BuilderAnimalCallersState extends State<BuilderAnimalCallers> {
  late final List<Caller> _callers = [];

  _getCallers() {
    _callers.clear();
    for (IDtoID iti in JSONHelper.animalsCallers) {
      if (iti.getFirstID == widget.animalID) {
        for (Caller c in JSONHelper.callers) {
          if (c.getID == iti.getSecondID) {
            _callers.add(c);
            break;
          }
        }
      }
    }
  }

  Widget _buildWidgets() {
    return Column(children: [
      _callers.isNotEmpty
          //NOT EMPTY
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _callers.length,
              itemBuilder: (context, index) {
                Caller caller = _callers[index];
                return EntryWithDlc(text: caller.getName(context.locale), dlc: caller.getDlc);
              })
          //EMPTY
          : AutoSizeText(tr('none'), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400), maxLines: 1)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _getCallers();
    return _buildWidgets();
  }
}
