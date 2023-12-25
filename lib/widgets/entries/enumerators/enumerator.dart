// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/edit/enumerators.dart';
import 'package:cotwcompanion/activities/entries/counters.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/entries/enumerators/entry.dart';
import 'package:flutter/material.dart';

class EntryEnumerator extends EntryEnumeratorsEntry {
  const EntryEnumerator({
    super.key,
    required super.index,
    required super.enumerator,
    required super.callback,
    required super.context,
  });

  @override
  State<StatefulWidget> createState() => EntryEnumeratorState();
}

class EntryEnumeratorState extends EntryEnumeratorsEntryState {
  @override
  void onTap() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityCounters(enumerator: widget.enumerator)));
    widget.callback();
  }

  @override
  void startToEnd() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditEnumerators(enumerator: widget.enumerator, callback: widget.callback)));
  }

  @override
  void endToStart() {
    setState(() {
      HelperEnumerator.removeEnumeratorOnIndex(widget.index);
      widget.callback();
    });
    super.endToStart();
  }

  @override
  void undo() {
    HelperEnumerator.undoRemoveEnumerator();
    widget.callback();
  }

  @override
  Widget buildEntry() {
    return Row(
      children: [
        Expanded(
          child: AutoSizeText(
            widget.enumerator.name,
            maxLines: 1,
            style: Interface.s18w500n(Interface.dark),
          ),
        ),
      ],
    );
  }
}
