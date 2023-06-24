// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/idtoid.dart';

class BuilderAnimalCallers extends StatefulWidget {
  final int animalId;

  const BuilderAnimalCallers({
    Key? key,
    required this.animalId,
  }) : super(key: key);

  @override
  BuilderAnimalCallersState createState() => BuilderAnimalCallersState();
}

class BuilderAnimalCallersState extends State<BuilderAnimalCallers> {
  late final List<Caller> _callers = [];

  @override
  void initState() {
    _getCallers();
    super.initState();
  }

  void _getCallers() {
    _callers.clear();
    for (IdtoId iti in HelperJSON.animalsCallers) {
      if (iti.firstId == widget.animalId) {
        for (Caller caller in HelperJSON.callers) {
          if (caller.id == iti.secondId) {
            _callers.add(caller);
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
                return WidgetTextDlc(
                  text: caller.getName(context.locale),
                  dlc: caller.isFromDlc,
                );
              })
          //EMPTY
          : AutoSizeText(tr('none'),
              maxLines: 1,
              style: TextStyle(
                color: Interface.dark,
                fontSize: Interface.s20,
                fontWeight: FontWeight.w400,
              ))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
