// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListAnimalCallers extends StatefulWidget {
  final int animalId;

  const ListAnimalCallers({
    Key? key,
    required this.animalId,
  }) : super(key: key);

  @override
  ListAnimalCallersState createState() => ListAnimalCallersState();
}

class ListAnimalCallersState extends State<ListAnimalCallers> {
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
          : AutoSizeText(
              tr("none"),
              maxLines: 1,
              style: Interface.s16w300n(Interface.dark),
            )
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
